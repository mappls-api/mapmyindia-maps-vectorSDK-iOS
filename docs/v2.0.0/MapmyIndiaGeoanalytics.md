# MapmyIndiaGeoanalytics Plugin for iOS

## [Introduction](#Introduction)

`MapmyIndiaGeoanalytics` is a plugin over MapmyIndia's `GeoAnalytics APIs`. Geoanalytics APIs gives the users the power to display, style, and edit the data which is archived in MapmyIndia’s Database and overlay it on the user created maps.

 - Enables data selection, visualization, queries & styling with rich base map available at various level of granularity
 - Build maps quickly and easily without coordinates, using country, pin codes or simply place names
 - Drill and analyze different type of map layers such as districts, pincode, villages, city etc at Pan India level or restricted to limited bound /Area of interest
- Allows user to set their own styling parameters such as label color scheme, geometry color schemes, opacity, width, stroke etc.
- Allows to create rich thematic visuals using combination of value ranges

This plugin gets the layer specified which is stored in MapmyIndia’s Database and gives a WMS layer as an output with any filters or styles specified by the user. 

## [Installation](#Installation)


This plugin can be installed using CocoaPods. It is available with the name `MapmyIndiaGeoanalytics`.

### [Using CocoaPods](#Using-CocoaPods)

Create a Podfile with the following specification:

```
pod 'MapmyIndiaGeoanalytics', '0.2.0'
```

Run `pod repo update && pod install` and open the resulting Xcode workspace.

### [Version History](#Version-History)

| Version | Dated | Description | 
| :---- | :---- | :---- |
| `0.2.0` | 29 Mar 2022 | - Added `geoboundType` in object of `MapmyIndiaGeoanalyticsGeobound`. |
| `0.1.0` | 3 Apr 2021 | Initial version release with a MapmyIndia geoanalytics. |

#### [Dependencies](#Dependencies)

This library depends upon several MapmyIndia's own libraries. All dependent libraries will be automatically installed using CocoaPods.

Below are list of dependencies which are required to run this SDK:

- [MapmyIndiaAPIKit](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit)
- [MapmyIndiaMaps](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki)

## [Precap](#Precap)

### [Geoanalytics Layer Types](#Geoanalytics-Layer-Types)

An enum `MapmyIndiaGeoanalyticsLayerType` can be used to get different types of layers. Below are different types which are available:

1.  `MapmyIndiaGeoanalyticsLayerTypeState`
2.  `MapmyIndiaGeoanalyticsLayerTypeDistrict`
3.  `MapmyIndiaGeoanalyticsLayerTypeSubDistrict`
4.  `MapmyIndiaGeoanalyticsLayerTypeCity`
5.  `MapmyIndiaGeoanalyticsLayerTypeTown`
6.  `MapmyIndiaGeoanalyticsLayerTypeLocality`
7.  `MapmyIndiaGeoanalyticsLayerTypeSubLocality`
8.  `MapmyIndiaGeoanalyticsLayerTypeSubSubLocality`
9.  `MapmyIndiaGeoanalyticsLayerTypePanchayat`
10. `MapmyIndiaGeoanalyticsLayerTypeVillage `
11. `MapmyIndiaGeoanalyticsLayerTypeWard`
12. `MapmyIndiaGeoanalyticsLayerTypePincode`
13. `MapmyIndiaGeoanalyticsLayerTypeBlock`

**Now that you’re all caught up with the features, let's get down right to them and look at how you can integrate our GeoAnalytics plugin to add data on your map in few simple steps.**

## [Initialization MapmyIndiaGeoanalyticsPlugin](#Initialization-MapmyIndiaGeoanalyticsPlugin)

```swift
var geoanalyticsPlugin : MapmyIndiaGeoanalyticsPlugin = MapmyIndiaGeoanalyticsPlugin(mapView: mapView) 
```

## [Use of GeoAnalytics API](#Use-of-GeoAnalytics-API)

Use instance of `MapmyIndiaGeoanalyticsPlugin` to show response of GeoAnalytics API as Map Layers.

**For infomation about `GeoAnalytics API` go [here](https://www.mapmyindia.com/api/advanced-maps/geoanalytics-web-js/geo-analytics-mapmyindia-js).**

### Step 1 - Get GeoAnalytics layers

To get response of GeoAnalytics API, Create an instance of `MapmyIndiaGeoanalyticsLayerRequest`. Below is code snipet for this.

``` swift
let apperenceState = GeoanalyticsLayerAppearance()
apperenceState.fillColor = "42a5f4"
apperenceState.fillOpacity = "0.5"
apperenceState.labelColor = "000000"
apperenceState.labelSize = "10"
apperenceState.strokeColor = "000000"
apperenceState.strokeWidth = "0"
        
let geoboundArray = [MapmyIndiaGeoanalyticsGeobound(geobound: "HARYANA", appearance: apperenceState), MapmyIndiaGeoanalyticsGeobound(geobound: "UTTAR PRADESH", appearance: apperenceState),MapmyIndiaGeoanalyticsGeobound(geobound: "KERALA", appearance: apperenceState)]
        
let layerRequestState = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray, propertyName: ["stt_nme","stt_id","t_p"], layerType: .state)

layerRequestState.attribute = "t_p";
layerRequestState.query = ">0";
layerRequestState.transparent = true;
```

#### [MapmyIndiaGeoanalyticsLayerRequest](#MapmyIndiaGeoanalyticsLayerRequest)

Below are parameters of `MapmyIndiaGeoanalyticsLayerRequest` class.

- **geoboundType** (mandatory): It is of type `String`. It accepts type of geographical extents on which data would be bound. eg. "India", "State", "District" etc.

- **geobound** (mandatory): It is an array of type `MapmyIndiaGeoanalyticsGeobound`. For more info see [here](#MapmyIndiaGeoanalyticsGeobound).

- **propertyName** (mandatory): It is an array of type `String`. eg. ["stt_nme"], ["stt_id"], ["t_p"].

- **layerType** (mandatory): It is the type of layer that user want to show on map it is an enum of type `MapmyIndiaGeoanalyticsLayerType`.

The following  are optional parameters

 - **query** (optional): A string containing an operator and a value which would be applied to
the attribute filter. < (Less than)/ > (Greater then)/ <> (Between).
Note: (*) Mandatory if Attribute is given. Example-I: ‘> 10000’, Example-II: BETWEEN
‘value1’ AND ‘value2’

 - **attribute** (optional): The name of Attribute to filter the output. For eg: Population/Household

 - **transparent:** (optional): It is the property to make the layer transparent.


#### [MapmyIndiaGeoanalyticsGeobound](#MapmyIndiaGeoanalyticsGeobound)

Instance of `MapmyIndiaGeoanalyticsGeobound` is used as a parameter in class `MapmyIndiaGeoanalyticsLayerRequest`. It has two properties `geobound` and `appearance`(optional). Where appearance is of type `GeoanalyticsLayerAppearance`.

##### [GeoanalyticsLayerAppearance](#GeoanalyticsLayerAppearance):

This is the class used to set the appearance of the layer, i.e layerColor, textColor, border color etc. it has following properties:
-   fillColor
-   fillOpacity
-   labelColor
-   labelSize
-   strokeColor
-   strokeWidth

### Step 2 - Adding GeoAnalytics layer on Map

A function `showGeoanalyticsLayer` available in `MapmyIndiaGeoanalyticsPlugin` which accepts a parameter of type `MapmyIndiaGeoanalyticsLayerRequest`.
Plugin internally consume that request to get response and plot layer on Map accordingly.

``` swift 
self.geoanalyticsPlugin.showGeoanalyticsLayer(layerRequestState)
```

### Other Methods Available:

**1. Remove GeoAnalytics Layer**

`removeGeonalyticsLayer` is a function which accepts request of type `MapmyIndiaGeoanalyticsLayerRequest` to remove related layer from map.

``` swift
geoanalyticsPlugin.removeGeoanalyticsLayer(layerRequestState))
```

**2. GeoAnalytics Layer Info**

A delegate function can be used for information of layer where map is tapped.
Below is the delegate function which returns response of feature info api.

```swift
func didGetFeatureInfoResponse(_ featureInfoResponse:GeoanalyticsGetFeatureInfoResponse) {
    print(featureInfoResponse.features)
}
```

**3. Layer Popup**

A popup will be shown for information of layer where map is tapped. There is a property `shouldShowPopupForGeoanalyticsLayer` available to enable or disable that popup. It is of type Bool by default its value is `false`.

```swift
geoanalyticsPlugin.shouldShowPopupForGeoanalyticsLayer = true
```

**4. Custom Popup**

A delegate function can be used to show custom popup for layer information. Below is delegate function for the same.

```swift
// To show default popup return nil.
func view(forGeoanalyticsInfo response: GeoanalyticsGetFeatureInfoResponse) -> UIView? {
    return nil
}
```

Delegate gives information of layer and accepts to return an instance of `UIView` to show as custom popup.

## [Use of Listing API](#Use-of-Listing-API)

### Introduction:

MapmyIndiaGeoanalytics plugin contains a manager class to consume MapmyIndia's `Listing API`. Listing API is an API that gives the user's information on the different layers & attributes available within Geo-Analytics Core APIs. This API acts as an assisting API to quickly get the necessary details that are required to accurately fetch the required overlays from the core Geo-Analytics APIs.

It provides list of attributes along with unique ID. User can get bounding box of the required feature/area as well.

For more information about `Listing API` see [here](https://www.mapmyindia.com/api/advanced-maps/geoanalytics-web-js/listingapi).

### Step 1 - Create Request

First create an instance of `GeoanalyticsListingAPIRequest` as shown below.

```swift
let listingRequest = GeoanalyticsListingAPIRequest(geoboundType: "stt_nme", geobound: ["HARYANA","UTTAR PRADESH","ANDHRA PRADESH","KERALA"], attribute: "b_box", api: .state)
```

Possible request parameters in class of `GeoanalyticsListingAPIRequest` are listed below. 

#### GeoanalyticsListingAPIRequest

- **geoboundType:** It is of type string which accepts the type of geobound.
- **geobound:** Single valued parent type, for example: stt_nme, dst_nme, sdb_nme etc.  
   **Note**: For parent type reference, contact [apisupport@mapmyindia.com](mailto:apisupport@mapmyindia.com)
- **attribute:** field name/bounding Box requested w.r.t api (api) & parent type (geo_bound_type). Bounding box can be requested as "b_box" variable.
- **api:** It is an enum of type `MapmyIndiaGeoanalyticsLayerType` which specifie type of listing api.

### Step 2 - Send Request

Use shared instance of `MapmyIndiaGeoanalyticsListingManager` and call `getListingInfo` method which accepts request parameter of type `GeoanalyticsListingAPIRequest` as created in previous step. Method `getListingInfo` returns response of type `GeoanalyticsListingAPIsResponse` and error of type `NSError` in completion code block.

``` swift
let listingManager = MapmyIndiaGeoanalyticsListingManager.shared()
listingManager.getListingInfo(listingRequest) { (response, error) in
    if (error != nil) {
        print(error.code)    
    } else {
        print(response)
    }
}
```

#### GeoanalyticsListingAPIsResponse

`GeoanalyticsListingAPIsResponse` contains following properties.

- ***responseCode:*** It is of type `NSString`

- ***version:*** It is the response attribute of type `NSString`

- ***totalFeatureCount:***  IT is the response attribute of type `NSString`.

- ***results:*** It is the response parameter which is of type 
`GeoanalyticsListingAPIsResult`.

GeoanalyticsListingAPIsResult is the class which contains following property.

- ***apiName:*** it the parameter of type `NSString`

- ***attribute:*** it is the parameter of type `NSString`

- ***getAttrValues:*** it is an array of type `GeoanalyticsGetAttrValues` 


GeoanalyticsGetAttrValues is class which contains following attribute.

- ***geo_bound:*** It is of type `NSSting`.

- ***getAttrValues:*** It is the array of type  `NSDictionary`.



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


> © Copyright 2020. CE Info Systems Pvt. Ltd. All Rights Reserved. | [Terms & Conditions](http://www.mapmyindia.com/api/terms-&-conditions)
ß