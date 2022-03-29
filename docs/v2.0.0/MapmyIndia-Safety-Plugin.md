
![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

## [Introduction](#Introduction)

MapmyIndia Safety Plugin will alerts when a user in or near to a containment zone. If the app is running, a callback method will be called to get the containment zone information. Safety plugin will push a local notification when the user goes in or near to the containment zone, which can be seen from the notification panel.

The library MapmyIndiaSafetyPlugin is part of MapmyIndiaMaps SDK from version 5.7.5. MapmyIndiaMaps can be installed through Cocoapods by adding below line in pod file of project:

```cocoapods
pod 'MapmyIndiaMaps', '~> 5.7.13'
```

**Sample**

A sample to demonstrate features of MapmyIndiaSafetyPlugin can be found [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS).
Run pod install or pod update (to update existing pods) command from the terminal after downloading this sample project.

### [Version History](#Version-History)

| Version | Dated | Description |
| :---- | :---- | :---- |
| `1.0.7` | 24 Dec, 2021 | Added support for Xcode 13.2.1 |
| `1.0.6` | 29 Sep, 2021 | Added support for Xcode 13. |
| `1.0.5` | 01 May, 2021 | Xcode 12.5 compatibility. |
| `1.0.4` | 10 Dec, 2020 | Xcode 12.2 compatibility. |
| `1.0.3` | 14 Oct, 2020 | Xcode 12 compatibility. |
| `1.0.2` | 13 Aug, 2020 | Structural changes have been made to publish SDK trhough cocoapods. |
| `1.0.1` | 03 June, 2020 | Xcode 11.5 to Xcode 11.7 compatibility. |
| `1.0.0` | 12 May, 2020 | Initial Release: MapmyIndia Safety Plugin will alerts when a user in or near to a containment zone. |

## [Steps to Integrate SDK in an application](#Steps-to-Integrate-SDK-in-an-application)

## [1. Setup Your Project](#1-Setup-Your-Project)

**Below are additional steps you need to follow when you are integrating Mapmyindia Safety Plugin in your application.**

1. Create a new project in Xcode.

1. Drag and drop the mapmyindiaSafetyPlugin.framework to your project. It must be added in embedded binaries.

    **Screenshot:-**

    ![Project Settings Frameworks Embed](https://s3-ap-south-1.amazonaws.com/mmi-api-team/moveSDK/GithubDocs/SafetyPlugin/ProjectSettingsFrameworksEmbed.png)

1. Configure the location services by adding the following entries to the Info.plist file. locations and motion keys are mandatory.
    - Location permissions
    - CoreMotion Permissions

    Above permissions can be added by using below keys in Info.plist of an application:

    ```
    <key>NSLocationAlwaysAndWhenInUseUsageDescription</key>
	<string>""</string>
	<key>NSLocationAlwaysUsageDescription</key>
	<string>""</string>
	<key>NSLocationWhenInUseUsageDescription</key>
	<string>""</string>
	<key>NSMotionUsageDescription</key>
	<string>""</string>
    ```

    **Screenshot:-**
    ![Project Settings Info Plist Permissions](https://s3-ap-south-1.amazonaws.com/mmi-api-team/moveSDK/GithubDocs/SafetyPlugin/ProjectSettingsInfoPlistPermissions.png)

1. In your project settings, go to Capabilities > Background Modes and turn on background fetch, location updates.

    **Screenshot:-**

    ![Project Settings Capabilities Required](https://s3-ap-south-1.amazonaws.com/mmi-api-team/moveSDK/GithubDocs/SafetyPlugin/ProjectSettingsCapabilitiesRequired.png)


## [2. Initialization](#2-Initialization)

To use features of SDK its initialization is required which can be achieved by injecting required MapmyIndia Keys. Keys can be obtained through MapmyIndia's API **Dashboard.**

To initialize SDK code can be written in AppDelegate file which is the first entry point for an application.
So initialize it in `didFinishLaunchingWithOptions` function of AppDelegate file before using any feature of MapmyIndiaSafetyPlugin. 

To use SDK functionalities you must write import statements as shown below:

```swift
import MapmyIndiaSafetyPlugin
import mapmyindiaApikit
```

```swift
func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {

    // Below is a line of code for requesting permissions for local notifications.
    MapmyIndiaSafetyPlugin.shared.localNotificationPermission()

    // Below are lines of codes to inject MapmyIndia authorization keys.
    // ignore if you are already added these
    MapmyIndiaAccountManager.setMapSDKKey("")
    MapmyIndiaAccountManager.setRestAPIKey("")
    MapmyIndiaAccountManager.setAtlasClientId("")
    MapmyIndiaAccountManager.setAtlasClientSecret("")
    MapmyIndiaAccountManager.setAtlasGrantType("client_credentials")
    return true
}
```

Below are lines of code to fetch location when an application is in background.

```swift
func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
    MapmyIndiaSafetyPlugin.shared.backgroundfetch(completionHandler: completionHandler)
}
``` 
To initialize safety plugin call initilize method of  `MapmyIndiaSafetyPlugin` class
```swift
MapmyIndiaSafetyPlugin.shared.initilize() { (success, onfailError) in  
if success  
{  
// initialization successful

// now you can start plugin  
}  
else{  
// error if any  
}  
}  
```

## [3. Start Plugin](#3-Start-Plugin)
The plugin can start to get an alert when the user goes near or in a containment zone. We are providing some method and callbacks handler for getting a response.
The plugin will run in the background as well as in foreground, in the foreground, you will get containment zone info in a delegate method.

Start safety plugin by calling startSafetyPlugin function of `MapmyIndiaSafetyPlugin` class

 ```swift
MapmyIndiaSafetyPlugin.shared.startSafetyPlugin()
 ```


## [4. Stop Safety Plugin](#4-Stop-Safety-plugin)

 
Stop plugin by calling stopSafetyPlugin of `MapmyIndiaSafetyPlugin` class

 ``` swift
MapmyIndiaSafetyPlugin.shared.stopSafetyPlugin()
 ```

## [5. Current Location Safety](#5-Current-Location-Safety)
 
Call `getCurrentLocationSafety` to check whether it is inside or near to the containment zone.
 
```swift
MapmyIndiaSafetyPlugin.shared.getCurrentLocationSafety()
 ```

## [6. Enable or Disable Local Notification](#6-Enable-or-Disable-Local-Notification)
 
Enable/disable local notification by calling following lines of code, we are showing local notification when user is inside or near containment zone.
 
```swift
MapmyIndiaSafetyPlugin.shared.enableLocalNotification(notificationEnabled: true)
```

## [7. MapmyIndiaSafetyPluginDelegate Protocol](#7-MapmyIndiaSafetyPluginDelegate-Protocol)

`MapmyIndiaSafetyPluginDelegate` is a protocol class which have different methods which are called to indicated different states and provide data accordingly.

It has different methods for Success, Failure, Request Started etc.


```swift
extension ViewController: MapmyIndiaSafetyPluginDelegate {
    func didRequestForContainmentInfo() {

    }

    func didUpdateContainmentInfo(results: ContainmentZoneInfo) {

    }

    func didFail(error: NSError) {

    }
```

In success callback which is `didUpdateContainmentInfo` delegate method an object of type ContainmentZoneInfo is received which have different properties as explained below:

- isInsideContainmentZone (boolean) - True if user stays inside the containment  zone else false.

- containmentZoneName (String) - Name of the containment zone.

- mapLink (String) - Map link for containment zone.

- distanceToNearestZone (Long) - Distance to the nearest containment zone.

- districtName (String) - Name of the district.

- zoneType (String) - District Zone current type like red, orange and green zone.  


In failure callback which is `didFail` delegate method error object is received with different error codes as explained below:

- 400 - Bad Request

- 401 - Unauthorized

- 500-  Internal Server Error

- 503 - Service Unavailable

- In case of API return no Data then Api Message return should be Data Not found.

- Internet Not available

- Keys are not set by developer Please contact with the support team.

- Please add location permissions or coreMotion keys in plist.

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


> © Copyright 2019. CE Info Systems Pvt. Ltd. All Rights Reserved. | [Terms & Conditions](http://www.mapmyindia.com/api/terms-&-conditions)