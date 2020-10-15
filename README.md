![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# MapmyIndia Vector Maps Sample App (with SDK - Native) for iOS

**This is a sample project created to demonstrate features of different libraries available on iOS plaform. Such as MapmyIndiaMaps, MapmyIndiaAPIKit, MapmyIndiaDirections, MapmyIndiaFeedbackKit.**

**Notes:**
*From release 1.4.4 Cocoapods will be used, So there will be no need to download frameworks manually. MapmyIndiaFeedbackKit is embedded in project*
*To use sample below 1.4.4, download latest frameworks from versions list below and copy them in "Dependencies" folder of sample project.*

**Easy To Integrate Maps & Location APIs & SDKs For Web & Mobile Applications**

Powered with India's most comprehensive and robust mapping functionalities.
**Now Available**  for Srilanka, Nepal, Bhutan, Myanmar and Bangladesh

1. You can get your api key to be used in this document here: [https://www.mapmyindia.com/api/signup](https://www.mapmyindia.com/api/signup)

2. The sample code is provided to help you understand the basic functionality of MapmyIndia maps & REST APIs working on iOS native development platform. 

## [Cocoapods Version History](#Cocoapods-Version-History)

### [MapmyIndiaAPIKit](#MapmyIndiaAPIKit)

Read [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit) for more information about this module.

Also version history can be seen by following [Version History](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/REST-API-Kit#Version-History).

### [MapmyIndiaMaps](#MapmyIndiaMaps)

[Release Notes]()

| Version | Dated | Description |
| :---- | :---- | :---- |
| `5.7.13` | 14 Oct, 2020 | Xcode 12 compatibility. |
| `5.7.12` | 12 Aug, 2020 | Code improvement made for map tyles. |
| `5.7.11` | 29 July, 2020 | A info window like marker will be shown instead of default marker on click on map for covid WMS. |
| `5.7.10` | 15 July, 2020 | Fixed memory consumption issue. |
| `5.7.9` | 23 June, 2020 | Global session managed for map SDK. |
| `5.7.8` | 18 June, 2020 | Feature of showing COVID-19 safety status on map is added. On basis of this feature user's safety status can be shown on basis of user's current location. For More info goto [Safety Strip](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/MapmyIndia-Safety-Strip).|
| `5.7.7` | 08 June, 2020 | Show interactive layers(such as Covid-19) on map. For more details go to page [MapmyIndia Interactive Layers](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/MapmyIndia-Interactive-Layers). |
| `5.7.6` | 03 June, 2020 | Xcode 11.5 compatibility. |
| `5.7.5` | 12 May, 2020 | MapmyIndiaSafetyPlugin is added as dependency while installing through Cocoapods. |
| `5.7.4` | 07 May, 2020 | Issue resolved, on disabling monument layer Dem layer got disabled. |
| `5.7.3` | 28 Apr, 2020 | Fix issue of Map SDK was in Debug mode. |
| `5.7.1` | 23 Apr, 2020 | Fixed an issue where tiles were not reloading again after expiry of map access key. |
| `5.7.0` | 24 Mar, 2020 | Corona Link Button Added on map view. |

### [MapmyIndiaDirections](#MapmyIndiaDirections)

[Release Notes]()

| Version | Dated | Description |
| :---- | :---- | :---- |
| `0.23.11` | 14 Oct, 2020 | Xcode 12 compatibility. |
| `0.23.10` | 03 June, 2020 | Xcode 11.5 compatibility. |
| `0.23.9` | 13 May, 2020 | While requesting for routes, by default value of routeShapeResolution i.e "overview" (request parameter) will be full. |
| `0.23.8` | 23 Apr, 2020 | Initial release on Pods. |

### [MapmyIndiaFeedbackKit](#MapmyIndiaFeedbackKit)

Read [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/MapmyIndia-Feedback-Kit) for more information about this module.

Also version history can be seen by following [Version History](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/MapmyIndia-Feedback-Kit#Version-History).

### [MapmyIndiaUIWidgets](#MapmyIndiaUIWidgets)

Read [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/MapmyIndiaUIWidgets) for more information about this module.

Also version history can be seen by following [Version History](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/MapmyIndiaUIWidgets#Version-History).

## [Version History](#Version-History)

Below is version histroy of frameworks which were distributed through manual procedure.

| Version | Last Updated | Author | Download | Compatibility |
| ---- | ---- | ---- | ---- | ---- |
| 4.9.0 | 28 April 2020 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/RNW7TP5JCJS8/MapmyIndia_Vector_Map_SDKs_v4.9.0_27042020.zip) | Fix issue of Map SDK was in Debug mode.
| 4.9.0 | 08 April 2020 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/HMIFMKMCSWQT/MapmyIndia_Vector_Map_SDKs_v4.9.0_08042020.zip) | XCode 11.2.1+; Directions Module updated
| 4.9.0 | 03 April 2020 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/FHGUJJEK5T3F/MapmyIndia_Vector_Map_SDKs_v4.9.0_03042020.zip) | XCode 11.2.1+; SDK Authorization Improvements
| 4.9.0 | 24 March 2020 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/GWBNBIWL0YBO/MapmyIndia_Vector_Map_SDKs_v4.9.0_20032020.zip) | XCode 11.2.1+;
| 4.9.0 | 29 January 2020 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/GFECUS5KIZTA/MapmyIndia_Vector_Map_SDK_withSample_v4.9.0_29012020.zip) | XCode 11.2.1+;
| 4.9.0 | 06 December 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/XQE4GJ9SJE96/MapmyIndia_Vector_Map_SDK_withSample_v4.9.0_20112019.zip) | XCode 11.2.1; Introducing Text Search API & Indoor Mapping Feature. Adding feedback module again with latest SDK
| 4.9.0 | 20 November 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/LC7CJ4J2JQR3/MapmyIndia_Vector_Map_SDK_withSample_v4.9.0_20112019.zip) | XCode 11.1 to 11.2.1; removed feedback module for now.
| 4.9.0 | 30 October 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | ~~Download~~ | XCode 11; Myanmar added as region
| 4.9.0 | 09 October 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/55BZL282FLV6/MapmyIndia_Vector_Map_SDK_withSample_v4.9.0_09102019.zip) | XCode 11
| 4.9.0 | 20 May 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/17DTMF8VC2JV/MapmyIndia_Vector_Map_SDK_withSample_v4.9.0_20052019.zip) | XCode 10.2
| 4.9.0 | 11 April 2019 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | ~~Deleted~~ | XCode 10.2
| 4.1.1 | 17 December 2018 | MapmyIndia API Team ([RK](https://github.com/spacekingindia)) | [Download](http://downloads.mapmyindia.com/mmishare/404PIHHQM24V/MapmyIndia_Vector_Map_SDK_withSample_v4.1.1_03042019.zip) | XCode 10.1

## [Getting Started](#Getting-Started)

MapmyIndia Maps SDK for IOS lets you easily add MapmyIndia Maps and web services to your own iOS app. MapmyIndia Maps SDK for iOS supports iOS SDK 9.0 and above and Xcode 10.1 or later. You can have a look at the map and features you will get in your own app by using the MapmyIndia Maps app for iOS. The SDK handles map tiles download and their display along with a bunch of controls and native gestures.

## [API Usage](#API-Usage)
Your MapmyIndia Maps SDK usage needs a set of license keys ([get them here](http://www.mapmyindia.com/api/signup) ) and is governed by the API [terms and conditions](https://www.mapmyindia.com/api/terms-&-conditions). 
As part of the terms and conditions, you cannot remove or hide the MapmyIndia logo and copyright information in your project. 
Please see [branding guidelines](https://www.mapmyindia.com/api/advanced-maps/API-Branding-Guidelines.pdf) on MapmyIndia [website](https://www.mapmyindia.com/api) for more details.
The allowed SDK hits are described on the [plans](https://www.mapmyindia.com/api) page. Note that your usage is shared between platforms, so the API hits you make from a web application, Android app or an iOS app all add up to your allowed daily limit.

## [Setup your Project](#Setup-your-Project)

First clone repo by using below git command or any GUI tool.

`git clone git@github.com:MapmyIndia/mapmyindia-maps-vectorSDK-iOS.git`

#### Cocoapods

After cloning of this repo follow below steps

- `cd mapmyindia-maps-vectorSDK-iOS`
- `pod install` or `pod update` (to update existing pods)
- `open MapDemo.xcworkspace`

`MapmyIndiaAPIKit`, `MapmyIndiaMaps`, `MapmyIndiaDirections`, `MapmyIndiaFeedbackKit` and `MapmyIndiaUIWidgets` are available on Cocoapods which care accessible using below pod commands:

```Cocoapods
pod 'MapmyIndiaAPIKit'
pod 'MapmyIndiaMaps'
pod 'MapmyIndiaDirections'
pod 'MapmyIndiaFeedbackKit'
pod 'MapmyIndiaUIWidgets'
```

**Version histroy** on Cocoapods for each can be found above [here](#Cocoapods-Version-History)

#### Manual Procedure.

-   Drag and drop the MapmyIndia Map SDK Framework (Mapbox.framework) to your project. It must be added in embedded binaries.
-   Drag and drop the `MapmyIndiaAPIKit` Framework to your project. It must be added in embedded binaries. It is a dependent framework.
-   In the Build Phases tab of the project editor, click the + button at the top and select .New Run Script Phase.. Enter the following code into the script text field: bash `${BUILT_PRODUCTS_DIR}/${FRAMEWORKS_FOLDER_PATH}/Mapbox.framework/strip-frameworks.sh`
-   For iOS9 or later, make this change to your  
    info.plist (Project target > info.plist > Add row and set key `NSLocationWhenInUseUsageDescription`, `NSLocationAlwaysUsageDescription`)

Add your MapmyIndia Map API keys to your `AppDelegate.m` as follows

1. Add the following import statement.
#### Objective C
```objectivec
#import <MapmyIndiaAPIKit/MapmyIndiaAPIKit.h>
```
#### Swift
```swift
import MapmyIndiaAPIKit
```
2. Add the following import statement:
To initialize SDK you have to set required keys. You can achieve this using  
two ways:  
**First Way (Preferred)**  
By adding following keys in `Info.plist` file of your project `MapmyIndiaSDKKey`, `MapmyIndiaRestKey`, `MapmyIndiaAtlasClientId`, `MapmyIndiaAtlasClientSecret`, `MapmyIndiaAtlasGrantType`.

   **Second Way**  
You can also set these required keys programmatically. 
Add the following to your `application:didFinishLaunchingWithOptions`: method, replacing `restAPIKey` and `mapSDKKey` with your own API keys:

#### Objective C

```objectivec
[MapmyIndiaAccountManager setMapSDKKey:@"MAP SDK_KEY"];
[MapmyIndiaAccountManager setRestAPIKey:@"REST API_KEY"];
[MapmyIndiaAccountManager setAtlasClientId:@"ATLAS CLIENT_ID"];
[MapmyIndiaAccountManager setAtlasClientSecret:@"ATLAS CLIENT_SECRET"];
[MapmyIndiaAccountManager setAtlasGrantType:@"GRANT_TYPE"]; //always put client_credentials
[MapmyIndiaAccountManager setAtlasAPIVersion:@"1.3.11"]; // Optional; deprecated
```

#### Swift

```swift
MapmyIndiaAccountManager.setMapSDKKey("MAP SDK_KEY")
MapmyIndiaAccountManager.setRestAPIKey("REST API_KEY")
MapmyIndiaAccountManager.setAtlasClientId("ATLAS CLIENT_ID")
MapmyIndiaAccountManager.setAtlasClientSecret("ATLAS CLIENT_SECRET")
MapmyIndiaAccountManager.setAtlasGrantType("GRANT_TYPE") //always put client_credentials
MapmyIndiaAccountManager.setAtlasAPIVersion("1.3.11") // Optional; deprecated
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


> © Copyright 2019. CE Info Systems Pvt. Ltd. All Rights Reserved. | [Terms & Conditions](http://www.mapmyindia.com/api/terms-&-conditions)
> mapbox-gl-native copyright (c) 2014-2019 Mapbox.