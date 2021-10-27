![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# MapmyIndiaDirectionsUI for iOS

## [Introduction](#Introduction)

MapmyIndiaDirectionsUI SDK provides the UI components to quickly integrate MapmyIndiaDirections framework in iOS application.It offers the following basic functionalities:

1. Takes support of MapmyIndia Place search for searching locations of origin, destinations and via points.
2. It allows to use origin and destinations in MapmyIndia's digital address (semicolon separated) eLoc or WGS 84 geographical coordinates both.
3.  The ability to set the vehicle profile like driving, and biking.
4. Easily set the resource for traffic and ETA information.

For details, please contact apisupport@mapmyindia.com.

## [Installation](#Installation)

This plugin can be installed using CocoaPods. It is available with name `MapmyIndiaDirectionsUI`.

### [Using CocoaPods](#Using-CocoaPods)

To install the MapmyIndiaDirectionsUI using CocoaPods:

Create a Podfile with the following specification:

```
pod 'MapmyIndiaDirectionsUI', '0.0.3'
```

Run `pod repo update && pod install` and open the resulting Xcode workspace.

#### [Dependencies](#Dependencies)

This library depends upon several MapmyIndia's own and third party libraries. All dependent libraries will be automatically installed using CocoaPods.

Below are list of dependcies which are required to run this SDK:

- [MapmyIndiaAPIKit](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit)
- [MapmyIndiaMaps](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki)
- [MapmyIndiaUIWidgets](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/MapmyIndiaUIWidgets)
- [MapmyIndiaDirections](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit#Routing-API)
- [Polyline](https://github.com/raphaelmor/Polyline)(A third party library)

### [Version History](#Version-History)

| Version | Dated | Description |
| :---- | :---- | :---- |
| `0.0.5` | 30 May, 2021 | Added support for xcode 12.5|
| `0.0.4` | 01 March, 2021 | Added current location button and UI improvements. And added some new properties |
| `0.0.3` | 28 Jan, 2021 | Added support for xcode 12.2 and eLoc Strategy. |
| `0.0.2` | 26 Oct, 2020 | Initial version. |

## [Usage](#Usage)

The MapmyIndiaDirectionsUI makes it easy to integrate MapmyIndiaDirections SDK to your iOS application. It gives you all the tools you need to add Directions related UI components to your application.


### [MapmyIndiaDirectionsViewController](#MapmyIndiaDirectionsViewController)

`MapmyIndiaDirectionsViewController` is type of UIViewController which you can use to show screen for getting input from user to choose origin and destination and show routes after that.

```swift
let directionVC = MapmyIndiaDirectionsViewController(for: [MapmyIndiaDirectionsLocation]())
self.navigationController?.pushViewController(directionVC, animated: false)
```

As from above code you can see it requires an array of object type `MapmyIndiaDirectionsLocation`. It can be an blank array to launch screen without any chosen locations.

Also you can pass fixed locations and launch instnace of `MapmyIndiaDirectionsViewController`, as shown in below code:

```swift
var locationModels = [MapmyIndiaDirectionsLocation]()
let source = MapmyIndiaDirectionsLocation(location: "77.2639,28.5354", displayName: "Govindpuri", displayAddress: "", locationType: .suggestion)
        
let viaPoint = MapmyIndiaDirectionsLocation(location: "12269L", displayName: "Sitamarhi", displayAddress: "", locationType: .suggestion)
        
let destination = MapmyIndiaDirectionsLocation(location: "1T182A", displayName: "Majorganj", displayAddress: "", locationType: .suggestion)
        
self.locationModels.append(source)
self.locationModels.append(viaPoint)
self.locationModels.append(destination)
let directionVC = MapmyIndiaDirectionsViewController(for: self.locationModels)
directionVC.profileIdentifier = .driving
directionVC.attributationOptions = [.congestionLevel]
directionVC.resourceIdentifier = .routeETA
self.navigationController?.pushViewController(directionVC, animated: false)
```
#### [Configuration](#Configuration)

Here are the properties use to configure `MapmyIndiaDirectionsViewController` route.

##### [Profile Identifier](Profile-Identifier)
It is instance of enum DirectionsProfileIdentifier which can accepts values driving, walking, biking, trucking. By default its value is driving.

##### [Resource Identifier](Resource-Identifier) 
It is instance of enum DirectionsResourceIdentifier which can accepts values routeAdv, routeETA. By default its value is routeAdv.

Note: To use RouteETA ‘resourceIdentifier’ should be routeETA and ‘profileIdentifier’ should be driving. In response of RouteETA a unique identifier to that request will be received which can be get using parameter routeIdentifier of object Route.

##### [AttributeOptions](AttributeOptions)
AttributeOptions for the route. Any combination of `AttributeOptions` can be specified.
By default, no attribute options are specified.

##### [IncludesAlternativeRoutes](IncludesAlternativeRoutes)
 A Boolean value indicating whether alternative routes should be included in the response.
The default value of this property is `true`.


##### [autocompleteViewController](autocompleteViewController)
MapmyIndiaAutocompleteViewController provides an interface that displays a table of autocomplete predictions that updates as the user enters text. Place selections made by the user are returned to the app via the `MapmyIndiaAutocompleteViewControllerResultsDelegate`.


##### [autocompleteAttributionSetting](autocompleteAttributionSetting)
AutocompleteAttributionSetting allow to change the appearance of the logo in `MapmyIndiaAutocompleteViewController`

##### [autocompleteFilter](autocompleteFilter)
This property represents a set of restrictions that may be applied to autocomplete requests. This allows customization of autocomplete suggestions to only those places that are of interest.

##### [routeShapeResolution](routeShapeResolution)
 A `routeShapeResolution` indicates the level of detail in a route’s shape, or whether the shape is present at all its default value is `.full`

##### [includesSteps](includesSteps)
A Boolean value indicating whether `MBRouteStep` objects should be included in the response. its default value is `true`.

##### [isShowStartNavigation](isShowStartNavigation)
To show the Start Navigation button if the origin is current location.
<br><br>


`MapmyIndiaDirectionsViewController` is created using several UI components whose appearance can be changed according to user requirements. Some of them are listed as below:

- `MapmyIndiaDirectionsTopBannerView`
- `MapmyIndiaDirectionsBottomBannerView`

### [MapmyIndiaDirectionsViewControllerDelegates](#MapmyIndiaDirectionsViewControllerDelegates)

It is a protocol class which will be used for callback methods as shown below:

### Call Back Handler

```swift
/// This meathod will be called when back button is clicked in `TopBannerView`
1. didRequestForGoBack(for view: MapmyIndiaDirectionsTopBannerView)

```

```swift
/// The meathod will be called when  add viapoint button will clicked in `TopBannerView`.
2. didRequestForAddViapoint(_ sender: UIButton,for isEditMode: Bool)

```

```swift
/// The meathod will be called when  Directions button will clicked in `BottomBannerView`.
3. didRequestDirections()

```

```swift
//The meathod will be called when  start button will clicked in `BottomBannerView`.
4. didRequestForStartNavigation(for routes: [Route], locations: [MapmyIndiaDirectionsLocation], selectedRouteIndex: Int, error: NSError)

```

### [MapmyIndiaDirectionsTopBannerView](#MapmyIndiaDirectionsTopBannerView)

 `MapmyIndiaDirectionsTopBannerView` is type of UIView which show the source, destination and viapoint locations at the top of `MapmyIndiaDirectionsViewController`

This class accepts array of `MapmyIndiaDirectionsLocation` from which it set value of source, destination and viapoint.


### [MapmyIndiaDirectionsBottomBannerView](#MapmyIndiaDirectionsBottomBannerView)

 `MapmyIndiaDirectionsBottomBannerView` is class of type UIView, it used for showing the route information i.e ArivalTime, DistanceRemening, TimeRemening.

 To use this class it takes  we need to call a function `updateBottomBanner` which accepts three parameters i.e route, selectedRoute, locationModel.

-  **route:** It  is an array of the Routes which is required to update bottom banner view.
 - **selectedRoute:** If you have multiple routes then it will give the selected route in `Integer`
 - **locationModel:** LocationModel is an array of the type  `MapmyIndiaDirectionsLocation`  which is required to manage bottom banner view.

<br/><br/>For any queries and support, please contact: 

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

> © Copyright 2020. CE Info Systems Pvt. Ltd. All Rights Reserved. | [Terms & Conditions](http://www.mapmyindia.com/api/terms-&-conditions)
