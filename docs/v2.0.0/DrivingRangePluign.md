![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# MapmyIndiaDrivingRangePlugin for iOS

## [Introduction](#Introduction)

The MapmyIndiaDrivingRangePlugin allows you to plot driving range area to drive based on time or distance on MapmyIndia's vector map component.

The plugin offers the following basic functionalities:

- Get and Plot driving range as polygon on map.

- Update driving range on map.

- Clear already plotted driving range on map.

**This can be done by following simple steps.**

## Step 1 :-  [Installation](#Installation)


This plugin can be installed using CocoaPods. It is available with name `MapmyIndiaDrivingRangePlugin`.

### [Using CocoaPods](#Using-CocoaPods)

Create a Podfile with the following specification:

```cocoapods
pod 'MapmyIndiaDrivingRangePlugin', '0.2.0'
```

Run `pod repo update && pod install` and open the resulting Xcode workspace.

### [Version History](#Version-History)

| Version | Dated        | Description                                  |
|:--------|:-------------|:---------------------------------------------|
| `0.2.0` | 28 Mar, 2022 | Added support for xocde 13+                  |
| `0.1.3` | 1 Feb, 2022  | Initial version release compatible to 13.2.1 |
| `0.1.2` | 1 Feb, 2022  | Initial version release compatible to 13     |
| `0.1.1` | 1 Feb, 2022  | Initial version release compatible to 12.5   |

#### [Dependencies](#Dependencies)

This library depends upon several MapmyIndia's own libraries. All dependent libraries will be automatically installed using CocoaPods.

Below are list of dependcies which are required to run this SDK:

- [MapmyIndiaAPIKit](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit)
- [MapmyIndiaMaps](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki)

## Step 2 :-  [Plugin Initialization](#Plugin-Initialization)

### [MapmyIndiaDrivingRangePlugin](#MapmyIndiaDrivingRangePlugin)

`MapmyIndiaDrivingRange` is the main class which is need to initialize to use different functionality of plugin. It requires an instance of MapmyIndiaMapView.

It allows you to plot driving range area to drive based on time or distance.

```swift
var drivingRangePlugin = MapmyIndiaDrivingRange(mapView: self.mapView)

self.drivingRangePlugin.delegate = self // optional
```

## Step 3 :-  [Get And Plot Driving Range](#Get-And-Plot-Driving-Range)

A function `getAndPlotDrivingRange` of instance of `MapmyIndiaDrivingRange` will be used to get driving range and plot on map. This function will accept an instance of `MapmyIndiaDrivingRangeOptions` as request to get driving range.

Below is code for reference:

```swift
let location = CLLocation(latitude: 28.551060, longitude: 77.268989)
        
let contours = [MapmyIndiaDrivingRangeContours(value: 2)]
let rangeInfo = MapmyIndiaDrivingRangeRangeTypeInfo(rangeType: .distance, contours: contours)
        
let drivingRangeOptions = MapmyIndiaDrivingRangeOptions(location: location, rangeTypeInfo: rangeInfo)
        
self.drivingRangePlugin.getAndPlotDrivingRange(options: drivingRangeOptions)
```

## [Additional Features](#Additional-Features)

### [Clear Driving Range](#Clear-Driving-Range)

Plotted driving range on Map can be removed by calling function `clearDrivingRangeFromMap`.

Below is line of code to use it:

```swift
drivingRangePlugin.clearDrivingRangeFromMap()
```

### [Update Driving Range](#Update-Driving-Range)

Plotted driving range on map can be upated by calling function `getAndPlotDrivingRange` again with new request object (instance of MapmyIndiaDrivingRangeOptions).

Below is some code for reference:

```swift
let location = CLLocation(latitude: 28.612972, longitude: 77.233529)
        
let contours = [MapmyIndiaDrivingRangeContour(value: 15)]
let rangeInfo = MapmyIndiaDrivingRangeRangeTypeInfo(rangeType: .time, contours: contours)
        
let speedInfo = MapmyIndiaDrivingRangeOptimalSpeed()
        
let drivingRangeOptions = MapmyIndiaDrivingRangeOptions(location: location, rangeTypeInfo: rangeInfo, speedTypeInfo: speedInfo)
        
self.drivingRangePlugin.getAndPlotDrivingRange(options: drivingRangeOptions)
```

## [Reference](#Reference)

### [MapmyIndiaDrivingRangePluginDelegate](#MapmyIndiaDrivingRangePluginDelegate)

It is a protocol class which provides different callbacks of events of `MapmyIndiaDrivingRange`.

Below are different callback functions avaialble:

#### [drivingRange(_:didFailToGetAndPlotDrivingRange:)](#drivingRange(_:didFailToGetAndPlotDrivingRange:))

Called when the plugin fails to get and plot driving range.

**DECLARATION**

```swift
optional func drivingRange(_ plugin: MapmyIndiaDrivingRange, didFailToGetAndPlotDrivingRange error: Error)
```

**PARAMETERS**

- **plugin:-** The plugin that has calculated a driving range.

- **error:-** An error raised during the process of obtaining a new route.


#### [drivingRangeDidSuccessToGetAndPlotDrivingRange(_:)](#drivingRangeDidSuccessToGetAndPlotDrivingRange(_:))

Called when the plugin succeed to get and plot driving range on map.

**DECLARATION**

```
@objc optional func drivingRangeDidSuccessToGetAndPlotDrivingRange(_ plugin: MapmyIndiaDrivingRange)
```

**PARAMETERS**

- **plugin:-** The plugin that has calculated a driving range.

### [MapmyIndiaDrivingRangeOptions](#MapmyIndiaDrivingRangeOptions)

It is a structure that specifies the criteria for request for geting polygons as range to drive based on time or distance.

It contains following properties.

- **name:-** It is of type `String` used for name of the isopolygon request. If name is specified, the name is returned with the response.

- **location:-** It is of type `CLLocation`, Center point for range area that will surrounds the roads which can be reached from this point in specified time range(s).

- **drivingProfile:-** It is of type `MapmyIndiaDirectionsProfileIdentifier`. Driving profile for routing engine. Default value is `auto`.

- **speedTypeInfo:-** It is of protocol type `MapmyIndiaDrivingRangeSpeed`. It is used to calculate the polygon. Instance of `MapmyIndiaDrivingRangeSpeedOptimal`, `MapmyIndiaDrivingRangeSpeedPredictiveFromCurrentTime` or `MapmyIndiaDrivingRangePredictiveSpeedFromCustomTime` can be set.

- **rangeTypeInfo:-** It is of type `MapmyIndiaDrivingRangeRangeTypeInfo`. To specify the type of range which is used to calculate the polygon.

- **isForPolygons:-** A Boolean value to determine whether to return geojson polygons or linestrings. The default is true.

- **isShowLocations:-** A boolean indicating whether the input locations should be returned as MultiPoint features: one feature for the exact input coordinates and one feature for the coordinates of the network node it snapped to. The default is false.

- **denoise:-** A floating point value from 0 to 1 (default of 1) which will be used to remove smaller contours. Default value is 0.5.

- **generalize:-** A floating point value in meters used as the tolerance for Douglas-Peucker generalization. Default value is 1.2


### [MapmyIndiaDrivingRangeRangeTypeInfo](#MapmyIndiaDrivingRangeRangeTypeInfo)

Use instance of it to set speed type in instance of `MapmyIndiaDrivingRangeOptions`.

It contains following properties.

- **rangeType:-** It is type of enum `MapmyIndiaDrivingRangeRangeType`. It specify the type of range which is used to calculate the polygon. Acceptable values are time and distance. Default value is time

- **contours:-** An array of contour (of type `MapmyIndiaDrivingRangeContour`) objects Each contour object is combination of value and colorHexString. There must be minimum one item in the array if not set by default one value will be passed with default value.

Below is line of code to initilize instance of it:

```swift
let contours = [MapmyIndiaDrivingRangeContour(value: 2)]
let rangeInfo = MapmyIndiaDrivingRangeRangeTypeInfo(rangeType: .time, contours: contours)
```

### [MapmyIndiaDrivingRangeContour](#MapmyIndiaDrivingRangeContour)

Use instance of it to set speed type in instance of `MapmyIndiaDrivingRangeOptions`.

It contains following properties.

- **value:-** It is of type `Int`. It's value be considered as time or distance depending upon type of Range in instance of `MapmyIndiaDrivingRangeRangeTypeInfo`. If type of range is time then value will considered in minute/s where default value will be 15 and maximun acceptable value will be 120. If type of range is distance then value will considered in kilometer/s where default value will be 1 and maximun acceptable value will be 100.

- **colorHexString:-** It is of type `String`. It specify the color for the output of the contour. Pass a hex value, such as `ff0000` for red. If no color is specified, default color will be assigned.

Below is line of code to initilize instance of it:

```swift
let contour = MapmyIndiaDrivingRangeContour(value: 15)
```

### [MapmyIndiaDrivingRangeOptimalSpeed](#MapmyIndiaDrivingRangeOptimalSpeed)

It is a structure to specify the type of speed to use to calculate the polygon.
Type of speed will be optimal.

Use instance of it to set speed type in instance of `MapmyIndiaDrivingRangeOptions`.

Below is line of code to initilize instance of it:

```swift
let speedInfo = MapmyIndiaDrivingRangeOptimalSpeed()
```

### [MapmyIndiaDrivingRangePredictiveSpeedFromCurrentTime](#MapmyIndiaDrivingRangePredictiveSpeedFromCurrentTime)

It is a structure to specify the type of speed and timestamp to use to calculate the polygon. Type of speed will be predicitve and timestamp will be current.

Use instance of it to set speed type in instance of `MapmyIndiaDrivingRangeOptions`.

Below is line of code to initilize instance of it:

```swift
let speedInfo = MapmyIndiaDrivingRangePredictiveSpeedFromCurrentTime()
```

### [MapmyIndiaDrivingRangePredictiveSpeedFromCustomTime](#MapmyIndiaDrivingRangePredictiveSpeedFromCustomTime)

It is a structure to specify the type of speed and timestamp to use to calculate the polygon. Type of speed will be predicitve and timestamp will be required to initialize instance of this.

Use instance of it to set speed type in instance of `MapmyIndiaDrivingRangeOptions`.

Below is line of code to initilize instance of it:

```swift
let speedInfo = MapmyIndiaDrivingRangePredictiveSpeedFromCustomTime(timestamp: 1633684669)
```

For more information click [Wiki](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki)

OR

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


> © Copyright 2019. CE Info Systems Ltd. All rights reserved. | [Terms & Conditions](http://www.mapmyindia.com/api/terms-&-conditions)
> MapmyIndia-gl-native copyright (c) 2014-2019 MapmyIndia.
