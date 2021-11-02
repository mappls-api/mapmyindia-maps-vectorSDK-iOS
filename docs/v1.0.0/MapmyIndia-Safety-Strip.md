![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# Guide - Show COVID-19 Safety Status on MapmyIndia's Map

## [Introduction](#Introduction)

It is a guide to display a user's safety status for COVID-19 on a map. It will show whether user is in a containment zone or not if yes how much is distance from current location.

Following this guide it will be possible to display user's safety status on MapmyIndia's Map<sup>[[1]](#[1])</sup> in the form of a safety strip depending upon the user's current location. [MapmyIndiaMaps SDK for iOS](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki) is SDK to display map on iOS platform.

A method need to be called to check safety status. SDK has inbuild view with button which can be used to call that method.

A sample application project can be found on github by following link: [iOS MapDemo](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS).

**Note** This fetatue is available from version `5.7.8` of MapmyIndiaMaps SDK.

## [Getting Started](#Getting-Started)

### [Get Safety Status](#Get-Safety-Status)

After loading of MapmyIndia's Map<sup>[[1]](#[1])</sup>,  a mthod can be called to get safety status. `showCurrentLocationSafety` is the method which helps to find user's safety status. On successfully fetching of status a safety strip will be shown on map.

##### Objective-C

```objectivec
[_mapView showCurrentLocationSafety];
```

##### Swift

```swift
mapView.showCurrentLocationSafety()
```

>**Note:** `showCurrentLocationSafety` will only works if user's location is available. So best practice to call this function when map is ready to show user's location. A delegate method `didUpdateUserLocation` of map SDK can be used to check when map is ready to show user location.

### [Safety Strip](#Safety-Strip)

On successfully receiving status based on location from server, a view will be shown on map with safety information like distance, containment zone location etc. By default its position will be on top of map.

#### [Safety Strip Position](#Safety-Strip-Position)

By default safety status strip will be shown on top of map. But its position can be changed by property `safetyStripPosition` which is of type `MGLOrnamentPosition`.

##### Objective-C

```objectivec
[_mapView setSafetyStripPosition:MGLOrnamentPositionBottomLeft];
```

##### Swift

```swift
mapView.safetyStripPosition = .bottomLeft
```

#### [Safety Strip Margins](#Safety-Strip-Margins)

By default margins of safety status is zero. But margins can be set by property `safetyStripMargins` which is of type `CGPoint`.

##### Objective-C

```objectivec
[_mapView setSafetyStripMargins:CGPointMake(0, 30)];
```

##### Swift

```swift
mapView.safetyStripMargins = CGPoint(x: 0, y: 30)
```

### [Hide Safety Status](#Hide-Safety-Status)

Safety Strip can be hidden from map by calling method `hideSafetyStrip`.

##### Objective-C

```objectivec
[_mapView hideSafetyStrip];
```

##### Swift

```swift
mapView.hideSafetyStrip()
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