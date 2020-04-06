//
//  HighlightPointExample.m
//  MapDemo
//
//  Created by apple on 21/08/19.
//  Copyright © 2019 MMI. All rights reserved.
//

#import "HighlightPointExample.h"
@import MapmyIndiaMaps;

@interface HighlightPointExample () <MapmyIndiaMapViewDelegate>
@property (nonatomic) MapmyIndiaMapView *mapView;
@end

@implementation HighlightPointExample
    NSString * const sourceIdentifier = @"mySource";
    NSString * const layerIdentifier = @"myLayer";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mapView = [[MapmyIndiaMapView alloc] initWithFrame:self.view.bounds];
    self.mapView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.mapView.tintColor = [UIColor darkGrayColor];
    
    [self.mapView setCenterCoordinate:CLLocationCoordinate2DMake(28.543253, 77.261647) zoomLevel:11 animated:NO];
    self.mapView.delegate = self;
    
    [self.view addSubview:self.mapView];
    
    
    
    UIStepper *myUIStepper = [[UIStepper alloc] init];
    myUIStepper.value = 100;
    myUIStepper.minimumValue = 10;
    myUIStepper.stepValue = 10;
    myUIStepper.maximumValue = 200;
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:myUIStepper];
    
    // Add a function handler to be called when UIStepper value changes
    [myUIStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventValueChanged];
}
    
- (void) stepperValueChanged:(UIStepper*) sender {
    if (self.mapView.style) {
        MGLSource * _Nullable source = [self.mapView.style sourceWithIdentifier:sourceIdentifier];
        if (source) {
            MGLShapeSource *shapeSource = (MGLShapeSource *) source;
            if (shapeSource) {
                MGLPolygonFeature * sourceFeatures = [self getSourceFeatures:CLLocationCoordinate2DMake(28.550834, 77.268918) withMeterRadius:sender.value];
                if (sourceFeatures) {
                    shapeSource.shape = sourceFeatures;
                }
                
                MGLPolygon *shape = [sourceFeatures.interiorPolygons firstObject];
                if (shape) {
                    MGLMapCamera *shapeCam = [self.mapView cameraThatFitsShape:shape direction:0 edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)];
                    [self.mapView setCamera:shapeCam];
                }
            }
        }
    }
}
    
- (MGLPolygonFeature * _Nullable)getSourceFeatures:(CLLocationCoordinate2D)coordinate withMeterRadius:(double)radius
{
    if(CLLocationCoordinate2DIsValid(coordinate) && radius >=0) {
        NSUInteger degreesBetweenPoints = 8; //45 sides
        NSUInteger numberOfPoints = floor(360 / degreesBetweenPoints);
        double distRadians = radius / 6371000.0; // earth radius in meters
        double centerLatRadians = coordinate.latitude * M_PI / 180;
        double centerLonRadians = coordinate.longitude * M_PI / 180;
        CLLocationCoordinate2D coordinates[numberOfPoints]; //array to hold all the points
        for (NSUInteger index = 0; index < numberOfPoints; index++) {
            double degrees = index * degreesBetweenPoints;
            double degreeRadians = degrees * M_PI / 180;
            double pointLatRadians = asin( sin(centerLatRadians) * cos(distRadians) + cos(centerLatRadians) * sin(distRadians) * cos(degreeRadians));
            double pointLonRadians = centerLonRadians + atan2( sin(degreeRadians) * sin(distRadians) * cos(centerLatRadians),
                                                              cos(distRadians) - sin(centerLatRadians) * sin(pointLatRadians) );
            double pointLat = pointLatRadians * 180 / M_PI;
            double pointLon = pointLonRadians * 180 / M_PI;
            CLLocationCoordinate2D point = CLLocationCoordinate2DMake(pointLat, pointLon);
            coordinates[index] = point;
        }
        //[self.circleFeature setCoordinates:coordinates count:numberOfPoints];
        MGLPolygonFeature *holePolygon = [MGLPolygonFeature polygonWithCoordinates:coordinates count:numberOfPoints];
        MGLCoordinateQuad visibleQuadCoordinates = MGLCoordinateQuadFromCoordinateBounds(MGLCoordinateBoundsMake(CLLocationCoordinate2DMake(6,60), CLLocationCoordinate2DMake(35, 100)));
        CLLocationCoordinate2D visibleCoordinates[4];
        visibleCoordinates[0] = visibleQuadCoordinates.topLeft;
        visibleCoordinates[1] = visibleQuadCoordinates.topRight;
        visibleCoordinates[2] = visibleQuadCoordinates.bottomRight;
        visibleCoordinates[3] = visibleQuadCoordinates.bottomLeft;
        
        MGLPolygonFeature * polygonFeature = [MGLPolygonFeature polygonWithCoordinates:visibleCoordinates count:4 interiorPolygons:@[holePolygon]];
        return polygonFeature;
    }
    
    return nil;
}
    
- (void)drawShapeCollection {
    if (self.mapView.style) {
        MGLPolygonFeature * sourceFeatures = [self getSourceFeatures:CLLocationCoordinate2DMake(28.550834, 77.268918) withMeterRadius:100];
        if (sourceFeatures) {
            MGLShapeSource *shapeSource = [[MGLShapeSource alloc] initWithIdentifier:sourceIdentifier shape:sourceFeatures options:nil];
            [self.mapView.style addSource:shapeSource];
            
            MGLFillStyleLayer * polygonLayer = [[MGLFillStyleLayer alloc] initWithIdentifier:layerIdentifier source:shapeSource];
            polygonLayer.fillColor = [NSExpression expressionForConstantValue:[UIColor redColor]];
            polygonLayer.fillOpacity = [NSExpression expressionForConstantValue:@0.5];
            polygonLayer.fillOutlineColor = [NSExpression expressionForConstantValue:[UIColor blackColor]];
            
            [self.mapView.style addLayer:polygonLayer];
            
            MGLPolygon *shape = [sourceFeatures.interiorPolygons firstObject];
            if (shape) {
                MGLMapCamera *shapeCam = [self.mapView cameraThatFitsShape:shape direction:0 edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)];
                [self.mapView setCamera:shapeCam];
            }
        }
    } else {
        return;
    }
}
    
- (void)mapView:(MGLMapView *)mapView didFinishLoadingStyle:(MGLStyle *)style {
    [self drawShapeCollection];
}

@end
