![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# MapmyIndia Vector Maps Sample App (with SDK - Native) for iOS

**This is sample application created to demonstrate features of different libraries available on iOS plaform. Such as MapmyIndiaMaps, MapmyIndiaAPIKit, MapmyIndiaDirections, MapmyIndiaFeedbackKit. To use this sample download latest frameworks from Versions list below and copy them in "Dependencies" folder of application**
<br/>

**Easy To Integrate Maps & Location APIs & SDKs For Web & Mobile Applications**

Powered with India's most comprehensive and robust mapping functionalities.
**Now Available**  for Srilanka, Nepal, Bhutan, Myanmar and Bangladesh

1. You can get your api key to be used in this document here: [https://www.mapmyindia.com/api/signup](https://www.mapmyindia.com/api/signup)

2. The sample code is provided to help you understand the basic functionality of MapmyIndia maps & REST APIs working on iOS native development platform. 

## Version History

| Version | Last Updated | Author | Download | Compatibility |
| ---- | ---- | ---- | ---- | ---- |
| 4.9.0 | 29 January 2020 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/GFECUS5KIZTA/MapmyIndia_Vector_Map_SDK_withSample_v4.9.0_29012020.zip) | XCode 11.2.1+;
| 4.9.0 | 06 December 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/XQE4GJ9SJE96/MapmyIndia_Vector_Map_SDK_withSample_v4.9.0_20112019.zip) | XCode 11.2.1; Introducing Text Search API & Indoor Mapping Feature. Adding feedback module again with latest SDK
| 4.9.0 | 20 November 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/LC7CJ4J2JQR3/MapmyIndia_Vector_Map_SDK_withSample_v4.9.0_20112019.zip) | XCode 11.1 to 11.2.1; removed feedback module for now.
| 4.9.0 | 30 October 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | ~~Download~~ | XCode 11; Myanmar added as region
| 4.9.0 | 09 October 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/55BZL282FLV6/MapmyIndia_Vector_Map_SDK_withSample_v4.9.0_09102019.zip) | XCode 11
| 4.9.0 | 20 May 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/17DTMF8VC2JV/MapmyIndia_Vector_Map_SDK_withSample_v4.9.0_20052019.zip) | XCode 10.2
| 4.9.0 | 11 April 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | ~~Deleted~~ | XCode 10.2
| 4.1.1 | 17 December 2018 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/404PIHHQM24V/MapmyIndia_Vector_Map_SDK_withSample_v4.1.1_03042019.zip) | XCode 10.1


## Getting Started

MapmyIndia Maps SDK for IOS lets you easily add MapmyIndia Maps and web services to your own iOS app. MapmyIndia Maps SDK for iOS supports iOS SDK 9.0 and above and Xcode 10.1 or later. You can have a look at the map and features you will get in your own app by using the MapmyIndia Maps app for iOS. The SDK handles map tiles download and their display along with a bunch of controls and native gestures.

## API Usage
Your MapmyIndia Maps SDK usage needs a set of license keys ([get them here](http://www.mapmyindia.com/api/signup) ) and is governed by the API [terms and conditions](https://www.mapmyindia.com/api/terms-&-conditions). 
As part of the terms and conditions, you cannot remove or hide the MapmyIndia logo and copyright information in your project. 
Please see [branding guidelines](https://www.mapmyindia.com/api/advanced-maps/API-Branding-Guidelines.pdf) on MapmyIndia [website](https://www.mapmyindia.com/api) for more details.
The allowed SDK hits are described on the plans page. Note that your usage is
shared between platforms, so the API hits you make from a web application, Android app or an iOS app all add up to your allowed daily limit.

## Setup your Project

#### Create a new project in Xcode.

-   Drag and drop the MapmyIndia Map SDK Framework (Mapbox.framework) to your project. It must be added in embedded binaries.
-   Drag and drop the `MapmyIndiaAPIKit` Framework to your project. It must be added in embedded binaries. It is a dependent framework.
-   In the Build Phases tab of the project editor, click the + button at the top and select .New Run Script Phase.. Enter the following code into the script text field: bash `${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/Mapbox.framework/strip-frameworks.sh`
-   For iOS9 or later, make this change to your  
    info.plist (Project target > info.plist > Add row and set key `NSLocationWhenInUseUsageDescription`,     `NSLocationAlwaysUsageDescription`)

Add your MapmyIndia Map API keys to your `AppDelegate.m` as follows

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
[MapmyIndiaAccountManager setMapSDKKey:@.MAP SDK KEY.];
[MapmyIndiaAccountManager setRestAPIKey:@"REST API KEY.];
[MapmyIndiaAccountManager setAtlasClientId:@.ATLAS CLIENT ID"];
[MapmyIndiaAccountManager setAtlasClientSecret:@.ATLAS CLIENT
SECRET.];[MGLAccountManager setAtlasGrantType:@.GRANT TYPE.];
//always put client_credentials
[MapmyIndiaAccountManager setAtlasAPIVersion:@.1.3.11"]; // Optional; deprecated
```
#### Swift
```swift
MapmyIndiaAccountManager.setMapSDKKey("MAP SDK KEY")
MapmyIndiaAccountManager.setRestAPIKey(.REST API KEY")
MapmyIndiaAccountManager.setAtlasClientId("ATLAS CLIENT ID")
MapmyIndiaAccountManager.setAtlasClientSecret("ATLAS CLIENT SECRET")
MapmyIndiaAccountManager.setAtlasGrantType("GRANT TYPE.) //always put client_credentials
MapmyIndiaAccountManager.setAtlasAPIVersion(.1.3.11") // Optional; deprecated
```

## Add a map view

Map View on view controller can be added either using interface builder or programmatically.

#### By Interface Builder 
In a storyboard, add a view to your View Controller. In the Identity inspector, change its class to `MapmyIndiaMapView`.  
**Note :-** Map style url need to be set at the time of load map  
  
#### By Programmatically 
To add map on view Controller create an instance of `.MGLMapView`. and add this to view of `ViewController`.

#### Objective C
```objectivec
#import
@interface ViewController () <MGLMapViewDelegate>
@end
@implementation ViewController
```
#### Swift
```swift
import Mapbox
  class ViewController: UIViewController, MGLMapViewDelegate {
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


## Map Interactions

### Set Zoom Level

Set zoom to 4 for country level display and 18 for house number display.

#### Objective C
```objectivec
mapView.zoomLevel = 4;
```
#### Swift
```swift
mapView.zoomLevel = 4
```

### Current Location

To show user's current location on map, use property `.showsUserLocation.` and set its value to true.

#### Objective C
```objectivec
mapView.showsUserLocation = YES;
```
#### Swift
```swift
self.mapView.showsUserLocation = true
```

## Map Features

### Tracking Mode

To move map with user location change use property `userTrackingMode`. Its an enum property of type `.MGLUserTrackingMode.`. You can set any value from following:
- `followWithCourse` 
- `followWithHeading` 
- `none`

#### Code Snippet
```swift
mapView.userTrackingMode = .followWithCourse
```

## Map Events

The Map object should implement the methods of the `MGLMapViewDelegate` protocol corresponding to the events you wish it to receive. This delegate can also be used to detect map overlays selection. Delegate handles gesture events, tap on annotation (marker) and map center coordinates.

#### Map Position Changes Events
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
#### Loading the Map Events
```
-(void)mapViewWillStartLoadingMap:(MGLMapView *)mapView;
-(void)mapViewDidFinishLoadingMap:(MGLMapView *)mapView;
-(void)mapViewDidFailLoadingMap:(MGLMapView *)mapView withError:(NSError*)error;
-(void)mapViewWillStartRenderingMap:(MGLMapView *)mapView;
-(void)mapViewWillStartRenderingFrame:(MGLMapView *)mapView;
-(void)mapViewDidFinishRenderingFrame:(MGLMapView *)mapView fullyRendered:(BOOL)fullyRendered;
-(void)mapView:(MGLMapView *)mapView didFinishLoadingStyle:(MGLStyle*)style;
```
#### Tracking User Location Events
```
-(void)mapViewWillStartLocatingUser:(MGLMapView *)mapView;
-(void)mapViewDidStopLocatingUser:(MGLMapView *)mapView;
-(void)mapView:(MGLMapView *)mapView didUpdateUserLocation:(nullableMGLUserLocation *)userLocation;
-(void)mapView:(MGLMapView *)mapView didFailToLocateUserWithError:(NSError*)error;
-(void)mapView:(MGLMapView *)mapView didChangeUserTrackingMode:(MGLUserTrackingMode)mode animated:(BOOL)animated;
```
#### Appearance of Annotations Events
```
-(nullable MGLAnnotationImage *)mapView:(MGLMapView *)mapView imageForAnnotation:(id <MGLAnnotation>)annotation;
-(CGFloat)mapView:(MGLMapView *)mapView alphaForShapeAnnotation:(MGLShape*)annotation;
-(UIColor *)mapView:(MGLMapView *)mapView strokeColorForShapeAnnotation:(MGLShape *)annotation;
-(UIColor *)mapView:(MGLMapView *)mapView fillColorForPolygonAnnotation:(MGLPolygon *)annotation;
-(CGFloat)mapView:(MGLMapView *)mapView lineWidthForPolylineAnnotation:(MGLPolyline *)annotation;
```
#### Annotation Views Events
```
-(nullable MGLAnnotationView *)mapView:(MGLMapView *)mapView viewForAnnotation:(id <MGLAnnotation>)annotation;
-(void)mapView:(MGLMapView *)mapView didAddAnnotationViews: (NS_ARRAY_OF(MGLAnnotationView *) *)annotationViews;
```
#### Selecting Annotations Events
```
-(void)mapView:(MGLMapView *)mapView didSelectAnnotation:(id <MGLAnnotation>)annotation;
-(void)mapView:(MGLMapView *)mapView didDeselectAnnotation:(id <MGLAnnotation>)annotation;
-(void)mapView:(MGLMapView *)mapView didSelectAnnotationView: (MGLAnnotationView *)annotationView;
-(void)mapView:(MGLMapView *)mapView didDeselectAnnotationView: (MGLAnnotationView *)annotationView;
```
#### Callout Views Events
```
-(BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation;
-(nullable id <MGLAnnotation>)mapView:(MGLMapView *)mapView calloutViewForAnnotation:(id <MGLAnnotation>)annotation;
-(nullable UIView *)mapView:(MGLMapView *)mapView leftCalloutAccessoryViewForAnnotation:(id  <MGLAnnotation>)annotation;
-(nullable UIView *)mapView:(MGLMapView *)mapView rightCalloutAccessoryViewForAnnotation:(id <MGLAnnotation>)annotation;
-(void)mapView:(MGLMapView *)mapView annotation:(id <MGLAnnotation>)annotation calloutAccessoryControlTapped:(UIControl *)control;
-(void)mapView:(MGLMapView *)mapView tapOnCalloutForAnnotation:(id <MGLAnnotation>)annotation;
```
### Map Tap

To capture single tap on map events add a tap gesture to instance of `MGLMapView`.

#### Objective C
```objectivec
UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc]
initWithTarget:self action:@selector(didTapPress:)];
[self.mapView addGestureRecognizer:singleTap];

-(void)didTapPress:(UILongPressGestureRecognizer *)gesture {
if(UIGestureRecognizerStateEnded == gesture.state) {
//Do Whatever You want on End of Gesture
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
   //Do Whatever You want on End of Gesture
  }
}
```
### Long Press on Map
To capture long press on map events add a long press gesture to instance of `MGLMapView`.

#### Objective C
```objectivec
UILongPressGestureRecognizer *longPress =  [[UILongPressGestureRecognizer
alloc] initWithTarget:self action:@selector(didLongPress:)];
[longPress setMinimumPressDuration:1.0];
[self.mapView addGestureRecognizer:longPress];
-(void)didLongPress:(UILongPressGestureRecognizer *)gesture {
if(UIGestureRecognizerStateEnded == gesture.state) {
//Do Whatever You want on End of Gesture
   }
  }
```
#### Swift
```swift
let longPress = UILongPressGestureRecognizer(target: self, action:
#selector(didLongPress(tap:)))
mapView.addGestureRecognizer(longPress)
@objc func didLongPress(tap: UILongPressGestureRecognizer) {
if tap.state == .began {
//Do Whatever You want on End of Gesture
  }
}
```

## Map Overlays

### Add marker
To show an annotation on map create an instance of `MGLPointAnnotation` and add that object to instance of `MGLMapView` using method `.addAnnotation.`.

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
`MGLMapViewDelegate`. 
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

```
- (BOOL)mapView:(MGLMapView *)mapView annotationCanShowCallout:(id <MGLAnnotation>)annotation;
```

### Custom Info Window (Changing Callout)

To change default callout view of annotation use delegate function of `.MGLMapViewDelegate.` protocol and return custom view of callout from that function.

```swift
func mapView(_ mapView: MGLMapView, calloutViewFor annotation:
MGLAnnotation) -> MGLCalloutView? {
return CustomCalloutView(representedObject: annotation)
}
```
To create custom callout view create a class inherited from `.MGLCalloutView.` and `.UIView.`. Override draw function of `UIView` to design your own callout view.


### Polylines

#### Add a Polyline

To show a polyline on map create an instance of `MGLPolyline` and add that object to instance of `MGLMapView` using method `.addAnnotation.`.

To create instance of `MGLPolyline` an array of `CLLocationCoordinate2D` will be required so first create an array of `CLLocationCoordinate2D`.

##### Objective C
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
##### Swift
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

#### Remove a Polyline

##### Objective C
```objectivec
[self.mapView removeAnnotation:polyline];
```
##### Swift
```swift
mapView.removeAnnotation(polyline)
```

### Polygons

#### Add a Polygon
To show a polygon on map create an instance of `MGLPolygon` and add that object to instance of `MGLMapView` using method `.addAnnotation.`.

To create instance of `MGLPolygon` an array of `CLLocationCoordinate2D` will be required so first create an array of `CLLocationCoordinate2D`.

##### Objective C
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
##### Swift
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


#### Remove a Polygon

##### Objective C
```objectivec
[self.mapView removeAnnotation:polygon];
```
##### Swift
```swift
mapView.removeAnnotation(polygon)
```
### REST APIs

#### Autosuggest

The Autosuggest API helps users to complete queries faster by adding intelligent search capabilities to your web or mobile app. This API returns a list of results as well as suggested queries as the user types in the search field.

Class used for Autosuggest search is `MapmyIndiaAtlasAutoSuggestManager`.  To create instance of `MapmyIndiaAtlasAutoSuggestManager` initialize using your `rest key`, `clientId`, `clientSecret` , `grantType` **or** use shared instance of `MapmyIndiaAtlasAutoSuggestManager` after setting key values `MapmyIndiaRestKey`, `MapmyIndiaAtlasClientId`, `MapmyIndiaAtlasClientSecret`, `MapmyIndiaAtlasGrantType` in your application’s Info.plist file.

To perform auto suggest use `MapmyIndiaAtlasAutoSearchAtlasOptions` class to pass query parameter to get auto suggest search with an option to pass region in parameter `withRegion`, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

Additionally you can also set location and restriction filters in object of `MapmyIndiaAutoSearchAtlasOptions`. For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Autosuggest).

#### Text Search
The Text Search API is a service that aims to provide information about a list of places on the basis of a text string entered by the user. It uses the location information that is provided along with the query to try to understand the request.

Class used for Text Search is `MapmyIndiaAtlasTextSearchManager`. To create instance of `MapmyIndiaAtlasTextSearchManager` initialize using your `rest key`, `clientId`, `clientSecret` , `grantType` **or** use shared instance of `MapmyIndiaAtlasTextSearchManager` after setting key values `MapmyIndiaRestKey`, `MapmyIndiaAtlasClientId`, `MapmyIndiaAtlasClientSecret`, `MapmyIndiaAtlasGrantType` in your application’s Info.plist file.

To perform text search use `MapmyIndiaTextSearchAtlasOptions` class to
pass query parameter to get text search with an option to pass region in
parameter withRegion, which is an enum of type `MMIRegionTypeIdentifier`.
If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

Additionally you can also set location and restriction filters in object
of `MapmyIndiaTextSearchAtlasOptions`.

For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#AtlasGeocod).

#### Geocoding

The Geocoding API converts real addresses into these geographic coordinates (latitude/longitude) to be placed on a map, be it for any street, area, postal code, POI or a house number etc.

Class used for geocode is **MapmyIndiaAtlasGeocodeManager**. To create instance of `MapmyIndiaAtlasGeocodeManager` initialize using your `rest key`, `clientId`, `clientSecret` , `grantType` **or** use shared instance of MapmyIndiaAtlasGeocodeManager after setting key values `MapmyIndiaRestKey`, `MapmyIndiaAtlasClientId`, `MapmyIndiaAtlasClientSecret`, `MapmyIndiaAtlasGrantType` in your application’s Info.plist file.

For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#AtlasGeocod).

#### Reverse Geocoding

The Reverse Geocoding API translates geographical coordinates (latitude/longitude) into the closest matching address. It provides real addresses along with nearest popular landmark for any such geo-positions on the map.

Class used for geocode is `MapmyIndiaReverseGeocodeManager`. Create a `MapmyIndiaReverseGeocodeManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaReverseGeocodeManager` class.

To perform the translation use `MapmyIndiaReverseGeocodeOptions` class to pass coordinates as parameters to reverse geocode with an option to pass region in parameter `withRegion`, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

In response of reverse geocode search either you will receive an error or an array of `MapmyIndiaGeocodedPlacemark`.
For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Reverse-Geocoding).

#### Nearby

Nearby search, enables you to add discovery and search of nearby POIs by searching for a generic keyword used to describe a category of places or via the unique code assigned to that category.

Class used for nearby search is `MapmyIndiaNearByManager`. Create a `MapmyIndiaNearByManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaNearByManager` class.

To perform nearby search use `MapmyIndiaNearbyAtlasOptions` class to pass keywords/categories and a reference location as parameters to get Nearby search results with an option to pass region in parameter `withRegion`, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

Additionally you can also set location and zoom in object of `MapmyIndiaAutoSearchAtlasOptions`.
For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#nearby-search).

#### eLoc / Place Details

The MapmyIndia eLoc is a simple, standardised and precise pan-India digital address system. Every location has been assigned a unique digital address or an eLoc. The Place Detail can be used to extract the details of a place with the help of its eLoc i.e. a 6 digit code.

Class used for eLoc search is `MapmyIndiaPlaceDetailManager`. Create a `MapmyIndiaPlaceDetailManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaPlaceDetailManager` class.

To perform eLoc search use `MapmyIndiaPlaceDetailGeocodeOptions` class to pass digital address code (eLoc/PlaceId) as parameters to get eLoc Detail results with an option to pass region in parameter withRegion, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

In response of eLoc search either you will receive an error or an array of `MapmyIndiaGeocodedPlacemark`.
For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Place-eLoc).

#### Driving Distance-Time Matrix

The Driving Distance provides driving distance and estimated time to go from a start point to multiple destination points, based on recommended routes from MapmyIndia Maps and traffic flow conditions.

Class used for driving distance is `MapmyIndiaDrivingDistanceMatrixManager`. Create a `MapmyIndiaDrivingDistanceMatrixManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application’s `info.plist` file, then use the shared instance of `MapmyIndiaDrivingDistanceMatrixManager` class.

To perform this operation use `MapmyIndiaDrivingDistanceMatrixOptions` class to pass center location and points parameters.

For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#dsistancematrix).

#### Routing

This will help to calculates driving routes between specified locations including via points based on route type(optimal or shortest), includes delays for traffic congestion. Supported `region` (countries) are India, Sri Lanka, Nepal, Bangladesh and Bhutan.

Use `Directions` to get route between locations. You can use it either by creating object using your rest key **or** use shared instance of `Directions` class by setting rest key in the `MapmyIndiaRestKey` key of your application’s Info.plist file.

To perform this operation use object of `RouteOptions` class as request to pass source location and destination locations and other parameters.

For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Routing).

#### Driving Distance-Time Matrix (Legacy)

The Driving Distance provides driving distance and estimated time to go from a start point to multiple destination points, based on recommended routes from MapmyIndia Maps and traffic flow conditions.

Class used for driving distance is `MapmyIndiaDrivingDistanceManager`. Create a `MapmyIndiaDrivingDistanceManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaDrivingDistanceManager` class.

To perform distance matrix calculation use `MapmyIndiaDrivingDistanceOptions` class to pass center location and points parameters. Where Driving distance will give distance for each point to center location.
For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#DrivingDistance).

#### Routing (Legacy)

This will help to calculates driving routes between specified locations including via points based on route type(fastest or shortest), includes delays for traffic congestion , and is capable of handling additional route parameters like: type of roads to avoid, travelling vehicle type etc.

Class used for routing is `MapmyIndiaRouteTripManager`. Create a `MapmyIndiaRouteTripManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaRouteTripManager` class.

To perform routing use `MapmyIndiaRouteTripOptions` class to pass start location and destination location parameters.
For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Route).

#### Geocoding (Legacy)

The Geocoding API converts real addresses into these geographic coordinates (latitude/longitude) to be placed on a map, be it for any street, area, postal code, POI or a house number etc.

Class used for geocode is `MapmyIndiaGeocodeManager`. Create a `MapmyIndiaGeocodeManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaGeocodeManager` class.

To perform search use `MapmyIndiaForwardGeocodeOptions` class to pass any address as query parameters to geocode with an option to pass region in parameter `withRegion`, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.
For more details visit our [web documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Geocoding-Forward).

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
> mapbox-gl-native copyright (c) 2014-2019 Mapbox.