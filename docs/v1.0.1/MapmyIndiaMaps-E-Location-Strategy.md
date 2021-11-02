![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# e-Location Strategy in MapmyIndia's Map SDK for iOS

## [Add Marker Using eLoc](#Add-Marker-Using-eLoc)

A marker on MapmyIndia Map can be added using only eLoc. For this it will require an object of `MapmyIndiaPointAnnotation`.

To create object of `MapmyIndiaPointAnnotation` it will require MapmyIndia eLoc(unique code of a Place) in its initializer.

### Single Marker

**Swift**
```swift
let annotation11 = MapmyIndiaPointAnnotation(eloc: "eLoc")
mapmyIndiaMapView.addMapmyIndiaAnnotation(annotation11, completionHandler: nil)
```

### Multiple Markers

**Swift**
```swift
var annotations = [MapmyIndiaPointAnnotation]()            
let eLocs = [ "mmi000", "7gbcyf", "5MEQEL", "k595cm"]
for eLoc in eLocs {
    let annotation = MapmyIndiaPointAnnotation(eloc: eLoc)
    annotations.append(annotation)
}
self.mapView.addMapmyIndiaAnnotations(annotations, completionHandler: nil)
```
## [Set Map Center Using eLoc](#Set-Map-Center-Using-eLoc)

MapmyIndia's Map can be centered to a Place using its eLoc.
Different functions are available to achieve this. Below are code snippets to use it.

**Swift**
```swift
mapmyIndiaMapView.setMapCenterAtEloc("mmi000", animated: false, completionHandler: nil)
```

```swift
mapmyIndiaMapView.setMapCenterAtEloc("mmi000", zoomLevel: 17, animated: false, completionHandler: nil)
```

```swift                
mapmyIndiaMapView.setMapCenterAtEloc("mmi000", zoomLevel: 17, direction: 0, animated: false, completionHandler: nil)
```

## [Set Map View Bounds Using List of eLoc](#Set-Map-View-Bounds-Using-List-of-eLoc)

MapmyIndia's Map's bounds can be set to fit bounds for a list of eLocs.
A method `showELocs:` is available to achieve this. Below is code snipped to demonstrated its usage

**Swift**
```swift
let eLocs = ["mmi000", "7gbcyf", "5MEQEL", "k595cm"]
self.mapView.showElocs(eLocs, animated: false, completionHandler: nil)
```
## [Distance Between Locations Using eLocs](#Distance-Between-Locations-Using-eLocs)

Code snipet for getting distance between different locations using eLocs is below. For more information please see [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit#Distance-Using-eLocs).

## [Directions Between Locations Using eLocs](#Directions-Between-Locations-Using-eLocs)

Directions between different locations can be get using eLocs. For more information please see [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit#Routing-API) and [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit#Directions-Using-eLocs).

**For any queries and support, please contact:**

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