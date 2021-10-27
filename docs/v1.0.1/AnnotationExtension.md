# MapmyIndia Annotation Extension for iOS

The MapmyIndia Annotation Extension is a lightweight library you can use with the MapmyIndia Maps SDK for iOS to quickly add basic shapes, icons, and other annotations to a map.

This extension leverages the power of runtime styling with an object oriented approach to simplify the creation and styling of annotations.

## Installation

This plugin can be installed using CocoaPods. It is available with name `MapmyIndiaAnnotationExtension`.

### Using CocoaPods

To install the MapmyIndia Annotation Extension using CocoaPods:

Create a Podfile with the following specification:

```
pod 'MapmyIndiaAnnotationExtension', '0.0.4'
```

Run `pod repo update && pod install` and open the resulting Xcode workspace.

## Usage

The MapmyIndia Annotation Extension supports the addition of circles, lines, polygons, and symbols. Each shape type has its own corresponding controller which manages the addition of multiple shape objects of the same type.

Since the map needs to be finished loading before adding shapes to it, all shapes should be added within the `MGLMapView:didFinishLoadingStyle:` delegate method.

### Circles (`MGLCircleStyleAnnotation`)

_Circles represent a coordinate point on a map with an associated radius, measured in pixels._

Circle can be created by two ways.

One is by creating instance of `MGLCircleStyleAnnotation`, either using a coordinate or eLoc. 

```swift
let circle = MGLCircleStyleAnnotation(center: CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06), radius: 3.0, color: .blue)
```
or
```swift
let circle = MGLCircleStyleAnnotation(centerEloc: "MMI000", radius: 3.0, color: .blue)
```

See code below to plot circle on map:

```swift
func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
  let circleAnnotationController = MGLCircleAnnotationController(mapView: self.mapView)
  let circle = MGLCircleStyleAnnotation(center: CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06), radius: 3.0, color: .blue)
  circle.opacity = 0.5
  circleAnnotationController.add(circle)
}
```

Second is by passing a geoJSON (with point geometry) string in function `create` of instance of `MGLCircleAnnotationController`. As mentioned below.

```swift
let circleGeoJSON = "{\"type\": \"FeatureCollection\",\"features\": [{\"type\": \"Feature\",\"properties\": {\"circle-radius\": \"50\",\"circle-color\": \"rgba(0, 0, 255, 1)\",\"circle-blur\": \"0\",\"circle-opacity\": \"0.7\",\"circle-stroke-width\": \"5\",\"circle-stroke-color\": \"rgba(0, 255, 0, 1)\",\"circle-stroke-opacity\": \"0.6\",\"is-draggable\": true},\"geometry\": {\"type\": \"Point\",\"coordinates\": [174.70458984375,-39.588757276965445]}}]}"

func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
  let circleAnnotationController = MGLCircleAnnotationController(mapView: self.mapView)
  circleAnnotationController.create(fromGeoJSON: circleGeoJSON) { (annotations, error) in
    if let error = error {   
      print(error.localizedDescription)           
    } else if let annotations = annotations, annotations.count > 0 {
      // Do custom actions here.
    } else {    
      print("No result found")          
    }
  }
}
```

### Lines (`MGLLineStyleAnnotation`)
_Lines represent a connected series of coordinates._

Line can be created by two ways.

One is by creating instance of `MGLLineStyleAnnotation` using array of coordinates. As mentioned below.

```swift
func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
  let lineAnnotationController = MGLLineAnnotationController(mapView: self.mapView)
  
  let lineCoordinates = [
      CLLocationCoordinate2D(latitude: 59, longitude: 18),
      CLLocationCoordinate2D(latitude: 60, longitude: 20)
  ]
  
  let line = MGLLineStyleAnnotation(coordinates: lineCoordinates, count: UInt(lineCoordinates.count))
  line.color = .purple
  lineAnnotationController.add(line)
}
```

Second is by passing a geoJSON (with line geometry) string in function `create` of instance of `MGLLineAnnotationController`. As mentioned below.

```swift
let lineGeoJSON = "{\"type\": \"FeatureCollection\",\"features\": [{\"type\": \"Feature\",\"properties\": {\"line-join\": \"bevel\",\"line-opacity\": \"0.7\",\"line-color\":\"rgba(0, 255, 0, 1)\",\"line-width\": \"10\",\"line-gap-width\": \"1\",\"line-offset\": \"2\",\"line-blur\": \"0\"},\"geometry\": {\"type\": \"LineString\",\"coordinates\": [[168.5302734375,-46.377254205100265],[169.0576171875,-46.36209301204983],[169.65087890625,-46.13417004624325],[170.5078125,-45.782848351976746],[170.68359375,-45.213003555993964],[170.79345703124997,-44.840290651397986],[171.2109375,-44.16644466445859],[171.84814453125,-43.80281871904721],[172.59521484375,-43.309191099856854],[172.83691406249997,-42.81152174509788],[173.38623046875,-42.342305278572816]]}}]}"

func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
  let lineAnnotationController = MGLLineAnnotationController(mapView: self.mapView)

  lineAnnotationController.create(fromGeoJSON: lineGeoJSON) { (annotations, error) in
    if let error = error {
      print(error.localizedDescription)
    } else if let annotations = annotations, annotations.count > 0 {
      // Do custom actions here.
    } else {
      print("No result found")
    }
  }
}
```

### Polygons (`MGLPolygonStyleAnnotation`)
_Polygons represent a connected series of coordinates, where the first and last coordinates are equal._

Polygons can be created by two ways.

One is by creating instance of `MGLPolygonStyleAnnotation` using array of coordinates. As mentioned below.

```swift
func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
  let polygonAnnotationController = MGLPolygonAnnotationController(mapView: self.mapView)
  
  let polygonCoordinates = [
    CLLocationCoordinate2DMake(59, 18),
    CLLocationCoordinate2DMake(62, 19),
    CLLocationCoordinate2DMake(54, 20),
    CLLocationCoordinate2DMake(59, 18)
  ]
  
  let polygon = MGLPolygonStyleAnnotation(coordinates: polygonCoordinates, count: UInt(polygonCoordinates.count))
  polygon.fillOutlineColor = .red
  polygonAnnotationController.add(line)
}
```

Second is by passing a geoJSON (with polygon geometry) string in function `create` of instance of `MGLPolygonAnnotationController`. As mentioned below.

```swift
let polygonGeoJSON = "{\"type\": \"FeatureCollection\",\"features\": [{\"type\": \"Feature\",\"properties\": {\"fill-opacity\": \"0.6\",\"fill-color\": \"rgba(0, 0, 255, 1)\",\"fill-outline-color\": \"rgba(255, 0, 0, 1)\",\"is-draggable\": true},\"geometry\": {\"type\": \"Polygon\",\"coordinates\": [[[170.947265625,-40.38002840251182],[172.59521484375,-39.90973623453718],[172.77099609375,-39.06184913429153],[172.77099609375,-38.03078569382294],[171.97998046874997,-37.579412513438385],[170.859375,-38.169114135560854],[169.93652343749997,-38.685509760012],[169.0576171875,-38.90813299596704],[168.99169921875,-40.563894530665074],[170.947265625,-40.38002840251182]]]}}]}"

func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
  let polygonAnnotationController = MGLPolygonAnnotationController(mapView: self.mapView)
  
  polygonAnnotationController.create(fromGeoJSON: polygonGeoJSON) { (annotations, error) in
    if let error = error {  
      print(error.localizedDescription)
    } else if let annotations = annotations, annotations.count > 0 {
      // Do custom actions here.
    } else {
      print("No result found")
    }
  }
}
```

### Symbols (`MGLSymbolStyleAnnotation`)
_Symbols represent a coordinate point on a map with a label and an associated optional icon image. An image must be supplied to the map's style before being able to assign it to be the icon image of a symbol._

Symbol can be created by two ways.

One is by creating instance of `MGLSymbolStyleAnnotation` either using a coordinate or eLoc.

```swift
let symbol = MGLSymbolStyleAnnotation(coordinate: CLLocationCoordinate2DMake(59, 18));
```
or
```swift
let symbol = MGLSymbolStyleAnnotation(eloc: "MMI000")
```

See code below to plot symbol marker on map:

```swift
func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
  let attraction = UIImage(named: "attraction")
  
  if let styleImage = attraction {
    self.mapView.style?.setImage(styleImage, forName: "attraction")
  }
  
  let symbolAnnotationController = MGLSymbolAnnotationController(mapView: self.mapView)
  
  let symbol = MGLSymbolStyleAnnotation(coordinate: CLLocationCoordinate2DMake(59, 18));
  symbol.iconImageName = "attraction"
  symbol.text = "This is a cool place!"
  symbol.textFontSize = 16
  symbolAnnotationController.add(symbol)
}
```

Second is by passing a geoJSON (with point geometry) string in function `create` of instance of `MGLSymbolAnnotationController`. As mentioned below.

```swift
let symbolGeoJSON = "{\"type\": \"FeatureCollection\",\"features\": [{\"type\": \"Feature\",\"properties\": {\"symbol-sort-key\": \"0\",\"icon-size\": \"1\",\"icon-image\": \"star-icon-image\",\"icon-rotate\": \"45\",\"icon-offset\": [5,10],\"icon-anchor\": \"bottom\",\"text-field\": \"Hello\",\"text-font\": [\"Open Sans Bold\"],\"text-size\": \"30\",\"text-max-width\": \"200\",\"text-letter-spacing\": \"1\",\"text-justify\": \"right\",\"text-radial-offset\": \"10\",\"text-anchor\": \"center\",\"text-rotate\": \"-30\",\"text-transform\": \"uppercase\",\"text-offset\": [5,10],\"icon-opacity\": \"0.6\",\"icon-color\": \"rgba(0, 0, 255, 1)\",\"icon-halo-color\": \"#00FF00\",\"icon-halo-width\": \"10\",\"icon-halo-blur\": \"0\",\"text-opacity\": \"0.5\",\"text-color\": \"rgba(255, 0, 0, 1)\",\"text-halo-color\": \"hsla(100, 50%, 50%, 1)\",\"text-halo-width\": \"5\",\"text-halo-blur\": \"0\",\"is-draggable\": true},\"geometry\": {\"type\": \"Point\",\"coordinates\": [172.5732421875,-46.31658418182218]}}]}"

func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
  let attraction = UIImage(named: "attraction")
  
  if let styleImage = attraction {
    self.mapView.style?.setImage(styleImage, forName: "attraction")
  }
  
  let symbolAnnotationController = MGLSymbolAnnotationController(mapView: self.mapView)
  
  symbolAnnotationController.create(fromGeoJSON: symbolGeoJSON) { (annotations, error) in
    if let error = error {
      print(error.localizedDescription)
    } else if let annotations = annotations, annotations.count > 0 {
      // Do custom actions here.
    } else {
      print("No result found")
    }
  }
}
```

### Displaying callouts for style annotations

Style annotations support callouts that appear when the annotation is selected. Each callout can display additional information about its annotation.

1) To enable callouts for a style annotation, create a class property with the controller type you are enabling interaction for:

```swift
class ViewController: UIViewController {
    var mapView: MGLMapView!
    var circleAnnotationController: MGLCircleAnnotationController!
}
```

2) The style annotation must contain a title and must implement two delegate methods using the Maps SDK for iOS. The first method, `annotationCanShowCallout` should return `true`. The second method, `viewFor annotation:` should return an empty
`MGLAnnotationView` matching the size of the style annotation's shape, as shown below.

```swift
extension ViewController : MapmyIndiaMapViewDelegate {

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
      circleAnnotationController = MGLCircleAnnotationController(mapView: self.mapView)
      let circle = MGLCircleStyleAnnotation(center: CLLocationCoordinate2D(latitude: 59.31, longitude: 18.06), radius: 3.0, color: .blue)
      circle.opacity = 0.5
      circle.title = "Title"
      circleAnnotationController.add(circle)
    }

    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true;
    }

    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return MGLAnnotationView(frame: CGRect(x: 0, y: 0, width: 10, height: 10))
    }
}
```

## Supported properties

Each `MGLStyleAnnotation` class can be assigned a specific set of properties to configure its layout and style. Additionally, `MGLAnnotationController`s also have properties that can assign a specific layout property to all of its child `MGLStyleAnnotation`s. 

**MGLCircleStyleAnnotation**

- `circleRadius`
- `circleColor`
- `circleOpacity`
- `circleStrokeWidth`
- `circleStrokeColor`
- `circleStrokeOpacity`

**MGLCircleAnnotationController**

- `circleTranslation`
- `circleTranslationAnchor`
- `circlePitchAlignment`
- `circleScaleAlignment`

**MGLLineStyleAnnotation**

- `lineJoin`
- `lineBlur`
- `lineColor`
- `lineGapWidth`
- `lineOffset`
- `lineOpacity`
- `linePattern`
- `lineWidth`

**MGLLineAnnotationController**

- `lineCap`
- `lineMiterLimit`
- `lineRoundLimit`
- `lineDashPattern`
- `lineTranslation`
- `lineTranslationAnchor`

**MGLPolygonStyleAnnotation**

- `fillOpacity`
- `fillColor`
- `fillOutlineColor`
- `fillPattern`

**MGLPolygonAnnotationController**

- `fillAntialiased`
- `fillTranslation`
- `fillTranslationAnchor`

**MGLSymbolStyleAnnotation**

_Icon images_

- `iconScale`
- `iconImageName`
- `iconRotation`
- `iconOffset`
- `iconAnchor`
- `iconOpacity`
- `iconColor`
- `iconHaloColor`
- `iconHaloWidth`
- `iconHaloBlur`

_Symbol text_

- `text`
- `fontNames`
- `textFontSize`
- `maximumTextWidth`
- `textLetterSpacing`
- `textJustification`
- `textRadialOffset`
- `textAnchor`
- `textRotation`
- `textTransform`
- `textOffset`
- `textOpacity`
- `textColor`
- `textHaloColor`
- `textHaloWidth`
- `textHaloBlur`

_Icon image & symbol text_

- `symbolSortKey`

**MGLSymbolAnnotationController**

_Icon images_

- `iconAllowsOverlap`
- `iconIgnoresPlacement`
- `iconOptional`
- `iconPadding`
- `iconPitchAlignment`
- `iconRotationAlignment`
- `iconTextFit`
- `iconTranslation`
- `iconTranslationAnchor`
- `keepsIconUpright`

_Symbol text_

- `textAllowsOverlap`
- `textLineHeight`
- `textOptional`
- `textPadding`
- `textPitchAlignment`
- `textRotationAlignment`
- `textVariableAnchor`
- `textTranslation`
- `textTranslationAnchor`
- `keepsTextUpRight`
- `maximumTextAngle`

_Icon image & symbol text_

- `symbolAvoidsEdges`
- `symbolPlacement`
- `symbolSpacing`
- `symbolZOrder`