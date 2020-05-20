//
//  MultiplePolylinesExample.swift
//  MapDemo
//
//  Created by apple on 20/05/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit
import MapmyIndiaMaps

class CustomColorPolyline: MGLPolyline {
    var color: UIColor?
}

@objc(MultiplePolylinesExample_Swift)
class MultiplePolylinesExample_Swift: UIViewController, MapmyIndiaMapViewDelegate {
    var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .darkGray
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918), zoomLevel: 15, animated: false)
        
        mapView.delegate = self
        view.addSubview(mapView)
        
        var polyline1Coordinates = [
            CLLocationCoordinate2DMake(28.55106676597232, 77.26892899885115),
            CLLocationCoordinate2DMake(28.55106440994275, 77.26889010682044),
            CLLocationCoordinate2DMake(28.551018098110074, 77.26849307765656),
            CLLocationCoordinate2DMake(28.55101574207941, 77.2684548561781),
        ]
        let polyline1 = CustomColorPolyline(coordinates: &polyline1Coordinates, count: UInt(polyline1Coordinates.count))
        polyline1.color = .red
        mapView.addAnnotation(polyline1)
        
        var polyline2Coordinates = [
            CLLocationCoordinate2DMake(28.55101574207941, 77.2684548561781),
            CLLocationCoordinate2DMake(28.551012208033324, 77.26838645984822),
            CLLocationCoordinate2DMake(28.551003961925307, 77.26834823836975),
            CLLocationCoordinate2DMake(28.551001016886577, 77.26829057087593),
            CLLocationCoordinate2DMake(28.550998071847772, 77.26824497332268),
            CLLocationCoordinate2DMake(28.550995715816647, 77.26821412791901),
            CLLocationCoordinate2DMake(28.55099041474647, 77.26814506103688),
            CLLocationCoordinate2DMake(28.55098334665247, 77.26808940519982),
            CLLocationCoordinate2DMake(28.550976867565875, 77.26802771439247),
            CLLocationCoordinate2DMake(28.550971566494756, 77.26797205855542),
            CLLocationCoordinate2DMake(28.550967443439227, 77.26790299167328),
        ]
        let polyline2 = CustomColorPolyline(coordinates: &polyline2Coordinates, count: UInt(polyline2Coordinates.count))
        polyline2.color = .blue
        mapView.addAnnotation(polyline2)
        
        var polyline3Coordinates = [
            CLLocationCoordinate2DMake(28.550967443439227, 77.26790299167328),
            CLLocationCoordinate2DMake(28.550962142367624, 77.26784063031369),
            CLLocationCoordinate2DMake(28.550959786335714, 77.26777759840184),
            CLLocationCoordinate2DMake(28.550952718239657, 77.26770115544491),
            CLLocationCoordinate2DMake(28.550946828159244, 77.26762471248799),
            CLLocationCoordinate2DMake(28.550975100542214, 77.26759386708432),
            CLLocationCoordinate2DMake(28.551051671541288, 77.26759386708432),
            CLLocationCoordinate2DMake(28.55111781923686, 77.26758736520617),
            CLLocationCoordinate2DMake(28.551180253971072, 77.2675927296242),
            CLLocationCoordinate2DMake(28.551240332642607, 77.26758870631068),
            CLLocationCoordinate2DMake(28.551305123328397, 77.26758870631068),
            CLLocationCoordinate2DMake(28.551367557951572, 77.26759138851969),
            CLLocationCoordinate2DMake(28.55142881452698, 77.26759004741518),
            CLLocationCoordinate2DMake(28.551486537036585, 77.26758870631068),
            CLLocationCoordinate2DMake(28.551547793542763, 77.26758334189265),
            CLLocationCoordinate2DMake(28.551608054290263, 77.26758757272933),
            CLLocationCoordinate2DMake(28.55166577670163, 77.2675835494158),
        ]
        let polyline3 = CustomColorPolyline(coordinates: &polyline3Coordinates, count: UInt(polyline3Coordinates.count))
        polyline3.color = .black
        mapView.addAnnotation(polyline3)
        
        var polyline4Coordinates = [
            CLLocationCoordinate2DMake(28.55166577670163, 77.2675835494158),
            CLLocationCoordinate2DMake(28.55172821111094, 77.2675835494158),
            CLLocationCoordinate2DMake(28.55178946747653, 77.26756343284819),
            CLLocationCoordinate2DMake(28.551814205614082, 77.26753661075804),
            CLLocationCoordinate2DMake(28.551869932338732, 77.26751627403132),
            CLLocationCoordinate2DMake(28.551928832611658, 77.26752029734484),
            CLLocationCoordinate2DMake(28.55196888477843, 77.267547119435),
            CLLocationCoordinate2DMake(28.55200540291719, 77.26756857710711),
            CLLocationCoordinate2DMake(28.55202778499599, 77.26759539919726),
            CLLocationCoordinate2DMake(28.55204781106247, 77.2676208801829),
            CLLocationCoordinate2DMake(28.552102171740508, 77.26760995494351),
            CLLocationCoordinate2DMake(28.55216224988606, 77.26760190831646),
            CLLocationCoordinate2DMake(28.55222350599917, 77.26759252058491),
            CLLocationCoordinate2DMake(28.552280050071943, 77.2675911794804),
            CLLocationCoordinate2DMake(28.552340128115997, 77.2675898383759),
            CLLocationCoordinate2DMake(28.552393138126405, 77.26757910953984),
            CLLocationCoordinate2DMake(28.552450860107378, 77.26757374512181),
            CLLocationCoordinate2DMake(28.5525131552647, 77.26756506648326),
            CLLocationCoordinate2DMake(28.552574411173666, 77.26756238427424),
            CLLocationCoordinate2DMake(28.552636845044212, 77.26755836096072),
        ]
        let polyline4 = CustomColorPolyline(coordinates: &polyline4Coordinates, count: UInt(polyline4Coordinates.count))
        polyline4.color = .green
        mapView.addAnnotation(polyline4)
        
        mapView.showAnnotations([polyline1, polyline2, polyline3, polyline4], edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: false, completionHandler: nil)
    }
}

//MARK: MapmyIndiaMapViewDelegate Implementation
extension MultiplePolylinesExample_Swift {
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        if annotation is CustomColorPolyline {
            if let polyline = annotation as? CustomColorPolyline, let color = polyline.color {
                return color
            }
        }
        return mapView.tintColor
    }
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        return 10.0
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 0.7
    }
}
