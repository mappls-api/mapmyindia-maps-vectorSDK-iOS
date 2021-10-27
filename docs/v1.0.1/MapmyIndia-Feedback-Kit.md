![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# MapmyIndiaFeedbackKit for iOS

## [Introduction](#Introduction)

Feedback Kit for IOS is a wrapper SDK for MapmyIndia's feedback API. It allows developers to integrate feedback module in their application. Using feedback module user can submit location related feedback to MapmyIndia's server.

**Note:** Sample for UI view controllers with source code is also provided by MapmyIndia which user can directly use to show feedback screen. Information about how to use UI sample is also provided in this documentation.

If you don’t want to implement own logic and use sample from MapmyIndia Jump to Sample UI Kit section.

### [Version History](#Version-History)

| Version | Dated | Description |
| :---- | :---- | :---- |
| `1.0.5` | 28 Sep, 2021 |added support for xcode 13 |
| `1.0.4` | 12 jul, 2021 |added support for xcode 12.5 |
| `1.0.3` | 25 Feb, 2021 | improvments |
| `1.0.2` | 10 Dec, 2020 | Xcode 12.2 compatibility. |
| `1.0.1` | 14 Oct, 2020 | Xcode 12 compatibility. |			
| `1.0.0` | 05 June, 2020 | Initial release through CocoaPods. |

## [Setup your Project](#Setup-your-Project)

Steps to add feedback module into application project:

- Create a new project in Xcode.

- Drag and drop the MapmyIndiaFeedbackKit.framework to your project. It must be added in embedded binaries.

## [Usage](#Usage)

**Steps to submit feedback:**

1. An authoraization key i.e moduleId (provided by MapmyIndia) against which feedback will be submitted wiil be required to use this SDK .

1. List of categories need to be fetched first under which feedback will be submitted. For more informatatio see [here](#Get-Report-Categories).

    **Notes:**

    - Fetched report categories can be saved for offline use or to prevent fetching report categories multiple times.

    - It will require to separate out them on basis of parentId i.e Separate as Parent and Child Categories, where if parent Id is null means they are parent categories otherwise child of some parent category.
    **Note:** ParentId of a child category is reportId of parent category.

1. On basis of parent and child categories, different User Interfaces or scenarios can be designed as per requirements.

1. User must pass have location oordinate for which feedback will be submitted.

1. After selecting of parent and child category user must take some input as a text for feedback.

1. After Collection all values i.e Module Id, Location Coordinates, Parent Category, Child Category and Feedback Text, feedback can be submitted using functions available in this SDK. See [here](#Submit-Feedback).

## [Get Report Categories](#Get-Report-Categories)

Categories for reporting can be fetched using getReportCategories method of MapmyIndiaFeedbackKit class by using shared instance.
In response you will receive an error or an array of MapmyIndiaReportCategories. Yo will find below useful properties in reportCategories object which is an array of  `ParentCategories`:

- *ParentCategories*

- *ChildCategories*

- *SubChildCategories*

##### Swift

```swift
MapmyIndiaFeedbackKit.shared.getReportCategories { (reportCategories, error)  in
    if let error = error {
        print(error.localizedDescription)
        self.dismiss(animated: true, completion: nil)
    } else {
        let categories = reportCategories ?? [ParentCategories]()
        if categories.count > 0 {
            self.allReportCategories = categories
            print(self.allReportCategories.first?.id)
            self.currentStep = 1
        } else {
            print("No report categories found")
            self.dismiss(animated: true, completion: nil)
        }
}
```

## [Submit Feedback](#Submit-Feedback)

To submit feedback on MapmyIndia server you can use `saveUserData` function of `MapmyIndiaSaveUserDataAPIManager` class by using shared instance.

`saveUserData` function will accept an object of `MapmyIndiaSaveUserDataOptions` class.

To create instance of MapmyIndiaSaveUserDataOptions user provide following parameters.

### [Mandatory Parameters](#Mandatory-Parameters)
1. location(String) : It can be either eLoc (The 6-digit alphanumeric code for any location) or coordinate (latitude, longitude) in `string` format.
1. parentCategory(Integer) : Parent category of the report. 
1. childCategory (Integer) : Child category of the report. 

### [Optional Parameters](#Optional-Parameters)
1. placeName(string) : Name of the place where the event is taking place. It should be derived on the basis of eloc and coordinates.
2. desription(String) : A description about your event. Min length 10 characters and Max length 250 characters.
3. subChildCategory(Integer)(Internal) : Sub Child category of the report. 
4. flag(Integer) : If navroute is active then 1 else 0. 
5. speed(Integer) : User's speed in kilometers. 
6. alt(Integer) : Altitude of the user’s location, in meters. 
7. quality(Integer) : Quality of user's location. 
8. bearing(Integer) : Bearing of the user’s location, in degrees. 
9. accuracy(Integer) : Accuracy of user's location. 
10. utc(Long) : Date time in unix timestamp format. 
11. expiry(Long) : Date time in unix timestamp format to set expiry for the report. 
12. zeroId(String) : to be used only incase of NAVIMAPS . 
13. pushEvent(Boolean)(internal) : to be used only when traffic events are to be pushed back to the traffic event editor. Allowed values: a) true 
b) false 
14. appVersion(String) : Version of the app 
15. osVersionoptional(String) : Version of the os 
16. deviceName(String) : Name of the device 



##### Swift

```swift
let saveOptions = MapmyIndiaSaveUserDataOptions(location: "MMI000", parentCategory: parentCategory.id ?? 0, childCategory: childCategory.id ?? 0, description: "This is descriptions", subChildCategory: self.selectedSubChildCategories?.id, accuracy: 3)

MapmyIndiaSaveUserDataAPIManager.shared.saveUserData(saveOptions, { (isSucess, error) in

    if let error = error {
        print(error.localizedDescription)
    } else if isSucess {
        print("feedback submited successfully")
        self.dismiss(animated: true, completion: nil)
    } else {
        print("No results")
    }
})
```

# [MapmyIndia Feedback UI Kit](#MapmyIndia-Feedback-UI-Kit)

A UI control `MapmyIndiaFeedbackUIKit` is available with sourece code to use SDK MapmyIndiaFeedbackKit which is including in sample application project. Sample application project can be download from [here](#https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS).


### Usage

`MapmyIndiaFeedbackUIKitManager` is the class which will help to use this UI Control.Access shared instance of that class and call `getViewController` method to get instance of ViewController and present or push according to requirement.

##### Objective-C

```objectivec
CLLocation *location = [[CLLocation alloc] initWithLatitude:_mapView.centerCoordinate.latitude longitude:_mapView.centerCoordinate.longitude];

UINavigationController *navVC = [[MapmyIndiaFeedbackUIKitManager sharedManager] getViewControllerWithLocation:location moduleId:ModuleId];
[self presentViewController:navVC animated:YES completion:nil];
```

##### Swift

```swift
let navVC = MapmyIndiaFeedbackUIKitManager.shared.getViewController(location: CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude), moduleId: ModuleId)

self.present(navVC, animated: true, completion: nil)
```

`MapmyIndiaFeedbackUIKit` implicitly use functionalities of MapmyIndiaFeedbackKit module and provides a beautiful user expereience to submit feedback.

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
