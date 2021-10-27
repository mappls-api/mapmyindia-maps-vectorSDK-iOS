# MapmyIndia Interactive Layers Plugin for iOS

## [Introduction](#Introduction)

It is a guide to display Interactive Layers(such as Covid WMS Layers) on MapmyIndia's Map.

In the current scenario, where social distancing is paramount, technology is playing a key role in maintaining daily communication and information transfer. MapmyIndia is serving individuals, companies and the government alike, to spread critical information related to COVID-19 through deeply informative, useful and free-to-integrate geo-visualized COVID-19 Layers in your application.

Following this COVID - 19 guide it will be possible to display different Covid 19 related areas, zone and location on MapmyIndia's Map<sup>[[1]](#[1])</sup> for iOS. [MapmyIndiaMaps SDK for iOS](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki) is SDK to display map on iOS platform.

It would be extremely helpful for people who are looking forward to joining offices or visiting markets etc. This tool can help you check the zone and other details of any area.

## [Getting Started](#Getting-Started)

### [Get Layers](#Get-Layers)

On launch of MapmyIndia's Map<sup>[[1]](#[1])</sup>, List of available layers can be fetched/refreshed from server by calling method `getCovidLayers` of map object. Layers can be accessed by property `interactiveLayers` of map as explained in section [Access Layers](#Access-Layers).

A delegate method `mapViewInteractiveLayersReady` will be called when it successfully fetches list of layers from server. This method can be accessed by refereing delegate of map object to any ViewController and implementing protocol class `MapmyIndiaMapViewDelegate`. Go to section [Layers Ready Callback](#Layers-Ready-Callback) for more details.

#### [Map Auhtorizaton](#Map-Auhtorizaton)

Map Authorization is part of MapmyIndiaMaps SDK. Map will only display if your keys are provisoned to display map.

A delegate method `authorizationCompleted` from Maps SDK is called onece it checks for Map Authorization.

This delegate method is called when Maps authorization process completes. In delegate method a boolean property `isSuccess` receives which represents is authorization successed or not.

**Note:** `getCovidLayers` function will only work if Map SDK is authenticated. So best place to call this function is in delegate method `authorizationCompleted`.

##### Objective-C

```objectivec
- (void)mapView:(MapmyIndiaMapView *)mapView authorizationCompleted:(BOOL)isSuccess
{
    if(isSuccess) {
        [self.mapView getCovidLayers];
    }
}
```

##### Swift

```swift
func mapView(_ mapView: MapmyIndiaMapView, authorizationCompleted isSuccess: Bool) {
    if isSuccess {
        self.mapView.getCovidLayers()
    }
}
```

### [Layers Ready Callback](#Layers-Ready-Callback)

Delegate method `mapViewInteractiveLayersReady` is called when it successfully fetches list of layers after calling function `getCovidLayers`.

So get ready your application once pointer comes to this delegate method.

A scenario can be made in application to allow or disallow to access WMS layers using this deleage method. Please see below code for reference:

##### Objective-C

```objectivec
- (void)mapViewInteractiveLayersReady:(MapmyIndiaMapView *)mapView
{
    // Put your logic here to allow to access WMS layers, either by some boolean property or by setting visiblity of a button as it is demonstrated in sample.
    if (self.mapView.interactiveLayers && self.mapView.interactiveLayers.count > 0) {
        [_covid19Button setHidden:NO];
    }
}
```

##### Swift

```swift
func mapViewInteractiveLayersReady(_ mapView: MapmyIndiaMapView) {
    // Put your logic here to allow to access WMS layers, either by some boolean property or by setting visiblity of a button as it is demonstrated in sample.
    if self.mapView.interactiveLayers?.count ?? 0 > 0 {
        covid19Button.isHidden = false
    }
}
```

### [Access Layers](#Access-Layers)

List of available layers can be accessed using porperty `interactiveLayers` which is type of an array of `MapmyIndiaInteractiveLayer` class.

**Note:** Fetching of list of layers will only succeed if your `Authorization keys` for map are `provisoned` to get these layers otherwise this will be an empty list.

##### Objective-C

```objectivec
NSArray<MapmyIndiaInteractiveLayer *> *interactiveLayers = self.mapView.interactiveLayers;
```

##### Swift

```swift
let interactiveLayers = self.mapView.interactiveLayers
```

`MapmyIndiaInteractiveLayer` class has two properties `layerId` and `layerName`.

`layerId` is unique identifier for a layer using which a layer can be shown or hide on map

`layerName` is display name for a layer which can be used to show in a list or label.

### [Access Visible Layers](#Access-Visible-Layers)

List of available layers can be accessed using porperty `visibleInteractiveLayers`.

##### Objective-C

```objectivec
NSArray<MapmyIndiaInteractiveLayer *> *visibleInteractiveLayers = self.mapView.visibleInteractiveLayers;
```

##### Swift

```swift
let visibleInteractiveLayers = self.mapView.visibleInteractiveLayers
```

### [Show or Hide Layer](Show-or-Hide-Layer)

A Covid WMS layer can be shown or hide from map using helper function available.

#### [Show Layer](#Show-Layer)

A Covid WMS layer can be shown on map by calling a function `showInteractiveLayerOnMapForLayerId`. This function accepts a string value which must be layerId of one of object from list of interactive layers.

##### Objective-C

```objectivec
[self.mapView showInteractiveLayerOnMapForLayerId:@"pass-unique-layerId-here"];
```

##### Swift

```swift
mapView.showInteractiveLayerOnMap(forLayerId: "pass-unique-layerId-here")
```

#### [Hide Layer](#Hide-Layer)

A Covid WMS layer can be hide from map by calling a function `hideInteractiveLayerFromMapForLayerId`. This function accepts a string value which must be layerId of one of object from list of interactive layers.

##### Objective-C

```objectivec
[self.mapView hideInteractiveLayerFromMapForLayerId:@"pass-unique-layerId-here"];
```

##### Swift

```swift
mapView.hideInteractiveLayerFromMap(forLayerId: "pass-unique-layerId-here")
```

## [Covid Related Information](#Covid-Related-Information)

On tap on Map object covid related information for visible codvid layers will we fetched from server.

Information from top visible covid layer, will be received in delegate method `didDetectCovidInfo`, which is part of MapmyIndiaMapViewDelegate protocol class.

`didDetectCovidInfo` delegate methods will return an object of `MapmyIndiaCovidInfo` class which can be used to display different information. It will return `nil` if no info exists.

##### Objective-C

```objectivec
- (void)didDetectCovidInfo:(MapmyIndiaCovidInfo *)covidInfo
{
    if (covidInfo) {
    }
}
```

##### Swift

```swift
func didDetect(_ covidInfo: MapmyIndiaCovidInfo?) {
    if let covidInfo = covidInfo {
    }
}
```

## [Map Marker for Covid Related Information](#Map-Marker-for-Covid-Related-Information)

A marker at tapped location can be plotted on map after succesfully query covid related WMS layers.

Marker can be allowed or disallowed to plot on map by setting value of boolean property `shouldShowPopupForInteractiveLayer`. To allow to show marker set its value to `true`. By default it is false, means no marker shows on tap of covid WMS Layers.

Below is code for refrence to create a toggle button to enable or disable Covid Marker:

##### Objective-C

```objectivec
- (IBAction)covidMarkerToggleButtonPressed:(UIButton *)sender {
    BOOL newState = !_covidMarkerToggleButton.isSelected;
    [_covidMarkerToggleButton setSelected:newState];
    [_mapView setShouldShowPopupForInteractiveLayer:newState];
}
```

##### Swift

```swift
@IBAction func covidMarkerToggleButtonPressed(_ sender: UIButton) {
    let newState = !sender.isSelected;
    covidMarkerToggleButton.isSelected = newState
    self.mapView.shouldShowPopupForInteractiveLayer = newState
}
```

## [References](#References)

##### [[1]](#[1])

A MapmyIndia's map component which is part of [MapmyIndiaMaps SDK for iOS](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki).

For any queries and support, please contact:

![Email](https://www.google.com/a/cpanel/mapmyindia.co.in/images/logo.gif?service=google_gsuite) 
Email us at [apisupport@mapmyindia.com](mailto:apisupport@mapmyindia.com)

![MapmyIndia Stack Overflow](https://www.mapmyindia.com/api/img/icons/stack-overflow.png)
[Stack Overflow](https://stackoverflow.com/questions/tagged/mapmyindia-api)
Ask a question under the mapmyindia-api

![MapmyIndia Support](https://www.mapmyindia.com/api/img/icons/support.png)
[Support](https://www.mapmyindia.com/api/index.php#f_cont)
Need support? contact us!

![MapmyIndia Blog](https://www.mapmyindia.com/api/img/icons/blog.png)
[Blog](http://www.mapmyindia.com/blog/)
Read about the latest updates & customer stories

> © Copyright 2020. CE Info Systems Pvt. Ltd. All Rights Reserved. | [Terms & Conditions](http://www.mapmyindia.com/api/terms-&-conditions)