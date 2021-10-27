
![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# [Set MapmyIndiaMaps style](#Set-MapmyIndiaMaps-style)

MapmyIndia offers a range of preset styles to rendering the map. The user has to retrieve a list of styles for a specific account. 
The listing api would help in rendering specific style as well as facilitate the switching of style themes. 

From the below reference code it would become quite clear that user has to specify style names and not URLs to use them. 
A default style is set for all account users to start with. 
To know more about available styles, kindly contact apisupport@mapmyindia.com

**This feature is available from version v5.7.19**

## [List of Available Styles](#list-of-available-styles)

Subscribe the delegate to get the list of available styles:

#### Swift
```
func didLoadedMapmyIndiaMapsStyles(_ mapView: MapmyIndiaMapView, styles: [MapmyIndiaMapStyle], withError error: Error?)
```

#### Objective C
```
- (void)didLoadedMapmyIndiaMapsStyles:(MapmyIndiaMapView *)mapView styles:(NSArray<MapmyIndiaMapStyle *> *)styles withError:(nullable NSError *)error;
```

`MapmyIndiaMapStyle` contains below parameters:

 1. `style_Description(String)`: Description of the style
 2. `displayName(string)`: Generic Name of style mostly used in MapmyIndia content.
 3. `imageUrl(String)`: Preview Image of style
 4. `name(String)`: Name of style used to change the style.

## [Set MapmyIndiaMaps Style](#set-mapmyindia-style)
To set MapmyIndiaMaps style reference code is below:
#### Swift
```
mapView.setMapmyIndiaMapsStyle("style Name")
```

#### Objective C
```
[self.mapView setMapmyIndiaMapsStyle:@"Style Name"];
```

## [To enable/disable last selected style](#To-enable-last-selected-style)
To enable/disable loading of last selected style:

#### Swift
```
MapmyIndiaMapConfiguration.setIsShowPreferedMapStyle(false) // true is enable & false is disable(default value is true) 
``` 
#### Objective C
```
[MapmyIndiaMapConfiguration setIsShowPreferedMapStyle:false]; //true is enable & false is disable(default value is true)
```

## [didSetMapmyIndiaMapsStyle](#didSet-MapmyIndiaMaps-Style)
Tells the delegate that the style set by user is valid or not.
#### Swift
```
func didSetMapmyIndiaMapsStyle(_ mapView: MapmyIndiaMapView, isSuccess: Bool, withError error: Error?)
```
#### Objective C
```
-(void)didSetMapmyIndiaMapsStyle:(MapmyIndiaMapView *)mapView isSuccess:(BOOL)isSuccess withError:(nullable NSError *)error;
```


For any queries and support, please contact: 

![Email](https://www.google.com/a/cpanel/mapmyindia.co.in/images/logo.gif?service=google_gsuite)