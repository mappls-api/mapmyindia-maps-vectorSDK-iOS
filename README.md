![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# **MapmyIndia Vector Maps iOS SDK**

Powered with India's most comprehensive and robust mapping functionalities.
**Now Available**  for Srilanka, Nepal, Bhutan, Myanmar and Bangladesh

1. You can get your api key to be used in this document here: [https://www.mapmyindia.com/api/signup](https://www.mapmyindia.com/api/signup)

2. The sample code is provided to help you understand the basic functionality of MapmyIndia maps & REST APIs working on iOS native development platform. 

3. Explore through [238 nations](https://github.com/MapmyIndia/mapmyindia-rest-api/blob/master/docs/countryISO.md) with **Global Search, Routing and Mapping APIs & SDKs** by MapmyIndia.

## [Documentation History](#Documentation-History)

| Version | Supported SDK Version |
| ---- | ---- | 
| [v1.0.2](./docs/v1.0.2/README.md) |  - Map SDK v5.7.22 <br/> - MapmyIndiaAPIKit v1.4.23 <br/>- MapmyIndiaDirections v0.23.17 <br/> - MapmyIndiaUIWidget v0.3.8 <br/> - MapmyIndiaGeofenceUI v0.9.8 <br/> - MapmyIndiaDirectionUI v0.0.5 <br/> - MapmyIndiaNearbyUI v0.1.4 <br/> - MapmyIndiaFeedbackKit v1.0.5 <br/> - MapmyIndiaSafetyPlugin v1.0.6  <br/> - MapmyIndiaAnnotationExtension v0.0.4 |
| [v1.0.1](./docs/v1.0.1/README.md) |  - Map SDK v5.7.22 <br/> - MapmyIndiaAPIKit v1.4.22 <br/>- MapmyIndiaDirections v0.23.17 <br/> - MapmyIndiaUIWidget v0.3.8 <br/> - MapmyIndiaGeofenceUI v0.9.8 <br/> - MapmyIndiaDirectionUI v0.0.5 <br/> - MapmyIndiaNearbyUI v0.1.4 <br/> - MapmyIndiaFeedbackKit v1.0.5 <br/> - MapmyIndiaSafetyPlugin v1.0.6  <br/> - MapmyIndiaAnnotationExtension v0.0.4 |
| [v1.0.0](./docs/v1.0.0/README.md) | - Map SDK v5.7.21 <br/> - MapmyIndiaAPIKit v1.4.21 <br/>- MapmyIndiaDirections v0.23.16 <br/> - MapmyIndiaGeoanalytics v0.1.0 <br/> - MapmyIndiaUIWidget v0.3.7 <br/> - MapmyIndiaGeofenceUI v0.9.7 <br/> - MapmyIndiaDirectionUI v0.0.4 <br/> - MapmyIndiaNearbyUI v0.1.3 <br/> - MapmyIndiaFeedbackKit v1.0.4 <br/> - MapmyIndiaSafetyPlugin v1.0.5|

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
- [Vector iOS Map](docs/v1.0.2/Home.md#mapmyindia-maps-vectorSDK-iOS)
    * [Getting Started](docs/v1.0.2/Home.md#Getting-Started)
	* [API Usage](docs/v1.0.2/Home.md#API-Usage)
	* [Setup your Project](docs/v1.0.2/Home.md#Setup-your-Project)
	* [Add a MapmyIndia Map](docs/v1.0.2/Home.md#Add-a-MapmyIndia-Map)
	* [Map Interactions](docs/v1.0.2/Home.md#Map-Interactions)
	* [Map Features](docs/v1.0.2/Home.md#Map-Features)
	* [Map Events](docs/v1.0.2/Home.md#Map-Events)
	* [Map Overlays](docs/v1.0.2/Home.md#Map-Overlays)
	* [Polylines](docs/v1.0.2/Home.md#Polylines)
	* [Polygons](docs/v1.0.2/Home.md#Polygons)
	* [Map Camera](docs/v1.0.2/Home.md#Map-Camera)
	* [Miscellaneous](docs/v1.0.2/Home.md#Miscellaneous)
	* [Cluster Based Authentication](docs/v1.0.2/Getting-Started.md#Cluster-Based-Authentication)
- [MapmyIndiaGeoanalytics](docs/v1.0.2/MapmyIndiaGeoanalytics.md)
- [Set Country Regions](docs/v1.0.2/Set-Regions.md)
- [Set MapmyIndiaMap Style](docs/v1.0.2/Set-MapmyIndia-Style.md)

- [MapmyIndiaDirections](docs/v1.0.2/MapmyIndiaDirections.md#MapmyIndiaDirections)

- [REST API Kit](docs/v1.0.2/REST-API-Kit.md)

     * [Autosuggest API](docs/v1.0.2/REST-API-Kit.md#Autosuggest-API)
	 * [Reverse Geocode API](docs/v1.0.2/REST-API-Kit.md#Reverse-Geocoding-API)
	 * [Nearby API](docs/v1.0.2/REST-API-Kit.md#Nearby-API)
	 * [Place Details/eLoc Legacy API](docs/v1.0.2/REST-API-Kit.md#Place-DetailseLoc-Legacy-API)
	 * [Place Detail](docs/v1.0.2/REST-API-Kit.md#Place-Detail)
	* [Geocode API](docs/v1.0.2/REST-API-Kit.md#Geocoding-API)
	* [Routing API](docs/v1.0.2/REST-API-Kit.md#Routing-API)
	* [Driving Distance - Time Matrix API](docs/v1.0.2/REST-API-Kit.md#Driving-Distance-Time-Matrix-API)
	* [Geocoding API - Legacy](docs/v1.0.2/REST-API-Kit.md#Geocoding-API---Legacy)
	* [Routing API - Legacy](docs/v1.0.2/REST-API-Kit.md#Routing-API---Legacy)
	* [Distance Matrix API - Legacy](docs/v1.0.2/REST-API-Kit.md#Driving-Distance-Matrix-API---Legacy)
	* [POI Along The Route](docs/v1.0.2/REST-API-Kit.md#POI-Along-The-Route-API)
	* [Nearby Reports API](docs/v1.0.2/REST-API-Kit.md#Nearby-Reports-API)

- [MapmyIndia Safety Plugin](docs/v1.0.2/MapmyIndia-Safety-Plugin.md)

	- [Introduction](docs/v1.0.2/MapmyIndia-Safety-Plugin.md#Introduction)
	- [Steps to Integrate](docs/v1.0.2/MapmyIndia-Safety-Plugin.md#Steps-to-Integrate-SDK-in-an-application)
		- [Setup Your Project](docs/v1.0.2/MapmyIndia-Safety-Plugin.md#1-Setup-Your-Project)
		- [Initializion](docs/v1.0.2/MapmyIndia-Safety-Plugin.md#2-Initialization)
		- [Start Plugin](docs/v1.0.2/MapmyIndia-Safety-Plugin.md#3-Start-Plugin)
		- [Stop Safety Plugin](docs/v1.0.2/MapmyIndia-Safety-Plugin.md#4-Stop-Safety-plugin)
		- [Current Location Safety](docs/v1.0.2/MapmyIndia-Safety-Plugin.md#5-Current-Location-Safety)
		- [Enable or Disable Local Notification](docs/v1.0.2/MapmyIndia-Safety-Plugin.md#6-Enable-or-Disable-Local-Notification)
		- [MapmyIndiaSafetyPluginDelegate Protocol](docs/v1.0.2/MapmyIndia-Safety-Plugin.md#7-MapmyIndiaSafetyPluginDelegate-Protocol)

- [MapmyIndia Feedback Kit](docs/v1.0.2/MapmyIndia-Feedback-Kit.md)

- [MapmyIndia Interactive Layers](docs/v1.0.2/MapmyIndia-Interactive-Layers.md)

- [MapmyIndia Safety Strip](docs/v1.0.2/MapmyIndia-Safety-Strip.md)

- [MapmyIndia UI Widgets](docs/v1.0.2/MapmyIndiaUIWidgets.md)

	- [Introduction](docs/v1.0.2/MapmyIndiaUIWidgets.md#Introduction)
	- [Installation](docs/v1.0.2/MapmyIndiaUIWidgets.md#Installation)
		- [Version History](docs/v1.0.2/MapmyIndiaUIWidgets.md#Version-History)
	- [Autocomplete](docs/v1.0.2/MapmyIndiaUIWidgets.md#Autocomplete)
	- [Place Picker View](docs/v1.0.2/MapmyIndiaUIWidgets.md#Place-Picker-View)
	- [Autocomplete Attribution Appearance](docs/v1.0.2/MapmyIndiaUIWidgets.md#Autocomplete-Attribution-Appearance)

- [MapmyIndia Directions UI Widget](docs/v1.0.2/MapmyIndiaDirectionsUIWidget.md)

	- [Introduction](docs/v1.0.2/MapmyIndiaDirectionsUIWidget.md#Introduction)
	- [Installation](docs/v1.0.2/MapmyIndiaDirectionsUIWidget.md#Installation)
		- [Version History](docs/v1.0.2/MapmyIndiaDirectionsViewController.md#Version-History)
	- [Usage](docs/v1.0.2/MapmyIndiaDirectionsUIWidget.md#Usage)
		- [MapmyIndiaDirectionsViewController](docs/v1.0.2/MapmyIndiaDirectionsUIWidget.md#MapmyIndiaDirectionsViewController)

- [MapmyIndia Nearby UI](docs/v1.0.2/MapmyIndiaNearbyUI.md)

	- [Introduction](docs/v1.0.2/MapmyIndiaNearbyUI.md#Introduction)
	- [Installation](docs/v1.0.2/MapmyIndiaNearbyUI.md#Installation)
		- [Version History](docs/v1.0.2/MapmyIndiaNearbyUI.md#Version-History)
	- [Launching with default configuration](docs/v1.0.2/MapmyIndiaNearbyUI.md#Launching-with-default-configuration)
	- [MapmyIndiaNearbyCategoriesViewControllerDelegate](docs/v1.0.2/MapmyIndiaNearbyUI.md#MapmyIndiaNearbyCategoriesViewControllerDelegate)

- [MapmyIndiaAnnotationExtension](docs/v1.0.2/AnnotationExtension.md)

- [MapmyIndia GeofenceUI Plugin](docs/v1.0.2/MapmyIndiaGeofenceUI-Plugin.md)

- [ELocation Strategy](docs/v1.0.2/MapmyIndiaMaps-E-Location-Strategy.md)

- [Country List](https://github.com/MapmyIndia/mapmyindia-rest-api/blob/master/docs/countryISO.md)

- [Troubleshooting](docs/v1.0.2/Troubleshooting.md)


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
