![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# MapmyIndia Nearby Search Widget for iOS

## [Introduction](#Introduction)

The MapmyIndiaNearbyUI makes it easy to integrate a widget with your iOS application. The Nearby Search widget provided as a means to enable radially search for Nearby Places on MapmyIndia Maps.

The widget offers the following basic functionalities:

- Ability to search for nearby places directly with MapmyIndia Maps visual interface.

- A single method to initiate nearby search across all categories of places available on MapmyIndia.

- Ability to get information from MapmyIndia Nearby Search widget through a callback.

## [Widget Preview](#Widget)

![](https://mmi-api-team.s3.amazonaws.com/moveSDK/ios/resources/MapmyIndiaNearbyUI/MapmyIndiaNearbyUI.gif)

<br> This can be done by following simple steps.

## Step 1 :-  [Installation](#Installation)


This widget can be installed using CocoaPods. It is available with the name `MapmyIndiaNearbyUI`.

### [Using CocoaPods](#Using-CocoaPods)

Create a Podfile with the following specification:

```
pod 'MapmyIndiaNearbyUI', '0.1.0'
```

Run `pod repo update && pod install` and open the resulting Xcode workspace.

### [Version History](#Version-History)

| Version | Dated | Description | 
| :---- | :---- | :---- |
| `0.1.5` | 01 Feb 2022 | Added support for xcode 13.2.1 |
| `0.1.4` | 28 Sep 2021 | Add support for xcode 13. |
| `0.1.3` | 06 Aug 2021 | Code optimization fixed a crash. |
| `0.1.1` | 8 Jun 2021 | Code optimization and added some UIConfiguration. | 
| `0.1.0` | 5 Apr 2021 | Initial version release with a NearbyUI widget. |

<br>

#### [Dependencies](#Dependencies)

This library depends upon several MapmyIndia's own libraries. All dependent libraries will be automatically installed using CocoaPods.

Below are list of dependencies which are required to run this SDK:

- [MapmyIndiaAPIKit](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit)
- [MapmyIndiaMaps](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki)
- [MapmyIndiaUIWidgets](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/MapmyIndiaUIWidgets)


## Step 2 :-  [Launching with default configuration](#Launching-with-default-configuration)


### [MapmyIndiaNearbyCategoriesViewController](#MapmyIndiaNearbyCategoriesViewController)

`MapmyIndiaNearbyCategoriesViewController` is type of UIViewController which is entry ViewController for MapmyIndiaNearbyUI SDK. 

```swift
let nearbyUI = MapmyIndiaNearbyCategoriesViewController()
self.navigationController?.pushViewController(nearbyUI, animated: false)
```
Thats all ! you are now ready with the MapmyIndiaNearbyUI widget within your app.

To enhance further and making UI as per your own requirements, refer to the section below:

#### [Property of MapmyIndiaNearbyCategoriesViewController](#Property-of-MapmyIndiaNearbyCategoriesViewController)

 - **mapmyIndiaNearbyCategories:** - An array of an object of type `MapmyIndiaNearbyCategories` which will help to make your own custom categories to show on `MapmyIndiaNearbyCategoriesViewController`.

It can be used as follows.
``` swift
    var  mapmyIndiaNearbyCategories = [MapmyIndiaNearbyCategories]()

    let  selectedImage = UIImage(named: "placePickerMarker")?.withRenderingMode(.alwaysTemplate)
    let categoriesImage = UIImage(named: "Coffee")

    let coffeeCategory = MapmyIndiaNearbyCategories(title: "Coffee", selectedBackgroundColor: selectedColor, unselectedBackgroundColor: .white, selectedImage: selectedImage ?? UIImage(), unselectedImage: selectedImage ?? UIImage(), unselectedTextColor: .black, selectedTextColor: .white, isSelected: true, categoryKeywords: ["FODCOF"], mapNearbyCategoryIcon: categoriesImage)

    mapmyIndiaNearbyCategories.append(coffeeCategory)

    nearbyUI.mapmyIndiaNearbyCategories = mapmyIndiaNearbyCategories

```

 - **mapmyIndiaNearbyCategoryConfiguration:-** A object of type `MapmyIndiaNearbyCategoryConfiguration` which will be required to set the UI Configuration of `MapmyIndiaNearbyCategoriesViewController` 

 - **mapmyIndiaNearbyConfiguration:-** A object of type [MapmyIndiaNearbyConfiguration](#MapmyIndiaNearbyConfiguration) which will be required in `MapmyIndiaNearbyMapViewController` to  configure the UI components and nearby request parametes.
 

- **delegate:-** A delegate object of type `MapmyIndiaNearbyCategoriesViewControllerDelegate` to provide different callbacks as per different actions of MapmyIndiaNearbyUI.

### [MapmyIndiaNearbyCategoriesViewControllerDelegate](#MapmyIndiaNearbyCategoriesViewControllerDelegate)

It is a protocol class that will be used for callback methods as shown below:

#### Call Back Handler
``` swift
    /// A delegate method which will be called when the user click next button in `MapmyIndiaNearbyCategoriesViewController` class
    /// - Parameters:
    ///   - refLocation: It is location selected from place picker  or your current location or location provided by used as refLocation.
    ///   - selectedCategories: It is the array of `MapmyIndiaNearbyCategories` items selected from the categories
    ///   - error: This will show an error message in case of any failure in `MapmyIndiaNearbyCategoriesViewController` class on next button clicked.
   
    func didNextButtonClicked(refLocation: String?, selectedCategories: [MapmyIndiaNearbyCategories]?, error: String? )
 ```

``` swift
    /// A delegate method will be called when the nearby icon is taped on the map. It will return a nearby response for the taped icon.
    /// - Parameter place: A concrete subclass of `MapmyIndiaSuggestion` to represent suggestedLocations object in results of  requests.
   
    func didSelectNearbyIcon(place: MapmyIndiaAtlasSuggestion)
 ```

 ``` swift
    /// A delegate method will be called when the nearby result in ListView is tapped. It will return a nearby response for the tapped item.
    /// - Parameter place: A concrete subclass of `MapmyIndiaSuggestion` to represent suggestedLocations object in results of  requests.
   
    func didSelectNearbySuggestionFromTable(place: MapmyIndiaAtlasSuggestion)
 ```
