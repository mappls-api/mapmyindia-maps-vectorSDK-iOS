![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# **MapmyIndia Vector Maps iOS SDK**

**Easy To Integrate Maps & Location APIs & SDKs For Web & Mobile Applications**

Powered with India's most comprehensive and robust mapping functionalities.
**Now Available**  for Srilanka, Nepal, Bhutan, Myanmar and Bangladesh

1. You can get your api key to be used in this document here: [https://www.mapmyindia.com/api/signup](https://www.mapmyindia.com/api/signup)

2. The sample code is provided to help you understand the basic functionality of MapmyIndia maps & REST APIs working on iOS native development platform. 

3. Explore through [238 nations](https://github.com/MapmyIndia/mapmyindia-rest-api/blob/master/docs/countryISO.md) with **Global Search, Routing and Mapping APIs & SDKs** by MapmyIndia.

## [Documentation History](#Documentation-History)

| Version | Supported SDK Version |
| ---- | ---- | 
| [v1.0.3](./README.md) | - MapmyIndiaAPIKit v1.4.24 <br/>- MapmyIndiaDirections v0.23.19 <br/> - MapmyIndiaUIWidget v0.3.10 <br/>  - MapmyIndiaFeedbackKit v1.0.7 <br/> - MapmyIndiaSafetyPlugin v1.0.7 <br/> - MapmyIndiaGeofenceUI v0.9.9|
| [v1.0.2](../v1.0.2/README.md) |  - Map SDK v5.7.22 <br/> - MapmyIndiaAPIKit v1.4.23 <br/>- MapmyIndiaDirections v0.23.17 <br/> - MapmyIndiaUIWidget v0.3.8 <br/> - MapmyIndiaGeofenceUI v0.9.8 <br/> - MapmyIndiaDirectionUI v0.0.5 <br/> - MapmyIndiaNearbyUI v0.1.4 <br/> - MapmyIndiaFeedbackKit v1.0.5 <br/> MapmyIndiaSafetyPlugin v1.0.6 <br/> - MapmyIndiaAnnotationExtension v0.0.4 |
| [v1.0.1](../v1.0.1/README.md) |  - Map SDK v5.7.22 <br/> - MapmyIndiaAPIKit v1.4.22 <br/>- MapmyIndiaDirections v0.23.17 <br/> - MapmyIndiaUIWidget v0.3.8 <br/> - MapmyIndiaGeofenceUI v0.9.8 <br/> - MapmyIndiaDirectionUI v0.0.5 <br/> - MapmyIndiaNearbyUI v0.1.4 <br/> - MapmyIndiaFeedbackKit v1.0.5 <br/> MapmyIndiaSafetyPlugin v1.0.6 <br/> - MapmyIndiaAnnotationExtension v0.0.4 |
| [v1.0.0](../v1.0.0/README.md) | - Map SDK v5.7.21 <br/> - MapmyIndiaAPIKit v1.4.21 <br/>- MapmyIndiaDirections v0.23.16 <br/> - MapmyIndiaGeoanalytics v0.1.0 <br/> - MapmyIndiaUIWidget v0.3.7 <br/> - MapmyIndiaGeofenceUI v0.9.7 <br/> - MapmyIndiaDirectionUI v0.0.4 <br/> - MapmyIndiaNearbyUI v0.1.3 <br/> - MapmyIndiaFeedbackKit v1.0.4 <br/> MapmyIndiaSafetyPlugin v1.0.5|

## [Version History](#Version-History)

| Version | Dated | Description |
| :---- | :---- | :---- |
| `5.7.22` | 30 Sep, 2021 | Bug fixes and improvements. |
| `5.7.21` | 08 Sep, 2021 | Improvements.|
| `5.7.20` | 23 Aug, 2021 | Fixed a crash and some code improvements.|
| `5.7.19` | 21 May, 2021 | Fixed a crash. Integrated a style API which will help in rendering specific style as well as facilitate the switching of style themes. A default style is set for all account users to start with.|
| `5.7.18` | 29 Apr, 2021 | Fixed a crash which was due to key observer. <br> Some UI Optimization has been made where current location view stucks while packaging app using xcode 12. <br> A dependency `MapmyIndiaSafetyPlugin` removed from podspec file.|
| `5.7.17` | 18 Feb, 2021 | Performance optimization. |
| `5.7.16` | 27 Jan, 2021 | Fixed an issue where on failing of Session initialization due to token expiry, it will refresh token and reinitialize session. |
| `5.7.15` | 03 Dec, 2020 | Xcode 12.2 compatibility. Functions are added for e-Loc Strategy. See wiki pages. |
| `5.7.14` | 20 Oct, 2020 | ReactNative related issues are fixed.|

## [Table Of Content](#Table-Of-Content)
- [Vector iOS Map](./mapmyindia-maps-vectorSDK-iOS)
    * [Getting Started](./Home.md#Getting-Started)
	* [API Usage](./Home.md#API-Usage)
	* [Setup your Project](./Home.md#Setup-your-Project)
	* [Add a MapmyIndia Map](./Home.md#Add-a-MapmyIndia-Map)
	* [Map Interactions](./Home.md#Map-Interactions)
	* [Map Features](./Home.md#Map-Features)
	* [Map Events](./Home.md#Map-Events)
	* [Map Overlays](./Home.md#Map-Overlays)
	* [Polylines](./Home.md#Polylines)
	* [Polygons](./Home.md#Polygons)
	* [Map Camera](./Home.md#Map-Camera)
	* [Miscellaneous](./Home.md#Miscellaneous)
	* [Cluster Based Authentication](./Getting-Started.md#Cluster-Based-Authentication)
- [MapmyIndiaGeoanalytics](./MapmyIndiaGeoanalytics.md)
- [Set Country Regions](./Set-Regions.md)
- [Set MapmyIndiaMap Style](./Set-MapmyIndia-Style.md)

- [REST API Kit](./REST-API-Kit.md)

     * [Autosuggest API](./REST-API-Kit.md#Autosuggest-API)
	 * [Reverse Geocode API](./REST-API-Kit.md#Reverse-Geocoding-API)
	 * [Nearby API](./REST-API-Kit.md#Nearby-API)
	 * [Place Details/eLoc Legacy API](./REST-API-Kit.md#Place-DetailseLoc-Legacy-API)
	 * [Place Detail](./REST-API-Ki.mdt#Place-Detail)
	* [Geocode API](./REST-API-Kit.md#Geocoding-API)
	* [Routing API](./REST-API-Kit.md#Routing-API)
	* [Driving Distance - Time Matrix API](./REST-API-Kit.md#Driving-Distance-Time-Matrix-API)
	* [Geocoding API - Legacy](./REST-API-Kit.md#Geocoding-API---Legacy)
	* [Routing API - Legacy](./REST-API-Kit.md#Routing-API---Legacy)
	* [Distance Matrix API - Legacy](./REST-API-Kit.md#Driving-Distance-Matrix-API---Legacy)
	* [POI Along The Route](./REST-API-Kit.md#POI-Along-The-Route-API)
	* [Nearby Reports API](./REST-API-Kit.md#Nearby-Reports-API)

- [MapmyIndiaDirections](./MapmyIndiaDirections.md#MapmyIndiaDirections)

- [MapmyIndia Safety Plugin](./MapmyIndia-Safety-Plugin.md)

	- [Introduction](./MapmyIndia-Safety-Plugin.md#Introduction)
	- [Steps to Integrate](./MapmyIndia-Safety-Plugin.md#Steps-to-Integrate-SDK-in-an-application)
		- [Setup Your Project](./MapmyIndia-Safety-Plugin.md#1-Setup-Your-Project)
		- [Initializion](./MapmyIndia-Safety-Plugin.md#2-Initialization)
		- [Start Plugin](./MapmyIndia-Safety-Plugin.md#3-Start-Plugin)
		- [Stop Safety Plugin](./MapmyIndia-Safety-Plugin.md#4-Stop-Safety-plugin)
		- [Current Location Safety](./MapmyIndia-Safety-Plugin.md#5-Current-Location-Safety)
		- [Enable or Disable Local Notification](./MapmyIndia-Safety-Plugin.md#6-Enable-or-Disable-Local-Notification)
		- [MapmyIndiaSafetyPluginDelegate Protocol](./MapmyIndia-Safety-Plugin.md#7-MapmyIndiaSafetyPluginDelegate-Protocol)

- [MapmyIndia Feedback Kit](./MapmyIndia-Feedback-Kit.md)

- [MapmyIndia Interactive Layers](./MapmyIndia-Interactive-Layers.md)

- [MapmyIndia Safety Strip](./MapmyIndia-Safety-Strip.md)

- [MapmyIndia UI Widgets](./MapmyIndiaUIWidgets.md)

	- [Introduction](./MapmyIndiaUIWidgets.md#Introduction)
	- [Installation](./MapmyIndiaUIWidgets.md#Installation)
		- [Version History](./MapmyIndiaUIWidgets.md#Version-History)
	- [Autocomplete](./MapmyIndiaUIWidgets.md#Autocomplete)
	- [Place Picker View](./MapmyIndiaUIWidgets.md#Place-Picker-View)
	- [Autocomplete Attribution Appearance](./MapmyIndiaUIWidgets.md#Autocomplete-Attribution-Appearance)

- [MapmyIndia Directions UI Widget](./MapmyIndiaDirectionsUIWidget.md)

	- [Introduction](./MapmyIndiaDirectionsUIWidget.md#Introduction)
	- [Installation](./MapmyIndiaDirectionsUIWidget.md#Installation)
		- [Version History](./MapmyIndiaDirectionsViewController.md#Version-History)
	- [Usage](./MapmyIndiaDirectionsUIWidget.md#Usage)
		- [MapmyIndiaDirectionsViewController](./MapmyIndiaDirectionsUIWidget.md#MapmyIndiaDirectionsViewController)

- [MapmyIndia Nearby UI](./MapmyIndiaNearbyUI.md)

	- [Introduction](./MapmyIndiaNearbyUI.md#Introduction)
	- [Installation](./MapmyIndiaNearbyUI.md#Installation)
		- [Version History](./MapmyIndiaNearbyUI.md#Version-History)
	- [Launching with default configuration](./MapmyIndiaNearbyUI.md#Launching-with-default-configuration)
	- [MapmyIndiaNearbyCategoriesViewControllerDelegate](./MapmyIndiaNearbyUI.md#MapmyIndiaNearbyCategoriesViewControllerDelegate)

- [MapmyIndiaAnnotationExtension](./AnnotationExtension.md)

- [MapmyIndia GeofenceUI Plugin](./MapmyIndiaGeofenceUI-Plugin.md)

- [ELocation Strategy](./MapmyIndiaMaps-E-Location-Strategy.md)

- [Country List](https://github.com/MapmyIndia/mapmyindia-rest-api/blob/master/docs/countryISO.md)

- [Troubleshooting](./Troubleshooting.md)


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
> MapmyIndia-gl-native copyright (c) 2014-2019 MapmyIndia.
