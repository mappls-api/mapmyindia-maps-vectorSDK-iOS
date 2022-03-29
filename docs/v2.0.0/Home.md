![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# MapmyIndia Vector Maps Sample App (with SDK - Native) for iOS

**Welcome to the mapmyindia-maps-vectorSDK-iOS wiki!**

Explore the largest directory of APIs & SDKs for maps, routes and search.

Our APIs, SDKs, and live updating map data available for [238 nations](https://github.com/MapmyIndia/mapmyindia-rest-api/blob/master/docs/countryISO.md) give developers tools to build better mapping, navigation, and search experiences across platforms.

In this section you will find documentation for :-

- REST APIs module is a custom module for developers to consume our RESTful APIs within their applications, easily, and without having to develop such 
  functionality from scratch.
- Detailed information related to how to integrate MapmyIndia Widgets.
- Detailed information about integration of Vector iOS Map.


# [REST API Kit](#REST-API-Kit)

Rest API Kit is a iOS wrapper library on MapmyIndia's offered Rest APIs. For more detail go to [MapmyIndia's Rest APIs](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit).

# [Vector iOS Map](#Vector-iOS-Map)

## [Getting Started](#Getting-Started)

MapmyIndia Vector Maps SDK for IOS lets you easily add MapmyIndia Maps and web services to your own iOS app. MapmyIndia Maps SDK for iOS supports iOS SDK 9.0 and above and Xcode 10.1 or later. You can have a look at the map and features you will get in your own app by using the MapmyIndia Maps app for iOS. The SDK handles map tiles download and their display along with a bunch of controls and native gestures.

## [API Usage](#API-Usage)

Your MapmyIndia Vector Maps SDK usage needs a set of license keys ([get them here](http://www.mapmyindia.com/api/signup) ) and is governed by the API [terms and conditions](https://www.mapmyindia.com/api/terms-&-conditions). 
As part of the terms and conditions, you cannot remove or hide the MapmyIndia logo and copyright information in your project. 
Please see [branding guidelines](https://www.mapmyindia.com/api/advanced-maps/API-Branding-Guidelines.pdf) on MapmyIndia [website](https://www.mapmyindia.com/api) for more details.
The allowed SDK hits are described on the [plans](https://www.mapmyindia.com/api) page. Note that your usage is
shared between platforms, so the API hits you make from a web application, Android app or an iOS app all add up to your allowed daily limit.

## [Setup your Project](#Setup-your-Project)

#### Create a new project in Xcode.

- Install libraries to your project which can be done in two ways either Manual or using Cocoapods.

  Manual Procedure:
  -   Drag and drop the MapmyIndia Map SDK Framework (MapmyIndia.framework) to your project. It must be added in embedded binaries.
  -   Drag and drop the `MapmyIndiaAPIKit` Framework to your project. It must be added in embedded binaries. It is a dependent framework.
  -   In the Build Phases tab of the project editor, click the + button at the top and select .New Run Script Phase.. Enter the following code into the script text field: bash `${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/MapmyIndia.framework/strip-frameworks.sh`

  **Note:** History of frameworks can be found [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS#Version-History)

  Cocoapods:

  - Add below lines in pod file of your project:
    ```Cocoapods
    pod 'MapmyIndiaAPIKit'
    pod 'MapmyIndiaMaps'
    pod 'MapmyIndiaDirections'
    ```
  - Run pod install or pod update (to update existing pods)

  **Note:** History of Cocoapods can be found [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS#Cocoapods-Version-History)

-   For iOS9 or later, make this change to your  
    info.plist (Project target > info.plist > Add row and set key `NSLocationWhenInUseUsageDescription`,     `NSLocationAlwaysUsageDescription`)

Add your MapmyIndia Map API keys to your `AppDelegate` as follows

1. Add the following import statement.
#### Objective C
```objectivec
#import <MapmyIndiaAPIKit/MapmyIndiaAPIKit.h>
```
#### Swift
```swift
import MapmyIndiaAPIKit
```
2. Add the following import statement:
To initialize SDK you have to set required keys. You can achieve this using  
two ways:

**First Way (Preferred)**  
By adding following keys in `Info.plist` file of your project `MapmyIndiaSDKKey`, `MapmyIndiaRestKey`, `MapmyIndiaAtlasClientId`, `MapmyIndiaAtlasClientSecret`, `MapmyIndiaAtlasGrantType`.

**Second Way**  
You can also set these required keys programmatically. 
Add the following to your `application:didFinishLaunchingWithOptions`: method, replacing `restAPIKey` and `mapSDKKey` with your own API keys:

#### Objective C
```objectivec

[MapmyIndiaAccountManager setMapSDKKey:@"MAP SDK_KEY"];
[MapmyIndiaAccountManager setRestAPIKey:@"REST API_KEY"];
[MapmyIndiaAccountManager setAtlasClientId:@"ATLAS CLIENT_ID"];
[MapmyIndiaAccountManager setAtlasClientSecret:@"ATLAS CLIENT_SECRET"];
[MapmyIndiaAccountManager setAtlasGrantType:@"GRANT_TYPE"]; //always put client_credentials
[MapmyIndiaAccountManager setAtlasAPIVersion:@"1.3.11"]; // Optional; deprecated

```
#### Swift
```swift

MapmyIndiaAccountManager.setMapSDKKey("MAP SDK_KEY")
MapmyIndiaAccountManager.setRestAPIKey("REST API_KEY")
MapmyIndiaAccountManager.setAtlasClientId("ATLAS CLIENT_ID")
MapmyIndiaAccountManager.setAtlasClientSecret("ATLAS CLIENT_SECRET")
MapmyIndiaAccountManager.setAtlasGrantType("GRANT_TYPE") //always put client_credentials
MapmyIndiaAccountManager.setAtlasAPIVersion("1.3.11") // Optional; deprecated

```

## [Add a MapmyIndia Map](#Add-a-MapmyIndia-Map)

Map View on view controller can be added either using interface builder or programmatically.

#### By Interface Builder 
In a storyboard, add a view to your View Controller. In the Identity inspector, change its class to `MapmyIndiaMapView`.  
**Note :-** Map style url need to be set at the time of load map  
  
#### By Programmatically 
To add map on view Controller create an instance of `MapmyIndiaMapView`. and add this to view of `ViewController`.

#### Objective C
```objectivec
#import
@interface ViewController () <MapmyIndiaMapViewDelegate>
@end
@implementation ViewController
```
#### Swift
```swift
import MapmyIndia
  class ViewController: UIViewController, MapmyIndiaMapViewDelegate {
  override func viewDidLoad() {
  super.viewDidLoad()
  let mapView = MapmyIndiaMapView(frame: view.bounds)
  mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
  view.addSubview(mapView)
          }
     });
```

**Note**  Also add app transport security exception in Info.plist of your project.
Example:   `NSAppTransportSecurity  NSAllowsArbitraryLoads`

## [Map Interactions](#Map-Interactions)

### [Set Zoom Level](#Set-Zoom-Level)

Set zoom to 4 for country level display and 18 for house number display.

#### Objective C

```objectivec
[mapView setZoom:4];
```

#### Swift

```swift
mapView.zoomLevel = 4
```

### [Set Map Center](#Set-Map-Center)

To set Center of map reference code is below:

#### Objective C

```objectivec
[self.mapView setCenterCoordinate: CLLocationCoordinate2DMake(28.551438, 77.265119)];
```

#### Swift

```swift
mapView.centerCoordinate = CLLocationCoordinate2DMake(28.551438, 77.265119)
```

## [Map Features](#Map-Features)

### Current Location

To show user's current location on map, use property `.showsUserLocation.` and set its value to true.

#### Objective C

```objectivec
mapView.showsUserLocation = YES;
```

#### Swift

```swift
mapView.showsUserLocation = true
```

### Tracking Mode

To move map with user location change use property `userTrackingMode`. Its an enum property of type `.MGLUserTrackingMode.`. You can set any value from following:

- `followWithCourse`
- `followWithHeading`
- `none`

#### Objective C

```objectivec
self.mapView.userTrackingMode = MGLUserTrackingModeFollowWithCourse;
```

#### Swift

```swift
mapView.userTrackingMode = .followWithCourse
```

## [Map Events](#Map-Events)

The Map object should implement the methods of the `MapmyIndiaMapViewDelegate` protocol corresponding to the events you wish it to receive. This delegate can also be used to detect map overlays selection. Delegate handles gesture events, tap on annotation (marker) and map center coordinates.


### [Map Position Changes Events](#Map-Position-Changes-Events)
```
-(BOOL)mapView:(MGLMapView *)mapView shouldChangeFromCamera:(MGLMapCamera*)oldCamera toCamera:(MGLMapCamera *)newCamera;
-(BOOL)mapView:(MGLMapView *)mapView shouldChangeFromCamera:(MGLMapCamera*)oldCamera toCamera:(MGLMapCamera *)newCamera reason:(MGLCameraChangeReason)reason;
-(void)mapView:(MGLMapView *)mapView regionWillChangeAnimated:(BOOL)animated;
-(void)mapView:(MGLMapView *)mapView regionWillChangeWithReason:(MGLCameraChangeReason)reason animated:(BOOL)animated;
-(void)mapViewRegionIsChanging:(MGLMapView *)mapView;
-(void)mapView:(MGLMapView *)mapView regionIsChangingWithReason:(MGLCameraChangeReason)reason;
-(void)mapView:(MGLMapView *)mapView regionDidChangeAnimated:(BOOL)animated;`
-(void)mapView:(MGLMapView *)mapView regionDidChangeWithReason:(MGLCameraChangeReason)reason animated:(BOOL)animated;
```
### [Loading the Map Events](#Loading-the-Map-Events)

#### [-mapViewWillStartLoadingMap:]()
Tells the delegate that the map view will begin to load.

This method is called whenever the map view starts loading, including when a new style has been set and the map must reload.

**Objective-C**
```objectivec
- (void)mapViewWillStartLoadingMap:(nonnull MGLMapView *)mapView;  
```

**Swift**
```swift
optional func mapViewWillStartLoadingMap(_ mapView: MGLMapView)
```

#### [-mapViewDidFinishLoadingMap:]()

Tells the delegate that the map view has finished loading.

This method is called whenever the map view finishes loading, either after the initial load or after a style change has forced a reload.

**Objective-C**
```objectivec
- (void)mapViewDidFinishLoadingMap:(nonnull MGLMapView *)mapView;
```

**Swift**
```swift
optional func mapViewDidFinishLoadingMap(_ mapView: MGLMapView)
```

#### [-mapViewDidFailLoadingMap:withError:]()

Tells the delegate that the map view was unable to load data needed for displaying the map.

This method may be called for a variety of reasons, including a network connection failure or a failure to fetch the style from the server. You can use the given error message to notify the user that map data is unavailable.

**Objective-C**
```objectivec
- (void)mapViewDidFailLoadingMap:(nonnull MGLMapView *)mapView
                       withError:(nonnull NSError *)error;
```

**Swift**
```swift
optional func mapViewDidFailLoadingMap(_ mapView: MGLMapView, withError error: Error)
```

#### [-mapViewWillStartRenderingFrame:]()

Tells the delegate that the map view is about to redraw.

This method is called any time the map view needs to redraw due to a change in the viewpoint or style property transition. This method may be called very frequently. Therefore, your implementation of this method should be as lightweight as possible to avoid affecting performance.

**Objective-C**
```objectivec
- (void)mapViewWillStartRenderingFrame:(nonnull MGLMapView *)mapView;
```

**Swift**
```swift
optional func mapViewWillStartRenderingFrame(_ mapView: MGLMapView)
```

#### [-mapViewDidFinishRenderingFrame:fullyRendered:]()

Tells the delegate that the map view has just redrawn.

This method is called any time the map view needs to redraw due to a change in the viewpoint or style property transition. This method may be called very frequently. Therefore, your implementation of this method should be as lightweight as possible to avoid affecting performance.

**Objective-C**
```objectivec
- (void)mapViewDidFinishRenderingFrame:(nonnull MGLMapView *)mapView
                         fullyRendered:(BOOL)fullyRendered;
```

**Swift**
```swift
optional func mapViewDidFinishRenderingFrame(_ mapView: MGLMapView, fullyRendered: Bool)
```

#### [-mapViewDidBecomeIdle:]()

Tells the delegate that the map view is entering an idle state, and no more drawing will be necessary until new data is loaded or there is some interaction with the map.

**Objective-C**
```objectivec
- (void)mapViewDidBecomeIdle:(nonnull MGLMapView *)mapView;
```

**Swift**
```swift
optional func mapViewDidBecomeIdle(_ mapView: MGLMapView)
```

#### [-mapView:didFinishLoadingStyle:]()

Tells the delegate that the map has just finished loading a style.

This method is called during the initialization of the map view and after any subsequent loading of a new style.

**Objective-C**
```objectivec
- (void)mapView:(nonnull MGLMapView *)mapView
    didFinishLoadingStyle:(nonnull MGLStyle *)style;
```

**Swift**
```swift
optional func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle)
```


### [SDK Error Codes](#SDK-Error-Codes)

Map will fail with following error codes

- MAPS_SDK_KEY_MISSING=1; //when map sdk key is not passed
- REST_API_KEY_MISSING=2; //when rest api key is not passed
- ATLAS_CLIENT_ID_MISSING=3; //when atlas client id is not passed
- ATLAS_CLIENT_SECRET_MISSING=4; //when atlas client secret is not passed
- ATLAS_GRANT_TYPE_MISSING=5; //* //when atlas grant type is not passed
- AUTHENTICATION_FAILED=7; //when map fails to authenticate itself with MapmyIndia server
- UNKNOWN=8; // when map loading failed due to unknown error

### [Tracking User Location Events](#Tracking-User-Location-Events)

```
-(void)mapViewWillStartLocatingUser:(MGLMapView *)mapView;
-(void)mapViewDidStopLocatingUser:(MGLMapView *)mapView;
-(void)mapView:(MGLMapView *)mapView didUpdateUserLocation:(nullableMGLUserLocation *)userLocation;
-(void)mapView:(MGLMapView *)mapView didFailToLocateUserWithError:(NSError*)error;
-(void)mapView:(MGLMapView *)mapView didChangeUserTrackingMode:(MGLUserTrackingMode)mode animated:(BOOL)animated;
```

### [Appearance of Annotations Events](#Appearance-of-Annotations-Events)

```
-(nullable MGLAnnotationImage *)mapView:(MGLMapView *)mapView imageForAnnotation:(id <MGLAnnotation>)annotation;
-(CGFloat)mapView:(MGLMapView *)mapView alphaForShapeAnnotation:(MGLShape*)annotation;
-(UIColor *)mapView:(MGLMapView *)mapView strokeColorForShapeAnnotation:(MGLShape *)annotation;
-(UIColor *)mapView:(MGLMapView *)mapView fillColorForPolygonAnnotation:(MGLPolygon *)annotation;
-(CGFloat)mapView:(MGLMapView *)mapView lineWidthForPolylineAnnotation:(MGLPolyline *)annotation;
```

### [Annotation Views Events](#Annotation-Views-Events)

```
-(nullable MGLAnnotationView *)mapView:(MGLMapView *)mapView viewForAnnotation:(id <MGLAnnotation>)annotation;
-(void)mapView:(MGLMapView *)mapView didAddAnnotationViews: (NS_ARRAY_OF(MGLAnnotationView *) *)annotationViews;
```

### [Selecting Annotations Events](#Selecting-Annotations-Events)
```
-(void)mapView:(MGLMapView *)mapView didSelectAnnotation:(id <MGLAnnotation>)annotation;
-(void)mapView:(MGLMapView *)mapView didDeselectAnnotation:(id <MGLAnnotation>)annotation;
-(void)mapView:(MGLMapView *)mapView didSelectAnnotationView: (MGLAnnotationView *)annotationView;
-(void)mapView:(MGLMapView *)mapView didDeselectAnnotationView: (MGLAnnotationView *)annotationView;
```

### [Callout Views Events](#Callout-Views-Events)

```
-(BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation;
-(nullable id <MGLAnnotation>)mapView:(MGLMapView *)mapView calloutViewForAnnotation:(id <MGLAnnotation>)annotation;
-(nullable UIView *)mapView:(MGLMapView *)mapView leftCalloutAccessoryViewForAnnotation:(id  <MGLAnnotation>)annotation;
-(nullable UIView *)mapView:(MGLMapView *)mapView rightCalloutAccessoryViewForAnnotation:(id <MGLAnnotation>)annotation;
-(void)mapView:(MGLMapView *)mapView annotation:(id <MGLAnnotation>)annotation calloutAccessoryControlTapped:(UIControl *)control;
-(void)mapView:(MGLMapView *)mapView tapOnCalloutForAnnotation:(id <MGLAnnotation>)annotation;
```

## [Map Tap Events](#Map-Tap-Events)

### [Single Tap Gesture](#Single-Tap-Gesture)

To capture single tap on map events add a tap gesture to instance of `MapmyIndiaMapView`. Tapped CGPoint on map can be converted to CLLocationCoordinate object. Also if there is any mareker in tapped area that can also be retrieved. Code for reference to explain above features is below:

#### Objective C

```objectivec
UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
initWithTarget:self action:@selector(didTapPress:)];
[self.mapView addGestureRecognizer:singleTap];

-(void)didTapPress:(UILongPressGestureRecognizer *)gesture {
  if(UIGestureRecognizerStateEnded == gesture.state) {
    CGPoint touchPoint = [sender locationInView:self.mapView];

    // Convert tapped area point to a CLLocationCoordinate object
    CLLocationCoordinate2D location = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView;

    // Also existing annotation or features can be checked on tapped area point
    NSArray<id <MGLFeature>> * visibleFeatures = [self.mapView visibleFeaturesAtPoint: touchPoint];
    if (visibleFeatures.count > 0) {

    }
  }
}
```

#### Swift

```swift
let singleTap = UITapGestureRecognizer(target: self, action:
 #selector(didTapMap(tap:)))
 mapView.addGestureRecognizer(singleTap)
 @objc func didTapMap(tap: UITapGestureRecognizer) {
 if tap.state == .ended {
    let point = tap.location(in: mapView)

    // Convert tapped area point to a CLLocationCoordinate object
    let coordinate = mapView.convert(point, toCoordinateFrom: mapView)

    // Also existing annotation or features can be checked on tapped area point
    let visibleFeatures = mapView.visibleFeatures(at: point)
    if visibleFeatures.count > 0 {

    }
  }
}
```

### [Long Tap Gesture](#Long-Tap-Gesture)

To capture long press on map events add a long press gesture to instance of `MapmyIndiaMapView`.

#### Objective C

```objectivec
UILongPressGestureRecognizer *longPress =  [[UILongPressGestureRecognizer
alloc] initWithTarget:self action:@selector(didLongPress:)];
[longPress setMinimumPressDuration:1.0];

[self.mapView addGestureRecognizer:longPress];
-(void)didLongPress:(UILongPressGestureRecognizer *)gesture {
  if(UIGestureRecognizerStateEnded == gesture.state) {
    CGPoint touchPoint = [sender locationInView:self.mapView];

    // Convert tapped area point to a CLLocationCoordinate object
    CLLocationCoordinate2D location = [self.mapView convertPoint:touchPoint toCoordinateFromView:self.mapView;

    // Also existing annotation or features can be checked on tapped area point
    NSArray<id <MGLFeature>> * visibleFeatures = [self.mapView visibleFeaturesAtPoint: touchPoint];
    if (visibleFeatures.count > 0) {

    }
  }
}
```

#### Swift

```swift
let longPress = UILongPressGestureRecognizer(target: self, action:
#selector(didLongPress(tap:)))
mapView.addGestureRecognizer(longPress)
@objc func didLongPress(tap: UILongPressGestureRecognizer) {
if tap.state == .ended {
    let point = tap.location(in: mapView)

    // Convert tapped area point to a CLLocationCoordinate object
    let coordinate = mapView.convert(point, toCoordinateFrom: mapView)

    // Also existing annotation or features can be checked on tapped area point
    let visibleFeatures = mapView.visibleFeatures(at: point)
    if visibleFeatures.count > 0 {

    }
  }
}
```

## [Map Overlays](#Map-Overlays)

### Add marker
To show an annotation on map create an instance of `MGLPointAnnotation` and add that object to instance of `MapmyIndiaMapView` using method `addAnnotation.`.

After creating instance of `MGLPointAnnotation`, set coordinate and title property values.

#### Objective C
```objectivec
MGLPointAnnotation *point = [[MGLPointAnnotation alloc] init];
point.coordinate = CLLocationCoordinate2DMake(28.550834, 77.268918);
point.title = @"Annotation";
[self.mapView addAnnotation:point];
```
#### Swift
```swift
var point = MGLPointAnnotation()
point.coordinate = CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918)
point.title = "Annotation"
mapView.addAnnotation(point)
```

### Remove marker

#### Objective C
```objectivec
[self.mapView removeAnnotation:point];
```
#### Swift
```swift
mapView.removeAnnotation(point)
```

### Custom Marker (Change Default Marker Icon)

To change image for default marker you can use delegate methods of protocol  
`MapmyIndiaMapViewDelegate`. 
Either you can override whole view of marker by using below method of delegate:
```
-(nullable MGLAnnotationView *)mapView:(MGLMapView *)mapView viewForAnnotation:(id <MGLAnnotation>)annotation;
```
or you can override image of marker by using below method of delegate:
```
-(nullable MGLAnnotationImage *)mapView:(MGLMapView *)mapView imageForAnnotation:(id <MGLAnnotation>)annotation;
```

### Show Info Window (Callout)

To enable info window on tap of marker return true from below delegate method:

```objectivec
- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation;
```

### Custom Info Window(#Custom-Info-Window)

To change default callout view of annotation use delegate function of `MapmyIndiaMapViewDelegate.` protocol and return custom view of callout from that function.

```swift
func mapView(_ mapView: MGLMapView, calloutViewFor annotation:
MGLAnnotation) -> MGLCalloutView? {
return CustomCalloutView(representedObject: annotation)
}
```

To create custom callout view create a class inherited from `.MGLCalloutView.` and `.UIView.`. Override draw function of `UIView` to design your own callout view.

## [Polylines](#Polylines)

### Add a Polyline

To show a polyline on map create an instance of `MGLPolyline` and add that object to instance of `MGLMapView` using method `.addAnnotation.`.

To create instance of `MGLPolyline` an array of `CLLocationCoordinate2D` will be required so first create an array of `CLLocationCoordinate2D`.

#### Objective C

```objectivec
CLLocationCoordinate2D coordinates[] = {
CLLocationCoordinate2DMake(28.550834, 77.268918),
CLLocationCoordinate2DMake(28.551059, 77.268890),
CLLocationCoordinate2DMake(28.550938, 77.267641),
CLLocationCoordinate2DMake(28.551764, 77.267575),
CLLocationCoordinate2DMake(28.552068, 77.267599),
CLLocationCoordinate2DMake(28.553836, 77.267450),
};
NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
MGLPolyline *polyline = [MGLPolyline polylineWithCoordinates:coordinates count:numberOfCoordinates];
[self.mapView addAnnotation:polyline];
```
#### Swift

```swift
var coordinates = [
CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918),
CLLocationCoordinate2D(latitude: 28.551059, longitude: 77.268890),
CLLocationCoordinate2D(latitude: 28.550938, longitude: 77.267641),
CLLocationCoordinate2D(latitude: 28.551764, longitude: 77.267575),
CLLocationCoordinate2D(latitude: 28.552068, longitude: 77.267599),
CLLocationCoordinate2D(latitude: 28.553836, longitude: 77.267450),
]
let polyline = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
mapView.addAnnotation(polyline)
```

### [Remove a Polyline](#Remove-a-Polyline)

#### Objective C

```objectivec
[self.mapView removeAnnotation:polyline];
```

#### Swift

```swift
mapView.removeAnnotation(polyline)
```

### [Polyline Width](#Polyline-Width)

Line width in points can be set when rendering the outline of a polyline annotation. It cab be achieve by using delegate method `lineWidthForPolylineAnnotation`.

By default, the polyline is outlined with a line 3.0 points wide.

#### Objective C

```objectivec
- (CGFloat)mapView:(MGLMapView *)mapView lineWidthForPolylineAnnotation:(MGLPolyline *)annotation
{
  return 10.0;
}
```

#### Swift

```swift
func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
  return 10.0
}
```

## [Polygons](#Polygons)

### [Add a Polygon](#Add-a-Polygon)

To show a polygon on map create an instance of `MGLPolygon` and add that object to instance of `MGLMapView` using method `.addAnnotation.`.

To create instance of `MGLPolygon` an array of `CLLocationCoordinate2D` will be required so first create an array of `CLLocationCoordinate2D`.

#### Objective C

```objectivec
CLLocationCoordinate2D coordinates[] = {
CLLocationCoordinate2DMake(28.550834, 77.268918),
CLLocationCoordinate2DMake(28.551059, 77.268890),
CLLocationCoordinate2DMake(28.550938, 77.267641),
CLLocationCoordinate2DMake(28.551764, 77.267575),
CLLocationCoordinate2DMake(28.552068, 77.267599),
CLLocationCoordinate2DMake(28.553836, 77.267450),
};
NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
MGLPolygon *polygon = [MGLPolygon polygonWithCoordinates:coordinates count:numberOfCoordinates];//
[self.mapView addAnnotation:polygon];
```

#### Swift

```swift
var coordinates = [
CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918),
CLLocationCoordinate2D(latitude: 28.551059, longitude: 77.268890),
CLLocationCoordinate2D(latitude: 28.550938, longitude: 77.267641),
CLLocationCoordinate2D(latitude: 28.551764, longitude: 77.267575),
CLLocationCoordinate2D(latitude: 28.552068, longitude: 77.267599),
CLLocationCoordinate2D(latitude: 28.553836, longitude: 77.267450),
]
let polygon = MGLPolygon(coordinates: &coordinates, count: UInt(coordinates.count))
mapView.addAnnotation(polygon)
```


### [Remove a Polygon](#Remove-a-Polygon)

#### Objective C

```objectivec
[self.mapView removeAnnotation:polygon];
```

#### Swift

```swift
mapView.removeAnnotation(polygon)
```

## [Map Camera](#Map-Camera)

### [Fit Map Camera](#Fit-Map-Camera)

`showAnnotations` function sets the visible region so that the map displays the specified annotations.

#### Swift

```swift
mapView.showAnnotations(annotations, animated: true)
```

### [Create Camera For Shape](#Create-Camera-For-Shape)

A camera object that best fits the given shape with some additional padding on each side while looking in the specified direction can be retrieved using function `cameraThatFitsShape` of MapmyIndiaMapView.

After creating a camera object using above function it can be set to fit map visible area.

#### Objective C

```objectivec
CLLocationCoordinate2D coordinates[] = {
  CLLocationCoordinate2DMake(28.550834, 77.268918),
  CLLocationCoordinate2DMake(28.551059, 77.268890),
  CLLocationCoordinate2DMake(28.550938, 77.267641),
  CLLocationCoordinate2DMake(28.551764, 77.267575),
  CLLocationCoordinate2DMake(28.552068, 77.267599),
  CLLocationCoordinate2DMake(28.553836, 77.267450),
};

NSUInteger numberOfCoordinates = sizeof(coordinates) / sizeof(CLLocationCoordinate2D);
MGLPolygon *polygon = [MGLPolygon polygonWithCoordinates:coordinates count:numberOfCoordinates];//
[self.mapView addAnnotation:polygon];
MGLMapCamera *shapeCam = [self.mapView cameraThatFitsShape:polygon direction:(0) edgePadding:UIEdgeInsetsMake(20, 20, 20, 20)];
[self.mapView setCamera:shapeCam];
```

#### Swift

```swift
var coordinates = [
  CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918),
  CLLocationCoordinate2D(latitude: 28.551059, longitude: 77.268890),
  CLLocationCoordinate2D(latitude: 28.550938, longitude: 77.267641),
  CLLocationCoordinate2D(latitude: 28.551764, longitude: 77.267575),
  CLLocationCoordinate2D(latitude: 28.552068, longitude: 77.267599),
  CLLocationCoordinate2D(latitude: 28.553836, longitude: 77.267450),
]
let polyline = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
let shapeCam = mapView.cameraThatFitsShape(polyline, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
mapView.setCamera(shapeCam, animated: false)
```

## [Miscellaneous](#Miscellaneous)

### [Shape Stroke Color](#Shape-Stroke-Color)

Color of `polyline` and stroke color of `polygon` can be changed by using delegate method `strokeColorForShapeAnnotation`.

The default stroke color is the map view’s tint color.

#### Objective C

```objectivec
- (UIColor *)mapView:(MGLMapView *)mapView strokeColorForShapeAnnotation:(MGLShape *)annotation {
    return [UIColor redColor];
}
```

#### Swift

```swift
func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
  return .red
}
```

### [Shape Fill Color](#Shape-Fill-Color)

Fill Color of `polygon` can be changed by using delegate method `fillColorForPolygonAnnotation`.

The default fill color is the map view’s tint color. 

#### Objective C

```objectivec
- (UIColor *)mapView:(MGLMapView *)mapView fillColorForPolygonAnnotation:(MGLPolygon *)annotation {
    return [UIColor redColor];
}
```

#### Swift

```swift
func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
  return UIColor.red
}
```

### [Shape Opacity](#Shape-Opacity)

To change opacity of a shape i.e polyline or polygon, delegate method `alphaForShapeAnnotation` can be used.

It sets the opacity of an entire shape, inclusive of its stroke and fill.

#### Objective C

```objectivec
- (CGFloat)mapView:(MGLMapView *)mapView alphaForShapeAnnotation:(MGLShape *)annotation
{
  return 0.5;
}
```

#### Swift

```swift
func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
  return 0.5
}
```

### [Safety Status Strip](#Safety-Status-Strip)

A safety status strip can be show on map based on user's location. COVID-19 status will be shown on map currently, It will show whether user's location lies in a containment zone or not and conaintment zone info like Containment Zone Name, District etc. For more info about how to use go to [Safety Strip](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/MapmyIndia-Safety-Strip).

### [Cluster Based Authentication](#Cluster-Based-Authentication)

Map SDK can be configured such that it can work only for specified unique identifier of a device and will show an error accordingly.

#### [Set Cluster Device](#Set-Cluster-Device)

Cluster Identifier can be set and retrieve using singelton class `MapmyIndiaAccountManager` which is part of Map SDK's dependency `MapmyIndiaAPIKit`.

Below is code for reference to set and get cluster identifier.

#### Objective C

```objectivec
// Set Cluster Identifier
[MapmyIndiaAccountManager setClusterId:@"YOUR_CLUSTER_DEVICE_IDENTIFIER"];

// Get Cluster Identifier
NSString * clusterId = [MapmyIndiaAccountManager clusterId];
```

#### Swift

```swift
// Set Cluster Identifier
MapmyIndiaAccountManager.setClusterId("YOUR_CLUSTER_DEVICE_IDENTIFIER")

// Get Cluster Identifier
let clusterId = MapmyIndiaAccountManager.clusterId()
```

For any queries and support, please contact:

![Email](https://www.google.com/a/cpanel/mapmyindia.co.in/images/logo.gif?service=google_gsuite) 
Email us at [apisupport@mapmyindia.com](mailto:apisupport@mapmyindia.com)

![](https://www.mapmyindia.com/api/img/icons/stack-overflow.png)
[Stack Overflow](https://stackoverflow.com/questions/tagged/mapmyindia-api)
Ask a question under the mapmyindia-api

![](https://www.mapmyindia.com/api/img/icons/support.png)
[Support](https://www.mapmyindia.com/api/index.php#f_cont)
Need support? contact us!

![](https://www.mapmyindia.com/api/img/icons/blog.png)
[Blog](http://www.mapmyindia.com/blog/)
Read about the latest updates & customer stories

> © Copyright 2019. CE Info Systems Pvt. Ltd. All Rights Reserved. | [Terms & Conditions](http://www.mapmyindia.com/api/terms-&-conditions)
> MapmyIndia-gl-native copyright (c) 2014-2019 MapmyIndia.
