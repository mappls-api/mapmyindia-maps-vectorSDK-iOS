![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# MapmyIndiaAPIKit: REST API Kit for iOS

## [Introduction](#Introduction)

This SDK includes different API wrapper available with MapmyIndia.

These APIs are easy to integrate and use with different configurable parameters.

Powered with India's most comprehensive and robust mapping functionalities.
**Now Available**  for Srilanka, Nepal, Bhutan and Bangladesh

1. You can get your api key to be used in this document here: [https://www.mapmyindia.com/api/signup](https://www.mapmyindia.com/api/signup)

2. The sample code is provided to help you understand the basic functionality of MapmyIndia REST APIs working on iOS native development platform. 

## [Version History](#Version-History)

| Version | Dated | Description |
| :---- | :---- | :---- |
| `1.4.23` | 01 Nov 2021 | `isBridgeEnabled` parameter in Autosuggest. API wrapper of `Traffic Details`. |
| `1.4.22` | 28 Sep 2021 | Added support for xcode 13|
| `1.4.21` | 08 Sep 2021 | Improvement and bug fixes.|
| `1.4.20` | 25 Aug 2021 | Nearby report API wrapper added and AtlasGrantType is optional to set by user|
| `1.4.19` | 22 July 2021 | Added `hyperLocal` parameter and added additional enum values in `MMIRegionTypeIdentifier` to set default region. |
| `1.4.18` | 30 Apr, 2021 | Added support for Xcode 12.5 |
| `1.4.17` | 23 Apr, 2021 | Enabled support of multiple queries in class `MapmyIndiaAtlasOptions`. Bug Fixed and Changes the response type from `MapmyIndiaSuggestion`  to `NearbyResult`|
| `1.4.16` | 17 Mar, 2021| Added support for xcode 12.4|
| `1.4.15` | 18 Feb, 2021 |To show/hide authorisation fail overlay view, a property `isHiddenAuthorizationFailOverlay` is added in shared class `MapmyIndiaAccountManager`. In nearby API wrapper, for value of filter a property `logicalOperator` of enum `MapmyIndiaLogicalOperator` type  is added. |
| `1.4.14` | 08 Jan, 2021 | In Nearby refLocation can be set an eLoc. In Distance Matrix locations can be set either eLoc or comma seperated coordinate(In format longitude, latitude). |
| `1.4.13` | 03 Dec, 2020 | Xcode 12.2 compatibility. `MapmyIndiaPlaceDetailManager` is renamed to `MapmyIndiaPlaceDetailLegacyManager`. New `MapmyIndiaPlaceDetailManager` created. In request of Nearby `pod` parameter added and in response `hourOfOperation` is added. |
| `1.4.12` | 26 Nov, 2020 | Bug is fixed where app was crashing while using MapmyIndiaUIWidgets module, in caller of feedback API. Code improved for refreshing access token. |
| `1.4.11` | 09 Nov, 2020 | Access token will be refreshed internally, On getting token expiry error while using any API wrapper. |
| `1.4.10` | 20 Oct, 2020 | Fixed issue of Nearby API where on using feature of pagination it was throwing error. |
| `1.4.9` | 14 Oct, 2020 | Xcode 12 compatibility. |
| `1.4.8` | 01 Sep, 2020 | An API wrapper is added for API of POI (Places of Interest) Along The Route. |
| `1.4.7` | 14 Aug, 2020 | In API wrapper of Nearby new Request and Response parameters are added. |
| `1.4.6` | 12 Aug, 2020 | Changes for Map SDK version 5.7.12 |
| `1.4.5` | 29 Jul, 2020 | Isssue resolved where style parameter was not passed in Covid Information API call. |
| `1.4.4` | 23 Jun, 2020 | Support for global Map session added. (For Map SDK version - 5.7.9). |
| `1.4.3` | 18 Jun, 2020 | Some classes are created which is to be used in Maps SDK (version - 5.7.8). |
| `1.4.2` | 08 Jun, 2020 | Interactive layer support for Map SDK. |
| `1.4.1` | 03 Jun, 2020 | Xcode 11.5 compatibility. |
| `1.4.0` | 07 May, 2020 | In Nearby API's request sortBy, searchBy and filter parameters added and in response pageInfo object is added. For AutoSuggest API caller, a new class `MapmyIndiaPinFilter` created to set its object in filter request parameter. |
| `1.3.12` | 28 Apr, 2020 | Fix issue of Map SDK was in Debug mode. |
| `1.3.11` | 21 Apr, 2020 | Feedback API wrapper added which can be used using `MapmyIndiaFeedbackAPIManager`. |
| `1.3.10` | 24 Mar, 2020 | Minor fixes for tile issue (For Map SDK). |
| `1.3.9` | 24 Mar, 2020 | Promotional API wrapper added (For Map SDK to show Corona Link Button), Geocode API issue fixed for not getting eLco parameter. |
| `1.3.8` | 11 Dec, 2019 | Configuration settings added to enable disable default Indoor UI. |

## [Getting Started](#Getting-Started)

MapmyIndia Maps SDK for IOS lets you easily add MapmyIndia Maps and web services to your own iOS app. MapmyIndia Maps SDK for iOS supports iOS SDK 9.0 and above and Xcode 10.1 or later. You can have a look at the map and features you will get in your own app by using the MapmyIndia Maps app for iOS. The SDK handles map tiles download and their display along with a bunch of controls and native gestures.

## [API Usage and Requirements](#API-Usage-and-Requirements)
Your MapmyIndia Maps SDK usage needs a set of license keys ([get them here](http://www.mapmyindia.com/api/signup) ) and is governed by the API [terms and conditions](https://www.mapmyindia.com/api/terms-&-conditions). 
As part of the terms and conditions, you cannot remove or hide the MapmyIndia logo and copyright information in your project. 
Please see [branding guidelines](https://www.mapmyindia.com/api/advanced-maps/API-Branding-Guidelines.pdf) on MapmyIndia [website](https://www.mapmyindia.com/api) for more details.
The allowed SDK hits are described on the plans page. Note that your usage is
shared between platforms, so the API hits you make from a web application, Android app or an iOS app all add up to your allowed daily limit.

MapmyIndia's keys must be set to initialize SDKs. Which can  be set in two ways.

**First Way**
You can also set these required keys programmatically. Add the following to your application:didFinishLaunchingWithOptions: method, replacing restAPIKey and mapSDKKey with your own API keys:

```swift
MapmyIndiaAccountManager.setMapSDKKey("MAP SDK_KEY")
MapmyIndiaAccountManager.setRestAPIKey("REST API_KEY")
MapmyIndiaAccountManager.setAtlasClientId("ATLAS CLIENT_ID")
MapmyIndiaAccountManager.setAtlasClientSecret("ATLAS CLIENT_SECRET")
MapmyIndiaAccountManager.setAtlasGrantType("GRANT_TYPE") //always put client_credentials
```

**Second Way**
By adding following keys in Info.plist file of your project MapmyIndiaSDKKey, MapmyIndiaRestKey, MapmyIndiaAtlasClientId, MapmyIndiaAtlasClientSecret, MapmyIndiaAtlasGrantType.


## [Autosuggest API](#Autosuggest-API)

For live demo click [LIVE DEMO](https://www.mapmyindia.com/api/advanced-maps/doc/sample/mapmyindia-maps-auto-suggest-api-example.php)

Get "type as you go" suggestion while searching for a location.

The Autosuggest API helps users to complete queries faster by adding intelligent search capabilities to your web or mobile app. This API returns a list of results as well as suggested queries as the user types in the search field.

The Autosuggest helps users to complete queries faster by adding intelligent search capabilities to your iOS mobile app. It takes a human readable query such as place name, address or eLoc and returns a list of results.


Class used for Autosuggest search is `MapmyIndiaAutoSuggestManager`. Create a `MapmyIndiaAutoSuggestManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaAutoSuggestManager` class.

To perform auto suggest use `MapmyIndiaAutoSearchAtlasOptions` class to pass query parameter to get auto suggest search with an option to pass region in parameter `withRegion`, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

Additionally you can also set location and restriction filters in object of `MapmyIndiaAutoSearchAtlasOptions`. 

### Request Parameters

1.  **location:**  Location is required to get location bias autosuggest results.
2.  **zoom:**  takes the zoom level of the current scope of the map (min: 4, max: 18).
3.  **includeTokenizeAddress**: On setting value of this property to true it provides the different address attributes in a structured object in response.
4.  **pod**: It takes place type which helps in restricting the results to certain chosen type  
    Below mentioned are the codes for the pod -
    -   Sublocality
    -   Locality
    -   City
    -   Village
    -   Subdistrict
    -   District
    -   State
    -   Subsublocality
5.  **filter**: This helps you restrict the result either by mentioning a bounded area or to certain eLoc. Below mentioned are both types whose instance can be set to this parameter -
    -   (a) `MapmyIndiaElocFilter`: to filter results on basis of eLoc
    -   (b) `MapmyIndiaBoundsFilter`: to filter results on basis of geo bound.
6. **hyperLocal**: This parameter lets the search give results that are hyper-localized to the reference location passed in the location parameter. This means that nearby results are given a higher ranking than results far from the reference location. Highly prominent results will still appear in the search results, however they will be lower in the list of results. This parameter will work ONLY in conjunction with the location parameter.
7.  **isBridgeEnabled:**  To get suggested searches in response. Value must be set `true` of this.

### Response Parameters

In response of auto suggest search either you will receive an error or an array of `MapmyIndiaAtlasSuggestion`, Where `MapmyIndiaAtlasSuggestion` is derived from `MapmyIndiaSuggestion` class. Yo will find below useful properties in suggestion object :

1.  **type:**  type of location POI or Country or City
2.  **eLoc:**  Place Id of the location 6-char alphanumeric.
3.  **placeAddress:**  Address of the location.
4.  **latitude:**  Latitude of the location.
5.  **longitude:**  longitude of the location.
6.  **entranceLatitude:**  entry latitude of the location
7.  **entrancelongitude:**  entry longitude of the location
8.  **placeName:**  Name of the location.
9.  **orderIndex:**  the order where this result should be placed
10.  **addressTokens**:

       **houseNumber**: house number of the location.

	   **houseName**: house name of the location.

	   **poi**: name of the POI (if applicable)

	 **street**: name of the street. (if applicable)

	 **subSubLocality**: the sub-sub-locality to which the location belongs. (if applicable)

	 **subLocality**: the sub-locality to which the location belongs. (if applicable)

	 **locality**: the locality to which the location belongs. (if applicable)

	 **village**: the village to which the location belongs. (if applicable)

	  **subDistrict**: the sub-district to which the location belongs. (if applicable)

	  **district**: the district to which the location belongs. (if applicable)

	 **city**: the city to which the location belongs. (if applicable)

	 **state**: the state to which the location belongs. (if applicable)

	  **pincode**: the PIN code to which the location belongs. (if applicable)
  


### Code Samples[Deprecated]

#### Objective C
```objectivec
MapmyIndiaAutoSuggestManager * autoSuggestManager =
[MapmyIndiaAutoSuggestManager sharedManager]
// or
MapmyIndiaAutoSuggestManager *autoSearchManager =
[[MapmyIndiaAutoSuggestManager alloc]
initWithRestKey:MapmyIndiaAccountManager.restAPIKey
clientId:MapmyIndiaAccountManager.atlasClientId
clientSecret:MapmyIndiaAccountManager.atlasClientSecret
grantType:MapmyIndiaAccountManager.atlasGrantType]

MapmyIndiaAutoSearchAtlasOptions * autoSuggestOptions =
[[MapmyIndiaAutoSearchAtlasOptions alloc] initWithQuery:@"mmi000"
withRegion:MMIRegionTypeIdentifierDefault];

[autoSuggestManager getAutoSuggestionsWithOptions:autoSearchOptions
completionHandler:^(NSArray<MapmyIndiaAtlasSuggestion *> * _Nullable
suggestions, NSError * _Nullable error) {
		if (error) {
			NSLog(@"%@", error);
				} else if (suggestions.count > 0) {
			NSLog(@"Auto Suggest %@%@",
			suggestions[0].latitude,suggestions[0].longitude);
			self.resultsLabel.text = suggestions[0].placeAddress;
		} else {
			self.resultsLabel.text = @"No results";
		}
	}];
```
#### Swift
```swift
let autoSuggestManager = MapmyIndiaAutoSuggestManager.shared
//Or
let autoSuggestManager = MapmyIndiaAutoSuggestManager(restKey:
MapmyIndiaAccountManager.restAPIKey(), clientId:
MapmyIndiaAccountManager.atlasClientId(), clientSecret:
MapmyIndiaAccountManager.atlasClientSecret(), grantType:
MapmyIndiaAccountManager.atlasGrantType())

let autoSuggestOptions = MapmyIndiaAutoSearchAtlasOptions(query: "mmi000",
withRegion: .india)
	autoSuggestOptions.location = CLLocation(latitude: 28.2323234, longitude: 72.3434123)
	autoSuggestOptions.zoom = 5
	autoSuggestManager.getAutoSuggestions(autoSuggestOptions) { (suggestions, error) in
		if let error = error {
			NSLog("%@", error)
		} else if let suggestions = suggestions, !suggestions.isEmpty {
			print("Auto Suggest: \(suggestions[0].latitude ?? 0),\
			(suggestions[0].longitude ?? 0)")
			self.resultsLabel.text = suggestions[0].placeAddress
		} else {
			self.resultsLabel.text = "No results"
		}
	}
```


For more details visit our [online documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Autosuggest).

### Code Samples[New]
#### Suggested Searches

A new method `getAutoSuggestionResults` is introduced, To get Suggested Searches along with Suggested Location results. Type of response from above function is `MapmyindiaAutoSuggestLocationResults` which is derived from class `MapmyindiaLocationResults`.

Below is sample code to understand this.

```swift
let autoSuggestManager = MapmyIndiaAutoSuggestManager.shared
//Or
let autoSuggestManager = MapmyIndiaAutoSuggestManager(restKey:
        MapmyIndiaAccountManager.restAPIKey(), clientId:
        MapmyIndiaAccountManager.atlasClientId(), clientSecret:
        MapmyIndiaAccountManager.atlasClientSecret(), grantType:
        MapmyIndiaAccountManager.atlasGrantType())

let autoSuggestOptions = MapmyIndiaAutoSearchAtlasOptions(query: "Coffee",
                                                                  withRegion: .india)
autoSuggestOptions.location = CLLocation(latitude: 28.2323234, longitude: 72.3434123)
autoSuggestOptions.isBridgeEnabled = true
autoSuggestOptions.zoom = 5
autoSuggestManager.getAutoSuggestionResults(autoSuggestOptions) { suggestions, error in
	if let error = error {
		print(error.localizedDescription)
	} else if let results = suggestions,
		let autoSuggestResults = results as? MapmyindiaAutoSuggestLocationResults {
		if let suggestionResutls = autoSuggestResults.suggestions, suggestionResutls.count > 0 {
			// You will get suggested locations here.
		}
		if let suggestedSearches = autoSuggestResults.suggestedSearches, suggestedSearches.count > 0 {
			// You will get suggested searches here.
		}
	} else {
		print("No Results")
	}
}
```


## [Reverse Geocoding API](#Reverse-Geocoding-API)

For live demo click [LIVE DEMO](https://www.mapmyindia.com/api/advanced-maps/doc/sample/mapmyindia-maps-reverse-geocoding-rest-api-example)

Get the nearest address for a given lat long combination

Reverse Geocoding is a process to give the closest matching address to a provided geographical coordinates (latitude/longitude). MapmyIndia reverse geocoding API provides real addresses along with nearest popular landmark for any such geo-positions on the map.


Class used for geocode is `MapmyIndiaReverseGeocodeManager`. Create a `MapmyIndiaReverseGeocodeManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaReverseGeocodeManager` class.

To perform the translation use `MapmyIndiaReverseGeocodeOptions` class to pass coordinates as parameters to reverse geocode with an option to pass region in parameter `withRegion`, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

### Response Parameters


In response of geocode search either you will receive an error or an array of `MapmyIndiaGeocodedPlacemark`. Yo will find below useful properties in suggestion object:

-   **houseNumber:**  The house number of the location.
-   **houseName:**  The name of the location.
-   **poi:**  The name of the POI if the location is a place of interest (POI).
-   **poiDist:**  distance from nearest POI in metres.
-   **street:**  The name of the street of the location.
-   **streetDist:**  distance from nearest Street in metres.
-   **subSubLocality:**  The name of the sub-sub-locality where the location exists.
-   **subLocality:**  The name of the sub-locality where the location exists.
-   **locality:**  The name of the locality where the location exists.
-   **village:**  The name of the village if the location exists in a village.
-   **district:**  The name of the district in which the location exists.
-   **subDistrict:**  The name of the sub-district in which the location exists.
-   **city:**  The name of the city in which the location exists.
-   **state:**  The name of the state in which the location exists.
-   **pincode:**  The pin code of the location area.
-   **latitude:**  The latitude of the location.
-   **longitude:**  The longitude of the location.
-   **formattedAddress:**  The complete human readable address string that is usually the complete postal address of the result.
-   **area:** in-case the co-ordinate lies in a country the name of the country would be returned or if the co-ordinate lies in an ocean, the name of the ocean will be returned.  



### Code Samples



#### Objective C
```objectivec
MapmyIndiaReverseGeocodeManager * reverseGeocodeManager =
[MapmyIndiaReverseGeocodeManager sharedManager];
//Or
MapmyIndiaReverseGeocodeManager * reverseGeocodeManager =
[[MapmyIndiaReverseGeocodeManager alloc]
initWithRestKey:MapmyIndiaAccountManager.restAPIKey];

MapmyIndiaReverseGeocodeOptions *revOptions
=[[MapmyIndiaReverseGeocodeOptions alloc]
initWithCoordinate:self.mapView.centerCoordinate
withRegion:MMIRegionTypeIdentifierDefault];

[reverseGeocodeManager reverseGeocodeWithOptions:revOptions
completionHandler:^(NSArray<MapmyIndiaGeocodedPlacemark *> * _Nullable
placemarks, NSString * _Nullable attribution, NSError * _Nullable error) {
		if (error) {
				NSLog(@"%@", error);
		} else if (placemarks.count > 0) {
			NSLog(@"Reverse Geocode %@,%@",
			placemarks[0].latitude,placemarks[0].longitude);
			self.resultsLabel.text = placemarks[0].formattedAddress;
		} else {
			self.resultsLabel.text = @"No results";
		}
	}];
```
#### Swift
```swift
let reverseGeocodeManager = MapmyIndiaReverseGeocodeManager.shared
//Or
let reverseGeocodeManager = MapmyIndiaReverseGeocodeManager(restKey:
MapmyIndiaAccountManager.restAPIKey())

let revOptions = MapmyIndiaReverseGeocodeOptions(coordinate:
mapView.centerCoordinate, withRegion: .india)
reverseGeocodeManager.reverseGeocode(revOptions) { (placemarks,
attribution, error) in
		if let error = error {
			NSLog("%@", error)
		} else if let placemarks = placemarks, !placemarks.isEmpty {
			print("Reverse Geocode: \(placemarks[0].latitude ?? ""),\
			(placemarks[0].longitude ?? "")")
			self.resultsLabel.text = placemarks[0].formattedAddress
		} else {
			self.resultsLabel.text = "No results"
		}
	}
```

For more details visit our [online documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Reverse-Geocoding).


## [Nearby API](#Nearby-API)

For live demo click [LIVE DEMO](https://www.mapmyindia.com/api/advanced-maps/doc/sample/mapmyindia-maps-near-by-api-example)

Search for nearby places in a category near a given location

Nearby Places API, enables you to add discovery and search of nearby POIs by searching for a generic keyword used to describe a category of places or via the unique code assigned to that category.



Class used for nearby search is `MapmyIndiaNearByManager`. Create a `MapmyIndiaNearByManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaNearByManager` class.

To perform nearby search use `MapmyIndiaNearbyAtlasOptions` class to pass keywords/categories and a reference location as parameters to get Nearby search results with an option to pass region in parameter `withRegion`, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

*Additionally you can also set location and zoom in object of `MapmyIndiaNearbyAtlasOptions` location coordinate can be set  in comma seprated format i.e `("latitue", "longitue")` or location can be eLoc (placeId) i.e `("MMI000")`*


### Request Parameters
1. **refLocation** A location provides the location around which the search will be performed it can be coordinte (latitude, longitude) or eLoc in `String` format.

1.  **page:**  provides number of the page to provide results from.

2.  **sort:**  provides configured sorting operations for the client on cloud. Below are the available sorts:
		-  dist:asc & dist:desc - will sort data in order of distance from the passed location (default).
		-  name:asc & name:desc - will sort the data on alphabetically bases.

3.  **radius (integer):**  provides the range of distance to search over (default: 1000, min: 500, max: 10000).

3. **sortBy:** It is used to sort results based on value provided. It can accept object of `MapmyIndiaSortBy` or `MapmyIndiaSortByWithOrder`

3. **searchBy:** It is used to search places based on preference provided. It is of enum type `MMISearchByType`  its value can be either `.importance` or `.distance`

3. **filters:**   On basis of this only specific type of response returned. it can of type `MapmyIndiaNearbySearchFilter`.
MapmyIndiaNearbySearchFilter have following properties.
	- filterKey :- It takes  value for `key`  to filter result.
	- filterValues :- It takes an array of different query values.
	- logicalOperator :- `logicalOperator` of enum `MapmyIndiaLogicalOperator`  its default value is `and`.


	``` swift 
	let filter = MapmyIndiaNearbyKeyValueFilter(filterKey: "brandId", filterValues: [String,String])
	```

4.  **bounds (x1,y1;x2,y2):**  Allows the developer to send in map bounds to provide a nearby search of the geobounds. where x1,y1 are the latitude and langitude.

5.	**isRichData:** It is of type `Bool`. It allows some additional information to receive in `richInfo` parameter of response.

6.	**shouldExplain:** It is of type `Bool`.

7.	**userName:** It is of type `String`. On basis of value of this some specific results bounded to a user.

8.  **pod**: It takes place type which helps in restricting the results to certain chosen type  
    Below mentioned are the codes for the pod -
    -   Sublocality
    -   Locality
    -   City
    -   Village    

### Response Parameters

You will find below useful properties in suggestion object :

-   **distance:**  provides the distance from the provided location bias in meters.
-   **eLoc:**  Place Id of the location 6-char alphanumeric.
-   **email:**  Email for contact.
-   **entryLatitude:**  latitude of the entrance of the location.
-   **entryLongitude:**  longitude of the entrance of the location.
-   **keywords:**  provides an array of matched keywords or codes.
-   **landlineNo:**  Email for contact.
-   **latitude:**  Latitude of the location.
-   **longitude:**  longitude of the location.
-   **mobileNo :**  Phone number for contact.
-   **orderIndex:**  the order where this result should be placed
-   **placeAddress:**  Address of the location.
-   **placeName:**  Name of the location.
-   **type:**  Type of location POI or Country or City.
-   **city:**  Name of city.
-   **state:**  Name of state
-   **pincode:**  Pincode of area.
-   **categoryCode:**  Code of category with that result belongs to.
-   **richInfo:**  A dictionary object with dynamic information
-	**hourOfOperation:** A string value which describes hour of 
-	**addressTokens**:
	- **houseNumber**: house number of the location.
	- **houseName**: house name of the location.
	- **poi**: name of the POI (if applicable)
	- **street**: name of the street. (if applicable)
	- **subSubLocality**: the sub-sub-locality to which the location belongs. (if applicable)
	- **subLocality**: the sub-locality to which the location belongs. (if applicable)
	- **locality**: the locality to which the location belongs. (if applicable)
	- **village**: the village to which the location belongs. (if applicable)
	- **subDistrict**: the sub-district to which the location belongs. (if applicable)
	- **district**: the district to which the location belongs. (if applicable)
	- **city**: the city to which the location belongs. (if applicable)
	- **state**: the state to which the location belongs. (if applicable)
	- **pincode**: the PIN code to which the location belongs. (if applicable)
  operation.
-	**pageInfo**:
	- **pageCount**
	- **totalHits**
	- **totalPages**
	- **pageSize**

### Code Samples

#### Objective C
```objectivec
MapmyIndiaNearByManager * nearByManager = [MapmyIndiaNearByManager
sharedManager];
//Or
MapmyIndiaNearByManager * nearByManager = [[MapmyIndiaNearByManager alloc]
initWithRestKey:MapmyIndiaAccountManager.restAPIKey
clientId:MapmyIndiaAccountManager.atlasClientId
clientSecret:MapmyIndiaAccountManager.atlasClientSecret
grantType:MapmyIndiaAccountManager.atlasGrantType];

NSString *refLocation = @"28.550667, 77.268959";

MapmyIndiaNearbyAtlasOptions *nearByOptions = [[MapmyIndiaNearbyAtlasOptions alloc] initWithQuery:self.searchBar.text location:refLocation withRegion:MMIRegionTypeIdentifierIndia];

	[nearByManager getNearBySuggestionsWithOptions:nearByOptions
        completionHandler:^(MapmyIndiaNearbyResult * _Nullable
         result, NSError * _Nullable error) {
        	if (error) {
                    NSLog(@"%@", error);
                } else if (result.suggestions.count > 0) {
                    NSLog(@"Nearby %@%@",
                          result.suggestions[0].latitude,result.suggestions[0].longitude);
                    [self.searchSuggestions removeAllObjects];
                    self.searchSuggestions = [NSMutableArray arrayWithArray:result.suggestions];
                    self.tableViewAutoSuggest.hidden = NO;
                    [self.tableViewAutoSuggest reloadData];
                } else {
                    
                }
            }];
```
#### Swift
```swift
let nearByManager = MapmyIndiaNearByManager.shared
//Or
let nearByManager = MapmyIndiaNearByManager(restKey:
MapmyIndiaAccountManager.restAPIKey(), clientId:
MapmyIndiaAccountManager.atlasClientId(), clientSecret:
MapmyIndiaAccountManager.atlasClientSecret(), grantType:
MapmyIndiaAccountManager.atlasGrantType())

 var refLocations: String!	
 refLocations = "28.543014, 77.242342" 
 let filter = MapmyIndiaNearbyKeyValueFilter(filterKey: "brandId", filterValues: [String,String])
 let sortBy = MapmyIndiaSortByDistanceWithOrder(orderBy: .ascending)
 //or
 // let sortBy = MapmyIndiaSortBy(sortBy: .distance)
 let nearByOptions = MapmyIndiaNearbyAtlasOptions(query:"EV Charging" , location: refLocations, withRegion: .india)
nearByOptions.filters = [filter]
nearByOptions.sortBy = sortBy
nearByOptions.searchBy = .importance
nearByManager.getNearBySuggestions(nearByOptions) { (result,
error) in
		if let error = error {
			NSLog("%@", error)
		} else if let suggestions = result.suggestions, !suggestions.isEmpty {
			print("Near by: \(suggestions[0].latitude ?? 0),\
			(suggestions[0].longitude ?? 0)")
			self.resultsLabel.text = suggestions[0].placeAddress
		} else {
			self.resultsLabel.text = "No results"
		}
	}
```

 ### [NearBy using Eloc](#NearBy-using-Eloc)
 *Code snipet for getting nearby location using eLocs is below.*

 ```swift
let nearByManager = MapmyIndiaNearByManager.shared
//Or
let nearByManager = MapmyIndiaNearByManager(restKey:
MapmyIndiaAccountManager.restAPIKey(), clientId:
MapmyIndiaAccountManager.atlasClientId(), clientSecret:
MapmyIndiaAccountManager.atlasClientSecret(), grantType:
MapmyIndiaAccountManager.atlasGrantType())
let nearByOptions = MapmyIndiaNearbyAtlasOptions(query:"Shoes" , location: "MMI000", withRegion: .india)

nearByManager.getNearBySuggestions(nearByOptions) { (result,
error) in
		if let error = error {
			NSLog("%@", error)
		} else if let suggestions = result.suggestions, !suggestions.isEmpty {
			print("Near by: \(suggestions[0].latitude ?? 0),\
			(suggestions[0].longitude ?? 0)")
			self.resultsLabel.text = suggestions[0].placeAddress
		} else {
			self.resultsLabel.text = "No results"
		}
	}
```

For more details visit our [online documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#nearby-search).

## [Place Details/eLoc Legacy API](#Place-DetailseLoc-Legacy-API)

For live demo click [LIVE DEMO](https://www.mapmyindia.com/api/advanced-maps/doc/sample/mapmyindia-maps-place-details-api-example)

The MapmyIndia eLoc is a simple, standardised and precise pan-India digital address system. Every location has been assigned a unique digital address or an eLoc. The Place Detail can be used to extract the details of a place with the help of its eLoc i.e. a 6 digit code.

Class used for eLoc search is `MapmyIndiaPlaceDetaiLegacylManager`. Create a `MapmyIndiaPlaceDetailLegacyManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaPlaceDetaiLegacylManager` class.

To perform eLoc search use `MapmyIndiaPlaceDetailLegacyOptions` class to pass digital address code (eLoc/PlaceId) as parameters to get eLoc Detail results with an option to pass region in parameter withRegion, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

### Response Parameters

In response of eLoc search either you will receive an error or an array of `MapmyIndiaGeocodedPlacemark`.

-   **houseNumber:**  The house number of the location.
-   **houseName:**  The name of the location.
-   **poi:**  The name of the POI if the location is a place of interest (POI).
-   **street:**  The name of the street of the location.
-   **subSubLocality:**  The name of the sub-sub-locality where the location exists.
-   **subLocality:**  The name of the sub-locality where the location exists.
-   **locality:**  The name of the locality where the location exists.
-   **village:**  The name of the village if the location exists in a village.
-   **district:**  The name of the district in which the location exists.
-   **subDistrict:**  The name of the sub-district in which the location exists.
-   **city:**  The name of the city in which the location exists.
-   **state:**  The name of the state in which the location exists.
-   **pincode:**  The pin code of the location area.
-   **latitude:**  The latitude of the location.
-   **longitude:**  The longitude of the location.
-   **placeId:**  The eLoc or placeId assigned for a place in map database. An eLoc is the digital identity for an address or business to identify its unique location. For more information on eLoc, click here
-   **type:**  defines the type of location matched (HOUSE_NUMBER, HOUSE_NAME, POI, STREET, SUB_LOCALITY, LOCALITY, VILLAGE, DISTRICT, SUB_DISTRICT, CITY, STATE, SUBSUBLOCALITY, PINCODE)

### Code Samples

#### Objective C
```objectivec
MapmyIndiaPlaceDetailManager * placeDetailManager =
[MapmyIndiaPlaceDetailManager sharedManager];
//Or
MapmyIndiaPlaceDetailManager * placeDetailManager =
[[MapmyIndiaPlaceDetailManager alloc]
initWithRestKey:MapmyIndiaAccountManager.restAPIKey];

MapmyIndiaPlaceDetailGeocodeOptions *placeOptions =
[[MapmyIndiaPlaceDetailGeocodeOptions alloc] initWithPlaceId:@"mmi000"
withRegion:MMIRegionTypeIdentifierDefault];
[placeDetailManager getPlaceDetailWithOptions:placeOptions
completionHandler:^(NSArray<MapmyIndiaGeocodedPlacemark *> * _Nullable
placemarks, NSString * _Nullable attribution, NSError * _Nullable error) {
		if (error) {
			NSLog(@"%@", error);
		} else if (placemarks.count > 0) {
			NSLog(@"Place Detail Geocode %@%@",
			placemarks[0].latitude,placemarks[0].longitude);
			self.resultsLabel.text = placemarks[0].formattedAddress;
		} else {
			self.resultsLabel.text = @"No results";
		}
	}];
```
#### Swift
```swift
let placeDetailManager = MapmyIndiaPlaceDetailManager.shared
Or
let placeDetailManager = MapmyIndiaPlaceDetailManager(restKey:
MapmyIndiaAccountManager.restAPIKey())

let placeOptions = MapmyIndiaPlaceDetailGeocodeOptions(placeId: "mmi000",
withRegion: .india)
placeDetailManager.getPlaceDetail(placeOptions) { (placemarks,
attribution, error) in
		if let error = error {
			NSLog("%@", error)
		} else if let placemarks = placemarks, !placemarks.isEmpty {
			print("Place Detail Geocode: \(placemarks[0].latitude ??
			""),\(placemarks[0].longitude ?? "")")
			self.resultsLabel.text = placemarks[0].formattedAddress
		} else {
			self.resultsLabel.text = "No results"
		}
	}
```

For more details visit our [online documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Place-eLoc).

## [Place Detail](#Place-Detail)

The MapmyIndia eLoc is a simple, standardised and precise pan-India digital address system. Every location has been assigned a unique digital address or an eLoc. The Place Detail can be used to extract the details of a place with the help of its eLoc i.e. a 6 digit code.

Class used for eLoc search is `MapmyIndiaPlaceDetailManager`. Create a `MapmyIndiaPlaceDetailManager` object using your authenticated MapmyIndia keys or alternatively, you can use the shared instance of `MapmyIndiaPlaceDetailManager` class.

To perform Place Detail use `MapmyIndiaPlaceDetailOptions` class to pass digital address code (eLoc/PlaceId) as parameters to get Detail result with an option to pass region in parameter withRegion, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

### Response Parameters

In response of eLoc search either you will receive an error or an object of `MapmyIndiaPlaceDetail`.

-   **eLoc:**  The eLoc or placeId assigned for a place in map database. An eLoc is the digital identity for an address or business to identify its unique location.
-   **latitude:**  The latitude of the location.
-   **longitude:**  The longitude of the location.


**Note: Not all response parameters are available by default. These parameters are restricted and available as per discussed use case. For details, please contact MapmyIndia API support.**

### Code Samples

#### Swift
```swift
let placeDetailManager = MapmyIndiaPlaceDetailManager.shared
let placeOptions = MapmyIndiaPlaceDetailOptions(eLoc: "mmi000", withRegion: .india)
placeDetailManager.getResults(placeOptions) { (placeDetail, error) in
	DispatchQueue.main.async {
		if let error = error {
			print(error)
		} else if let placeDetail = placeDetail, let latitude = placeDetail.latitude, let longitude = placeDetail.longitude {
			print("Place Detail : \(latitude),\(longitude)")
		} else {
			print("No results")
		}
	}
}
```

## [Geocoding API](#Geocoding-API)

For live demo click [LIVE DEMO](https://www.mapmyindia.com/api/advanced-maps/doc/sample/mapmyindia-atlas-geocoding-rest-api-example)

Get most accurate lat long combination for a given address

All mapping APIs that are used in mobile or web apps need some geo-position coordinates to refer to any given point on the map. Our Geocoding API converts real addresses into these geographic coordinates (latitude/longitude) to be placed on a map, be it for any street, area, postal code, POI or a house number etc.



Class used for geocode is `MapmyIndiaAtlasGeocodeManager`. To create instance of `MapmyIndiaAtlasGeocodeManager` initialize using your rest key, clientId, clientSecret , grantType **or** use shared instance of `MapmyIndiaAtlasGeocodeManager` after setting key values `MapmyIndiaRestKey`, `MapmyIndiaAtlasClientId`, `MapmyIndiaAtlasClientSecret`, `MapmyIndiaAtlasGrantType` in your application’s `Info.plist` file.

To perform geocode use `getGeocodeResults` method of instance of `MapmyIndiaAtlasGeocodeManager` class which accepts an instance of  `MapmyIndiaAtlasGeocodeOptions` class. To create instance of `MapmyIndiaAtlasGeocodeOptions`, pass any address as query parameters to geocode.

### Request Parameters

1. **`query`**: The address of a location (e.g. 237 Okhla Phase-III).

Additionally you can also set some other parameters in object of `MapmyIndiaAtlasGeocodeOptions` to get some specific results. Which are:  

2. **`maximumResultCount`**: The number of results which needs to be return in response.

### Response Parameters

In response of `geocode` search either you will receive an error or an array of `MapmyIndiaGeocodedPlacemark`. Yo will find below useful properties in suggestion object :

1. `houseNumber`: The house number of the location.
2. `houseName`: The name of the location.
3. `poi`: The name of the POI if the location is a place of interest (POI).
4. `street`: The name of the street of the location.
5. `subSubLocality`: The name of the sub-sub-locality where the location exists.
6. `subLocality`: The name of the sub-locality where the location exists.
7. `locality`: The name of the locality where the location exists.
8. `village`: The name of the village if the location exists in a village.
9. `district`: The name of the district in which the location exists.
10. `subDistrict`: The name of the sub-district in which the location exists.
11. `city`: The name of the city in which the location exists.
12. `state`: The name of the state in which the location exists.
13. `pincode`: The pin code of the location area.
14. `latitude`: The latitude of the location.
15. `longitude`: The longitude of the location.
16. `formattedAddress`: The complete human readable address string that is usually the complete postal address of the result.
17. `eLoc`: The eLoc or placeId assigned for a place in map database. An eLoc is the digital identity for an address or business to identify its unique location. For more information on eLoc, click here.
18. `geocodeLevel`: It defines depth level of search for geocode.
  

### Code Samples


#### Objective C
```objectivec
MapmyIndiaAtlasGeocodeManager * atlasGeocodeManager = [MapmyIndiaAtlasGeocodeManager sharedManager];
// or
MapmyIndiaAtlasGeocodeManager * atlasGeocodeManager = [[MapmyIndiaAtlasGeocodeManager alloc] initWithRestKey:MapmyIndiaAccountManager.restAPIKey clientId:MapmyIndiaAccountManager.atlasClientId clientSecret:MapmyIndiaAccountManager.atlasClientSecret grantType:MapmyIndiaAccountManager.atlasGrantType];
    
MapmyIndiaAtlasGeocodeOptions *atlasGeocodeOptions = [[MapmyIndiaAtlasGeocodeOptions alloc] initWithQuery: @"68 mapmyindia" withRegion:MMIRegionTypeIdentifierDefault];
    
[atlasGeocodeManager getGeocodeResultsWithOptions:atlasGeocodeOptions completionHandler:^(MapmyIndiaAtlasGeocodeAPIResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else if (response!= nil && response.placemarks.count > 0) {
            NSLog(@"Forward Geocode %@%@", response.placemarks[0].latitude, response.placemarks[0].longitude);
        } else {
            NSLog(@"No results");
        }
    }];
```
#### Swift
```swift
let atlasGeocodeManager = MapmyIndiaAtlasGeocodeManager.shared
// or
let atlasGeocodeManager = MapmyIndiaAtlasGeocodeManager(restKey: MapmyIndiaAccountManager.restAPIKey(), clientId: MapmyIndiaAccountManager.atlasClientId(), clientSecret: MapmyIndiaAccountManager.atlasClientSecret(), grantType: MapmyIndiaAccountManager.atlasGrantType())

let atlasGeocodeOptions = MapmyIndiaAtlasGeocodeOptions(query: "mapmyindia", withRegion: .default)
atlasGeocodeOptions.maximumResultCount = 10
atlasGeocodeManager.getGeocodeResults(atlasGeocodeOptions) { (response, error) in
            if let error = error {
                NSLog("%@", error)
            } else if let result = response, let placemarks = result.placemarks, placemarks.count > 0 {
                print("Atlas Geocode: \(placemarks[0].latitude),\(placemarks[0].longitude)")
            } else {
                print("No results")
            }
        }
```
For more details visit our [online documentation]().


## [Routing API](#Routing-API)

For live demo click [LIVE DEMO](https://www.mapmyindia.com/api/advanced-maps/doc/sample/mapmyindia-maps-route-adv-api-example)

Get optimal & alternate routes between various locations with or without considering live traffic

Routing and displaying driving directions on map, including instructions for navigation, distance to destination, traffic etc. are few of the most important parts of developing a map based application. This REST API calculates driving routes between specified locations including via points based on route type(optimal or shortest) and includes delays for traffic congestion.



Use `Directions` to get route between locations. You can use it either by creating object using your rest key **or** use shared instance of `Directions` class by setting rest key in the `MapmyIndiaRestKey` key of your application’s `Info.plist` file.

To perform this operation use object of `RouteOptions` class as request to pass source location and destination locations and other parameters.

To use **Route with traffic based ETA** feature, to get duration inclusive of traffic for a distance between locations use parameter resourceIdentifier as described below:

- `resourceIdentifier`: This property should be set to `MBDirectionsResourceIdentifierRouteAdv`, `MBDirectionsResourceIdentifierRouteETA` or `MBDirectionsResourceIdentifierRouteTraffic`. The default value of this property is `MBDirectionsResourceIdentifierRouteETA`.

### Request Parameters

Additionally you can set some more parameters on instance of `RouteOptions` to get filtered/specific results. Which are as :

1. `routeType`: It is type of enum  `MapmyIndiaRouteType` which can accept values `quickest`, `shortest`, `none`. By default its value is `none`.
2. `region`: It is type of enum `MapmyIndiaRegionTypeIdentifier`. It is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

**Note**: If you are using **Routing with traffic** `routeType` and `region` values are not considered. Traffic is only available in India and only optimal route calculation is allowed with traffic.

### Steps to get directions

- To get directions create an array of `Waypoint` class, add two objects of `Waypoint` class to this array to get route path. For origin position also set heading of instance of `Waypoint` class.
- Next create an instance of `RouteOptions` class by passing waypoints created in previous step.
```swift
let options = RouteOptions(waypoints: [
            Waypoint(coordinate: CLLocationCoordinate2D(latitude: 28.551078, longitude: 77.268968), name: "MapmyIndia"),
            Waypoint(coordinate: CLLocationCoordinate2D(latitude: 28.565065, longitude: 77.234193), name: "Moolchand"),
        ])
```
- Use `Directions` singleton class from `Directions` framework to get available routes.
- You can plot polylines on map for available routes by using Map framework. 

### [Directions Using eLocs](#Directions-Using-eLocs)

An object of Waypoint can be created using coordinate as well as [eLoc](#https://www.mapmyindia.com/eloc/) (unique identifier of place).

```swift
Waypoint(coordinate: CLLocationCoordinate2D(latitude: 28.551078, longitude: 77.268968), name: "MapmyIndia")

or

Waypoint(eLoc: "MMI000", name: "MapmyIndia")
```

### Code Samples

#### Swift
```swift
Directions.shared.calculate(options) { (waypoints, routes, error) in
            guard error == nil else {
                print("Error calculating directions: \(error!)")
                return
            }
            
            if let route = routes?.first, let leg = route.legs.first {
                self.currentRouteLeg = leg
                print("Route via \(leg):")
                
                let distanceFormatter = LengthFormatter()
                let formattedDistance = distanceFormatter.string(fromMeters: route.distance)
                
                let travelTimeFormatter = DateComponentsFormatter()
                travelTimeFormatter.unitsStyle = .short
                let formattedTravelTime = travelTimeFormatter.string(from: route.expectedTravelTime)
                
                print("Distance: \(formattedDistance); ETA: \(formattedTravelTime!)")
                
                for step in leg.steps {
                    print("\(step.instructions)")
                    if step.distance > 0 {
                        let formattedDistance = distanceFormatter.string(fromMeters: step.distance)
                        print("— \(formattedDistance) —")
                    }
                }
                
                if route.coordinateCount > 0 {
                    // Convert the route’s coordinates into a polyline.
                    var routeCoordinates = route.coordinates!
                    let routeLine = MGLPolyline(coordinates: &routeCoordinates, count: route.coordinateCount)
                    
                    // Add the polyline to the map and fit the viewport to the polyline.
                    self.mapView.addAnnotation(routeLine)
                    self.mapView.setVisibleCoordinates(&routeCoordinates, count: route.coordinateCount, edgePadding: .zero, animated: true)
                }
            }
        }
```

For more details visit our [online documentation]().


## [Driving Distance Time Matrix API](#Driving-Distance-Time-Matrix-API)

For live demo click [LIVE DEMO](https://www.mapmyindia.com/api/advanced-maps/doc/sample/mapmyindia-maps-distance-matrix-api-example)

Get driving distance & time from a point to multiple destination

Adding driving distance matrix API would help to add predicted travel time & duration from a given origin point to a number of points. The Driving Distance Matrix API provides driving distance and estimated time to go from a start point to multiple destination points, based on recommended routes from MapmyIndia Maps and traffic flow conditions.



Class used for driving distance is `MapmyIndiaDrivingDistanceMatrixManager`. Create a `MapmyIndiaDrivingDistanceMatrixManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application’s `Info.plist` file, then use the shared instance of `MapmyIndiaDrivingDistanceMatrixManager` class.

To perform this operation use `MapmyIndiaDrivingDistanceMatrixOptions` class to pass center location and points parameters.

To use API **Distance Matrix with traffic** to get duration inclusive of traffic for a distance between locations use parameter `resourceIdentifier` as described below:
- `resourceIdentifier`: This property should be set to `MapmyIndiaDistanceMatrixResourceIdentifierDefault`, `MapmyIndiaDistanceMatrixResourceIdentifierETA` or `MapmyIndiaDistanceMatrixResourceIdentifierTraffic`. The default value of this property is `MapmyIndiaDistanceMatrixResourceIdentifierDefault`.

### Request Parameters

Additionally you can pass some other parameters to get filtered/specific results. Which are as :

1.  **routeType:**  It is type of enum `DistanceRouteType`.
2.  **region:**  It is type of enum `MMIRegionTypeIdentifier`. It is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.
3. **resourceIdentifier**: This property should be set to `MapmyIndiaDistanceMatrixResourceIdentifierDefault`, `MapmyIndiaDistanceMatrixResourceIdentifierETA` or `MapmyIndiaDistanceMatrixResourceIdentifierTraffic`. The default value of this property is `MapmyIndiaDistanceMatrixResourceIdentifierDefault`.
4. **profileIdentifier**: This property should be set to `MapmyIndiaDirectionsProfileIdentifierDriving`, `MapmyIndiaDirectionsProfileIdentifierTrucking`, `MapmyIndiaDirectionsProfileIdentifierCycling`, or `MapmyIndiaDirectionsProfileIdentifierWalking`. The default value of this property is `MapmyIndiaDirectionsProfileIdentifierDriving`, which specifies driving directions.
5. **sourceIndexes**: It is an array of int which specifie index of  the source locations
6. **destinationIndexes**: It is an array of int which specifie index of  the destinations locations.

**Note**: If you are using **Distance Matrix with traffic** `routeType` and `region` values are not considered. Traffic is only available in India and only optimal route calculation is allowed with traffic.

### Response Parameters

In response either you will receive an error or an object of  `MapmyIndiaDrivingDistanceMatrixResponse` where structure of object is as described below:

1. `responseCode`: API status code.
2. `version`: API’s version information
3. `results`: Array of results, each consisting of the following parameters
	- `code`: if the request was successful, code is “ok”.
	- `durations`: duration in seconds for source to secondary locations in order as passed.
	- `distances`: distance in meters for source to secondary locations in order as passed.



### Code Samples

**Objective C**
```objectivec
MapmyIndiaDrivingDistanceMatrixManager *distanceMatrixManager = [MapmyIndiaDrivingDistanceMatrixManager sharedManager];
MapmyIndiaDrivingDistanceMatrixOptions *distanceMatrixOptionsETA = [[MapmyIndiaDrivingDistanceMatrixOptions alloc] initWithCenter:[[CLLocation alloc] initWithLatitude: 28.543014 longitude:77.242342] points:[NSArray arrayWithObjects: [[CLLocation alloc] initWithLatitude:28.520638 longitude:77.201959], [[CLLocation alloc] initWithLatitude:28.511810 longitude: 77.252773], nil]];
    distanceMatrixOptionsETA.withTraffic = YES;
    [distanceMatrixManager getResultWithOptions:distanceMatrixOptionsETA completionHandler:^(MapmyIndiaDrivingDistanceMatrixResponse * _Nullable result, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
        } else if (result != nil  && result.results != nil) {
            NSArray<NSNumber *> *durations = result.results.durations.firstObject;
            NSArray<NSNumber *> *distances = result.results.distances.firstObject;
            
            NSUInteger pointCount = [distanceMatrixOptions points].count;
            for (int i = 0; i < pointCount; i++) {
                if (i < durations.count && i < distances.count) {
                    NSLog(@"Driving Distance Matrix ETA %d duration: %@, distance: %@", i, durations[i], distances[i]);
                }
            }
        } else {
            NSLog(@"No results");
        }
    }];

```
**Swift**
```swift
let distanceMatrixManager = MapmyIndiaDrivingDistanceMatrixManager.shared
let distanceMatrixOptionsETA = MapmyIndiaDrivingDistanceMatrixOptions(center: CLLocation(latitude: 28.543014, longitude: 77.242342), points: [CLLocation(latitude: 28.520638, longitude: 77.201959), CLLocation(latitude: 28.511810, longitude: 77.252773)])
		distanceMatrixOptions.profileIdentifier = .driving
        distanceMatrixOptions.resourceIdentifier = .eta
        distanceMatrixManager.getResult(distanceMatrixOptionsETA) { (result, error) in
            if let error = error {
                NSLog("%@", error)
            } else if let result = result, let results = result.results, let durations = results.durations?[0], let distances = results.distances?[0] {
                let pointCount = distanceMatrixOptionsETA.points?.count ?? -1
                for i in 0..<pointCount {
                    if i < durations.count && i < distances.count {
                        print("Driving Distance Matrix ETA \(i): duration: \(durations[i]) distance: \(distances[i])")
                    }
                }
            } else {
                print("No results")
            }
        }
```

### [Distance Using eLocs](#Distance-Using-eLocs)

**Code snipet for getting distance between different locations using eLocs is below.**

```swift
	let distanceMatrixManager = MapmyIndiaDrivingDistanceMatrixManager.shared
    et distanceMatrixOptions = MapmyIndiaDrivingDistanceMatrixOptions(locations: ["JIHGS1", "17ZUL7", "77.242342,28.543014", "17ZUL7"], withRegion: .india)
	distanceMatrixOptions.profileIdentifier = .driving
    if isETA {
        distanceMatrixOptions.resourceIdentifier = .eta
    }
    distanceMatrixOptions.sourceIndexes = [0,1]
    distanceMatrixOptions.destinationIndexes = [2,3]
    distanceMatrixManager.getResult(distanceMatrixOptions) { (result, error) in
        if let error = error {
            NSLog("%@", error)
        } else if let result = result, let results = result.results, let durations = results.durationsAPI?[0], let distances = results.distancesAPI?[0] {
			let pointCount = distanceMatrixOptions.locations?.count ?? -1
			for i in 0..<pointCount {
				if i < durations.count && i < distances.count {
					let duration = durations[i].intValue
					let distance = distances[i].intValue
					print("Driving Distance Matrix\(isETA ? " ETA" : "") \(i): duration: \(duration) distance: \(distance)")
				}
			} else {
				print("No results")
			}
  	   }
	}

```

For more details visit our [online documentation]().

## [Geocoding API - Legacy](#Geocoding-API---Legacy)

For live demo click [LIVE DEMO](https://www.mapmyindia.com/api/advanced-maps/doc/sample/mapmyindia-maps-geocoding-rest-api-example)

Get most accurate lat long combination for a given address

All mapping APIs that are used in mobile or web apps need some geo-position coordinates to refer to any given point on the map. Our Geocoding API converts real addresses into these geographic coordinates (latitude/longitude) to be placed on a map, be it for any street, area, postal code, POI or a house number etc.


Class used for geocode is `MapmyIndiaGeocodeManager`. Create a `MapmyIndiaGeocodeManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaGeocodeManager` class.

To perform search use `MapmyIndiaForwardGeocodeOptions` class to pass any address as query parameters to geocode with an option to pass region in parameter `withRegion`, which is an enum of type `MMIRegionTypeIdentifier`. If no value is passed for region, It will take default value which is India.

`MMIRegionTypeIdentifier` is used to validate and get result for different countries. Currently five countries are supported including India which are Sri Lanka, India, Bhutan, Bangladesh, Nepal.

### Request Parameters

1. **addr**: This parameter can take in the below are supported input queries:
	-   **eLoc**: The 6-digit alphanumeric code for any location. (e.g. mmi000).
	-   **address**: The address of a location (e.g. 237 Okhla Phase-III).
	-   **POI**: The name of the location (e.g. MapmyIndia Head Office).
	-   **House Number**: The house number of the location in case full address is unknown (e.g. P- 18/114).

Additionally you can also set some other parameters in object of `MapmyIndiaForwardGeocodeOptions` to get some specific results:  

2. **pincode**: The pin-code of area (e.g. 110020).
This is used to **restrict** the 'addr' search to within this PIN code's area.

### Response Parameters

In response of geocode search either you will receive an error or an array of MapmyIndiaGeocodedPlacemark. Yo will find below useful properties in suggestion object :

-   **houseNumber:**  The house number of the location.
-   **houseName:**  The name of the location.
-   **poi:**  The name of the POI if the location is a place of interest (POI).
-   **street:**  The name of the street of the location.
-   **subSubLocality:**  The name of the sub-sub-locality where the location exists.
-   **subLocality:**  The name of the sub-locality where the location exists.
-   **locality:**  The name of the locality where the location exists.
-   **village:**  The name of the village if the location exists in a village.
-   **district:**  The name of the district in which the location exists.
-   **subDistrict:**  The name of the sub-district in which the location exists.
-   **city:**  The name of the city in which the location exists.
-   **state:**  The name of the state in which the location exists.
-   **pincode:**  The pin code of the location area.
-   **latitude:**  The latitude of the location.
-   **longitude:**  The longitude of the location.
-   **formattedAddress:**  The complete human readable address string that is usually the complete postal address of the result.
-   **placeId:**  The eLoc or placeId assigned for a place in map database. An eLoc is the digital identity for an address or business to identify its unique location. For more information on eLoc, click here.
-   **type:**  defines the type of location matched (HOUSE_NUMBER, HOUSE_NAME, POI, STREET, SUB_LOCALITY, LOCALITY, VILLAGE, DISTRICT, SUB_DISTRICT, CITY, STATE, SUBSUBLOCALITY, PINCODE).
  

### Code Samples


#### Objective C
```objectivec
MapmyIndiaGeocodeManager * geocodeManager = [MapmyIndiaGeocodeManager
sharedManager];
//Or
MapmyIndiaGeocodeManager * geocodeManager = [[MapmyIndiaGeocodeManager
alloc] initWithRestKey:MapmyIndiaAccountManager.restAPIKey];

MapmyIndiaForwardGeocodeOptions *forOptions =
[[MapmyIndiaForwardGeocodeOptions alloc] initWithQuery: @"237 mapmyindia"
withRegion:MMIRegionTypeIdentifierDefault];

[geocodeManager geocodeWithOptions:forOptions
completionHandler:^(NSArray<MapmyIndiaGeocodedPlacemark *> * _Nullable
placemarks, NSString * _Nullable attribution, NSError * _Nullable error) {
		if (error) {
			NSLog(@"%@", error);
		} else if (placemarks.count > 0) {
			NSLog(@"Forward Geocode %@%@",
			placemarks[0].latitude,placemarks[0].longitude);
			self.resultsLabel.text = placemarks[0].formattedAddress;
		} else {
			self.resultsLabel.text = @"No results";
		}
	}];
```
#### Swift
```swift
let geocodeManager = MapmyIndiaGeocodeManager.shared
//Or
let geocodeManager = MapmyIndiaGeocodeManager(restKey:
MapmyIndiaAccountManager.restAPIKey())

let forOptions = MapmyIndiaForwardGeocodeOptions(query: "237 mapmyindia",
withRegion: .india)
	geocodeManager.geocode(forOptions) { (placemarks, attribution, error) in
		if let error = error {
			NSLog("%@", error)
		} else if let placemarks = placemarks, !placemarks.isEmpty {
			print("Forward Geocode: \(placemarks[0].latitude ?? ""),\
			(placemarks[0].longitude ?? "")")
			self.resultsLabel.text = placemarks[0].formattedAddress
		} else {
			self.resultsLabel.text = "No results"
		}
	}
```

For more details visit our [online documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Geocoding-Forward).

## [Routing API - Legacy](#Routing-API---Legacy)

For live demo click [LIVE DEMO](https://www.mapmyindia.com/api/advanced-maps/doc/sample/mapmyindia-maps-route-rest-api-example)

Get optimal & alternate routes between various locations with or without considering live traffic

Routing and displaying driving directions on map, including instructions for navigation, distance to destination, traffic etc. are few of the most important parts of developing a map based application. This REST API calculates driving routes between specified locations including via points based on route type(fastest or shortest), includes delays for traffic congestion , and is capable of handling additional route parameters like: type of roads to avoid, travelling vehicle type etc.



Class used for routing is `MapmyIndiaRouteTripManager`. Create a `MapmyIndiaRouteTripManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaRouteTripManager` class.

To perform routing use `MapmyIndiaRouteTripOptions` class to pass start location and destination location parameters.

### Request Parameters


Additionally you can pass some other parameters to get some filtered/specific results. Which are as:  
All Parameters defined below are optional parameters and default values will be considered if not sent.

1.  **viaPoints:**  the optional list of via-points. The complete route will therefore be start . via points in provided order . destination Note: "Maximum of 16 via points can be added." Also, look at the pricing section to know about the pricing and deductions for the use of via points in the API.
2.  **routeType:**  It is type of enum `DistanceRouteType`.
3.  **vehicleType:**  It is type of enum `DistanceVehicleType`.
4.  **avoids:**  The parameter to avoid road types along the route with default value none. It is type of enum `DistanceAvoidsType`.
5.  **withAlternatives:**  (true or false) : Parameter to toggle alternative routes. If .true. is sent, alternative routes will be provided else not. By default, the value is false. So, if the parameter is not sent, no alternative routes will be provided.
6.  **withAdvices:**  Advices are turn by turn navigation guidance provided by MapmyIndia routing services (e.g. After 200m take the first exit from the roundabout). To get advices send value true else send false.

### Response Parameters

In response of Route search either you will receive an error or an object of MapmyIndiaTripResult. You will find below useful properties in placemarks object :

1. **status**
	- a. Success:
		-   i) 0 for OK (All else means some failure in routing)
	    -   b. Errors:
	        -   i) 1 for too few waypoints provided]
	        -   ii) 2 for system error, route calculation failed.
2. **trips:**  A collection of routes that contain an object with the following properties:
	- **duration**: Duration of the route in seconds.
	- **status:**  Status set by routing engine: 6 means OK, any other number represents specific routing error. (Number)
	- **length:** Length of the entire trip in meters.
	- **pts:**  string of WGS-84 longitude-latitude pairs that indicates the path that needs to be drawn on the map to indicate the computed route. Please see notes below.
	- **advices (object):**  An array of advice objects. An advice is the instruction for the end user that often appears at critical points along a route. Each advice object consists of:
		- **text:**  Description of the advice.
		- **iconId:**  The numeric id of the icon that represents current advice icon. For details refer to Appendix C.
		- **meters:**  Distance to the advice location from the start point.
		- **seconds:**  Time to reach to the advice location from the start point.
		- **exitNR:**  The exit number on roundabout exit, 0 if advice is not on roundabout manoeuvre.
		- **point:**  an object of latitude and longitude of the location of the advice.
			- **longitude:**  longitude of the advice position.
			- **latitude:**  latitude of the advice position
3. **alternatives:**  A collection of alternative routes if the alternatives parameter is provided and is set to true else null is returned.

**Note:**
-   In case Via-Points are provided, no alternative routes will be returned.
-   If Via Points are provided then each via point is considered as a single trip hence you.ll receive a collection of trips object with 1 item if no via point is added and more if via points are added.
-   The Data type of `alternatives` is the same as that of the trip object
-   pts string needs to decode and convert into array of coordinates to be used on application side. A library to achieve this can be found here. Where precision 1e6 should be passed to decode.


### Code Samples

#### Objective C
```objectivec
MapmyIndiaRouteTripManager *routeTripManager = [MapmyIndiaRouteTripManager
sharedManager];
//Or
MapmyIndiaRouteTripManager *routeTripManager = [[MapmyIndiaRouteTripManager
alloc] initWithRestKey:MapmyIndiaAccountManager.restAPIKey];

MapmyIndiaRouteTripOptions *routeOptions = [[MapmyIndiaRouteTripOptions
alloc] initWithStartLocation:[[CLLocation alloc] initWithLatitude:28.551052
longitude:77.268918] destinationLocation:[[CLLocation alloc]
initWithLatitude:28.630195 longitude:77.218119]];
[routeOptions setRouteType:MMIDistanceRouteTypeQuickest];
[routeOptions setVehicleType:MMIDistanceVehicleTypePassenger];
[routeOptions setAvoids:MMIDistanceAvoidsTypeAvoidToll];
[routeOptions setWithAdvices:true];
[routeOptions setWithAlternatives:true];
[routeTripManager getResultWithOptions:routeOptions
completionHandler:^(MapmyIndiaTripResult * _Nullable result, NSString *
_Nullable attribution, NSError * _Nullable error) {
		if (error) {
			NSLog(@"%@", error);
		} else if (result) {
			NSLog(@"Driving Route %@", result.status);
			if (result.alternatives.count > 0) {
				NSLog(@"Driving Route Alternatives %@,
				%@",result.alternatives[0].duration, result.alternatives[0].length);
				if (result.alternatives[0].advices.count > 0) {
					NSLog(@"Alternatives advices:
					%ld",result.alternatives[0].advices.count);
					NSLog(@"Alternatives advices Text:
					%@",result.alternatives[0].advices[0].text);
				}
			}
			if (result.trips.count > 0) {
				NSLog(@"Driving Route Alternatives %@,
				%@",result.trips[0].duration, result.trips[0].length);
					if (result.trips[0].advices.count > 0) {
						NSLog(@"Trips advices:
						%ld",result.trips[0].advices.count);
					}
			}
			self.resultsLabel.text = [result.status stringValue];
		} else {
			self.resultsLabel.text = @"No results";
		}
	}];
```
#### Swift
```swift
let routeTripManager = MapmyIndiaRouteTripManager.shared
//Or
let routeTripManager = MapmyIndiaRouteTripManager(restKey:
MapmyIndiaAccountManager.restAPIKey())

let routeOptions = MapmyIndiaRouteTripOptions(startLocation:
CLLocation(latitude: 28.551052, longitude: 77.268918), destinationLocation:
CLLocation(latitude: 28.630195, longitude: 77.218119))
routeOptions.withAdvices = true
routeOptions.withAlternatives = true
routeOptions.avoids = .avoidToll
routeOptions.routeType = .shortest
routeOptions.vehicleType = .passenger
routeTripManager.getResult(routeOptions) { (result, attribution,
error) in
		if let error = error {
			NSLog("%@", error)
		} else if let result = result {
			print("Driving Route: \(result.status)")
				if let alternatives = result.alternatives, !
				alternatives.isEmpty {
					print("Driving Route Alternatives: \
					(alternatives[0].duration),\(alternatives[0].length)")
				}
			if let trips = result.trips, !trips.isEmpty {
				print("Driving Route Trips: \(trips[0].duration),\
				(trips[0].length)")
			}
			self.resultsLabel.text = "\(result.status)"
		} else {
			self.resultsLabel.text = "No results"
		}
	}
```

For more details visit our [online documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#Route).

## [Driving Distance Matrix API - Legacy](#Driving-Distance-Matrix-API---Legacy)

For live demo click [LIVE DEMO](https://www.mapmyindia.com/api/advanced-maps/doc/sample/mapmyindia-maps-distance-rest-api-example)

Get driving distance & time from a point to multiple destination

Adding driving distance matrix API would help to add predicted travel time & duration from a given origin point to a number of points. The Driving Distance Matrix API provides driving distance and estimated time to go from a start point to multiple destination points, based on recommended routes from MapmyIndia Maps and traffic flow conditions.



Class used for driving distance is `MapmyIndiaDrivingDistanceManager`. Create a `MapmyIndiaDrivingDistanceManager` object using your rest key or alternatively, you can place your rest key in the `MapmyIndiaRestKey` key of your application's Info.plist file, then use the shared instance of `MapmyIndiaDrivingDistanceManager` class.

To perform distance matrix calculation use `MapmyIndiaDrivingDistanceOptions` class to pass center location and points parameters. Where Driving distance will give distance for each point to center location.

### Request Parameters

Additionally you can pass some other parameters to get filtered/specific results. Which are as :

1.  **routeType:**  It is type of enum `DistanceRouteType`.
2.  **vehicleType:**  It is type of enum `DistanceVehicleType`.
3.  **avoids:**  The parameter to avoid road types along the route with default value none. It is type of enum `DistanceAvoidsType`.
4. **withTraffic:**  The parameter is to check distance along the traffic with default value false. To get distance with traffic pass true.

### Response Parameters

In response of Driving Distance either you will receive an error or an array of `MapmyIndiaDrivingDistancePlacemark` respectively result of each point passed in request. You will find below useful properties in placemarks object :

-   **duration:**  Duration of route in seconds.
-   **status:**  Status set by routing engine: 6 means OK, any other number represents specific routing error.
-   **length:**  Length of route in meters.



### Code Samples

#### Objective C
```objectivec
MapmyIndiaDrivingDistanceManager * distanceManager =
[MapmyIndiaDrivingDistanceManager sharedManager];
//Or
MapmyIndiaDrivingDistanceManager * distanceManager =
[[MapmyIndiaDrivingDistanceManager alloc]
initWithRestKey:MapmyIndiaAccountManager.restAPIKey];

MapmyIndiaDrivingDistanceOptions *distanceOptions =
[[MapmyIndiaDrivingDistanceOptions alloc] initWithCenter:[[CLLocation
alloc] initWithLatitude:28.543014 longitude:77.242342] points:[NSArray
arrayWithObjects: [[CLLocation alloc] initWithLatitude:28.520638 longitude:
77.201959], nil]];
[distanceManager getResultWithOptions:distanceOptions
completionHandler:^(NSArray<MapmyIndiaDrivingDistancePlacemark *> *
_Nullable placemarks, NSString * _Nullable attribution, NSError * _Nullable
error) {
		if (error) {
			NSLog(@"%@", error);
		} else if (placemarks.count > 0) {
			NSLog(@"Driving Distance %@,%@", placemarks[0].duration,
			placemarks[0].length);
			self.resultsLabel.text = [placemarks[0].status stringValue];
		} else {
			self.resultsLabel.text = @"No results";
		}
	}];
```
#### Swift
```swift
let distanceManager = MapmyIndiaDrivingDistanceManager.shared
//Or
let distanceManager = MapmyIndiaDrivingDistanceManager(restKey:
MapmyIndiaAccountManager.restAPIKey())

let distanceOptions = MapmyIndiaDrivingDistanceOptions(center:
CLLocation(latitude: 28.543014, longitude: 77.242342), points:
[CLLocation(latitude: 28.520638, longitude: 77.201959)])
distanceManager.getResult(distanceOptions) { (placemarks,
attribution, error) in
		if let error = error {
			NSLog("%@", error)
		} else if let placemarks = placemarks, !placemarks.isEmpty {
			print("Driving Distance: \(placemarks[0].duration),\
			(placemarks[0].length)")
			self.resultsLabel.text = "\(placemarks[0].duration)"
		} else {
			self.resultsLabel.text = "No results"
		}
	}
```
For more details visit our [online documentation](https://www.mapmyindia.com/api/advanced-maps/ios/vector-map-sdk#DrivingDistance).

## [POI Along The Route API](#POI-Along-The-Route-API)

With POI Along the Route API user will be able to get the details of POIs of a particular category along his set route. The main focus of this API is to provide convenience to the user and help him in locating the place of his interest on his set route.

Class used to get list of POI along a route is `MapmyIndiaPOIAlongTheRouteManager`. Create an object of this class using MapmyIndia API Keys or alternatively use shared instance of `MapmyIndiaPOIAlongTheRouteManager` class.

**Note:** To use shared SDK must be initilized by setting MapmyIndia API Acesss Keys using class `MapmyIndiaAccountManager` of framework `MapmyIndiaAPIKit`. For more information please see [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki#Setup-your-Project).

### Request Parameters

`MapmyIndiaPOIAlongTheRouteOptions` is request class which will be used to pass all required and optional parameters. So it will be require to create an instance of `MapmyIndiaPOIAlongTheRouteOptions` and pass that instance to `getPOIsAlongTheRoute` function of `MapmyIndiaPOIAlongTheRouteManager`.

#### Mandatory Parameters:
1.  **path:** This parameter takes the encoded route along which POIs to be searched. It is of type `String`.
1.  **category:** The POI category code to be searched. Only one category input supported. It is of type `String`.

#### Optional Parameters:
Additionally you can pass some other parameters to get filtered/specific results. Which are as :-

1.  **sort:**  It is of type `Bool`. Gets the sorted POIs along route.
1.  **geometries:**  It is of enum type `MMIPolylineGeometryType`, default value is `polyline5`. Values of enum specifies type of geometry encoding.
1.  **buffer:** It is of type `Int`. Buffer of the road.
1. **page:**  It is of type `Int`. Used for pagination. By default, a request returns maximum 10 results and to get the next 10 or so on pass the page value accordingly. Default is 1.

### Response Parameters:

In callback of `getPOIsAlongTheRoute` function it will either return an error object of type 'NSError' or an array of type `MapmyIndiaPOISuggestion`. Below is list of parameters of `MapmyIndiaPOISuggestion`:

- **distance**: distance of the POI.
- **placeId:** eLoc of the POI
- **poi:** Name of the POI
- **subSubLocality:** Subsublocality of the POI
- **subLocality:** Sublocality of the POI
- **locality:** Locality of the POI
- **city:** City of the POI
- **subDistrict:** Sub district of the POI
- **district:** District of the POI
- **state:** State of the POI
- **popularName:** Popular name of the POI
- **address:** Address of the POI
- **telephoneNumber:** Telephone number of the POI
- **email:** Email of the POI
- **website:** Website of the POI
- **latitude:** Latitude of the POI
- **latitudeObjC:** `latitude` only while coding in Objective-C.
- **longitude:** Longitude of the POI
- **longitudeObjC:** `longitude` only while coding in Objective-C.
- **entryLatitude:** Entry latitude of the POI
- **entryLatitudeObjC:** `entryLatitude` only while coding in 
- **entryLongitude:** Entry longitude of the POI
- **entryLongitudeObjC:** `entryLongitude` only while coding in Objective-C.
- **brandCode:** Brand id of the POI

**Swift**

```swift
let poiAlongTheRouteManager = MapmyIndiaPOIAlongTheRouteManager.shared
let routePath = "mfvmDcalvMB?B?@EB}@lABzABrBDAaAFoDFuCFuC@{@@m@DoAFu@D_@VmAFWHSHKBCFCbA]n@S`@IX?^BdAL|ANtCV~ANXBfBDfBBl@Bp@BrA@Pa@FKHMf@@`CHXDLBJFHJHRbD@`D@Z?h@@f@@h@@bAB^@jDDlBB~@BT@N?dDDV?x@Bt@@dCFdCFzB@nD?N?|BEzBEzBE`@AJ?lCOxCMfAClCGnCIlCIlCIhDKfDIhDIzCK|AG|AEbBG`A@d@FVD^FjARlBVn@D`AD|@Fn@DnCZnCZtBTH@J?V@`A@lC@nC@lCB`AGNCTCPEl@SRI|@a@~BqAb@OZGt@E|BEl@AxA?|@?pA@T?V@bCB`AJNBn@L^NpAl@t@`@d@V~BlA`CnA~BnA`A`@VJd@NXF~@JN@xBBL?hA?x@Ar@?x@A@?vCAvCAvCAxCAj@F`@Fd@Nf@RrAn@|@b@dBz@fBz@nBfAJF~Ax@`CfAXLRHp@XtCpAtCrAf@V|@Rf@Px@TxAZF`BL`BLZEPERGNKPQR_@BaBPeEHeAXo@NcDLaDNaDNaDAkB?kAKqDIoD_@mAI{BI{BGgBIgBGiBCm@ASAi@Cu@Cc@Ag@Aa@GgBGgBGkBAu@IeCAUJARARA~@GB?f@C|AK`BIbBIt@IPCPCZO`@[FKLOR]Vk@Pi@DUL{@D[P}CP{C@i@@a@Ae@EiBCiBAyC?_ACaB?QAeBAgB?WB_@BSDSDOTu@dA{Cr@sBRi@JU^q@j@cATYZ_@TUbBsAHIhA}@jA_AlAaA`Ay@bAy@d@c@pAgAv@q@`AcA^_@tAoAVSVQLGdAg@f@Yz@e@W_@KSWIoAuCmAwCLMBCDCNE@AJ?H@F@v@fBGNGb@WYfAcALI@C@CBADCD@JBDBBBBD@D?DDLBFJNFDHDF@J@|CKbCItAEHCHA@EBEDCDABAF?D@DB@BDH@D?JADL@l@?j@BbAGGcAGiACc@Cm@C["
let poiAlongTheRouteOptions = MapmyIndiaPOIAlongTheRouteOptions(path: routePath, category: "FODCOF")
poiAlongTheRouteOptions.buffer = 300

poiAlongTheRouteManager.getPOIsAlongTheRoute(poiAlongTheRouteOptions) { (suggestions, error) in
	if let error = error {

	} else if let suggestions = suggestions {
		for suggestion in suggestions {
            print("POI Along \(suggestion.latitude) \(suggestion.longitude)")
        }
	}            
}
```

**Objective-C**

```objectivec
MapmyIndiaPOIAlongTheRouteManager * poiAlongTheRouteManager = [MapmyIndiaPOIAlongTheRouteManager sharedManager];
NSString *routePath = @"mfvmDcalvMB?B?@EB}@lABzABrBDAaAFoDFuCFuC@{@@m@DoAFu@D_@VmAFWHSHKBCFCbA]n@S`@IX?^BdAL|ANtCV~ANXBfBDfBBl@Bp@BrA@Pa@FKHMf@@`CHXDLBJFHJHRbD@`D@Z?h@@f@@h@@bAB^@jDDlBB~@BT@N?dDDV?x@Bt@@dCFdCFzB@nD?N?|BEzBEzBE`@AJ?lCOxCMfAClCGnCIlCIlCIhDKfDIhDIzCK|AG|AEbBG`A@d@FVD^FjARlBVn@D`AD|@Fn@DnCZnCZtBTH@J?V@`A@lC@nC@lCB`AGNCTCPEl@SRI|@a@~BqAb@OZGt@E|BEl@AxA?|@?pA@T?V@bCB`AJNBn@L^NpAl@t@`@d@V~BlA`CnA~BnA`A`@VJd@NXF~@JN@xBBL?hA?x@Ar@?x@A@?vCAvCAvCAxCAj@F`@Fd@Nf@RrAn@|@b@dBz@fBz@nBfAJF~Ax@`CfAXLRHp@XtCpAtCrAf@V|@Rf@Px@TxAZF`BL`BLZEPERGNKPQR_@BaBPeEHeAXo@NcDLaDNaDNaDAkB?kAKqDIoD_@mAI{BI{BGgBIgBGiBCm@ASAi@Cu@Cc@Ag@Aa@GgBGgBGkBAu@IeCAUJARARA~@GB?f@C|AK`BIbBIt@IPCPCZO`@[FKLOR]Vk@Pi@DUL{@D[P}CP{C@i@@a@Ae@EiBCiBAyC?_ACaB?QAeBAgB?WB_@BSDSDOTu@dA{Cr@sBRi@JU^q@j@cATYZ_@TUbBsAHIhA}@jA_AlAaA`Ay@bAy@d@c@pAgAv@q@`AcA^_@tAoAVSVQLGdAg@f@Yz@e@W_@KSWIoAuCmAwCLMBCDCNE@AJ?H@F@v@fBGNGb@WYfAcALI@C@CBADCD@JBDBBBBD@D?DDLBFJNFDHDF@J@|CKbCItAEHCHA@EBEDCDABAF?D@DB@BDH@D?JADL@l@?j@BbAGGcAGiACc@Cm@C[";
MapmyIndiaPOIAlongTheRouteOptions * poiAlongTheRouteOptions = [[MapmyIndiaPOIAlongTheRouteOptions alloc] initWithPath:routePath category:@"FODCOF"];
poiAlongTheRouteOptions.buffer = 300;
[poiAlongTheRouteManager getPOIsAlongTheRoutekWithOptions:poiAlongTheRouteOptions completionHandler:^(NSArray<MapmyIndiaPOISuggestion *> * _Nullable suggestions, NSError * _Nullable error) {
    if (error) {
            
    } else if (suggestions) {
        for (MapmyIndiaPOISuggestion *suggestion in suggestions) {
            NSLog(@"POI Along %@%@ %@ %@", suggestion.latitudeObjC, suggestion.longitudeObjC, suggestion.placeId, suggestion.distanceObjC);
        }
    }
}];
```

<br/>

## [Nearby Reports API](#Nearby-Reports-API)

Nearby Reports enables the user to get required reports related to traffic, safety, community issues etc on the basis of input bound.

Class used to get list of Nearby Reports API is `MapmyIndidiaNearbyReportManager`. Create an object of this class using MapmyIndia API Keys or alternatively use shared instance of `MapmyIndidiaNearbyReportManager` class.

**Note:** To use shared SDK must be initilized by setting MapmyIndia API Acesss Keys using class `MapmyIndiaAccountManager` of framework `MapmyIndiaAPIKit`. For more information please see [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki#Setup-your-Project).

### Request Parameters

`MapmyindiaNearbyReportOptions` is request class which will be used to pass all required and optional parameters. So it will be require to create an instance of `MapmyindiaNearbyReportOptions` and pass that instance to `getNearbyReportResult` function of `MapmyIndidiaNearbyReportManager`.

#### Mandatory Parameters:
1.  **bound:** This parameter takes bound. It is of type `MapmyIndiaRectangularRegion` which is s a rectangular bounding box for a geographic region. whic contains following parameters
	a. bottomRight :- Coordinate at the bottomRight corner which is of type `CLLocationCoordinate2D`
	b. topLeft:- Coordinate at the northeast corner which is of type `CLLocationCoordinate2D`

### Response Parameters:

In callback of `getPOIsAlongTheRoute` function it will either return an error object of type 'NSError' or an array of type `MapmyIndiaNearbyReportResponse`. Below is list of parameters of `MapmyIndiaNearbyReportResponse`:

- **`id`(String)**: Id of the report.
- **`latitude`(Double):** Latitude of the report.
- **`longitude`(Double):** Longitude of the report.
- **`category`(String):** Report category
- **`createdOn`(Int):** Timestamp when event created


**Swift**

```swift
let mapmyIndiaNearbyReportManager = MapmyIndiaNearbyReportManager.shared
let topleft = CLLocationCoordinate2D(latitude: 28.0, longitude: 78.32)
let bottomRight = CLLocationCoordinate2D(latitude: 34.0, longitude: 78.32)

let bound = MapmyIndiaRectangularRegion(topLeft: topleft, bottomRight: bottomRight)
let option = MapmyindiaNearbyReportOptions(bound: bound)
mapmyIndiaNearbyReportManager.getNearbyReportResult(option) { (response, error) in
	if let error = error {
		print("error: \(error.localizedDescription)")
		self.alertView(message: error.localizedDescription)
	} else {
		if let res: MapmyIndiaNearbyReportResponse = response, let totalItem = res.pagination?.totalItems {
			if let reports = res.reports {
				for i in reports {
					if let lat = i.latitude, let long = i.longitude {
						let coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
						print("Reported Coordinate: \(coordinate)")
					}
				}
			}
			print("Total item : \(totalItem)")
		}
	}
}
```
## [Road Traffic Details API](#Road-Traffic-Details-API)

### [Introduction](#Introduction)

To provide the details of nearest road with reference of a given GPS point.

Class used to get details of nearest road is `MapmyIndiaRoadTrafficDetailsManager`. Create an object of this class using MapmyIndia API Keys or alternatively use shared instance of `MapmyIndiaRoadTrafficDetailsManager` class.

**Note:** To use shared SDK must be initilized by setting MapmyIndia API Acesss Keys using class `MapmyIndiaAccountManager` of framework `MapmyIndiaAPIKit`. For more information please see [here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki#Setup-your-Project).

### [Request Parameters](Request-Parameters)

[`MapmyIndiaRoadTrafficDetailsOptions`](#MapmyIndiaRoadTrafficDetailsOptions) is request class which will be used to pass all required and optional parameters. So it will be require to create an instance of [`MapmyIndiaRoadTrafficDetailsOptions`](#MapmyIndiaRoadTrafficDetailsOptions) and pass that instance to `getTrafficRoadDetailsResults` function of `MapmyIndiaRoadTrafficDetailsManager`.

#### [MapmyIndiaRoadTrafficDetailsOptions](#MapmyIndiaRoadTrafficDetailsOptions)

- **latitude** (mandatory)
- **longitude** (mandatory)
- **radius** (optional) :- Limits the search to given radius in meters

### [Response Parameters]s(#Response-Parameters):

In callback of `getTrafficRoadDetailsResults` function it will either return an error object of type 'NSError' or an object of type `MapmyIndiaRoadTrafficDetailsResponse`. which contains result parameter of type `MapmyIndiaRoadTrafficDetailsResult` which has following response parameter

- **name :** Name of the nearest road from given coordinates (If available); else null it is of type `String`
- **routeNo :** If available, route number information of road, else null it is of type `String`
- **oneway :** If traffic flows in digitized direction only then `true`, else `false` it is of type `Bool`
- **avg_spd :** Calculated average speed of referenced segment it is of type `Int`
- **spd_lmt :** If available, posted speed limit applicable for 4 wheeler. it is of type `Int`
- **formOfWay :** Type of road feature like Bridge, Circle, Ramp, Flyover, Subway, Tunnel it is of type `String`
- **roadClass :** Road category information, possible values are 'District Highway', 'Golden Quadrilateral', 'Major District Road', 'Major Village Road', 'National Highway', 'Other Roads', 'State Highway', 'Urban Arterial Road', 'Urban Collector Road', 'Urban Minor Road', 'Urban Secondary Road' it is of type `String`
- **multi_cw :** If road segment is part of Multi carriageway Road then `true` else `false` it is of type `Bool`
- **divider :** If physical divider exist on referenced road then `true`, it is of type `Bool`
- **numOfLanes :** Number of lane available on that road segment (if available); else null it is of type `String`
- **shoulder :** If shoulder lane exist then true, else false. Please note that shoulder information is available for selected road segments only it is of type `Bool`
- **owner :** Possible values NHAI, null. As of now owner information is available for National Highways only it is of type `String`
- **distance :** Distance in meters from supplied input coordinate. it is of type `Double`
- **city :** City name with referenced to the segment it is of type `String`
- **district :** District name with referenced to the segment it is of type `String`
- **state :** State name with referenced to the segment it is of type `String`
- **geometry :** Returns the encoded geometry of the road segment it is of type `String`
- **trafficStatus :** Information about Traffic Flow on nearest segment. Available values are mentioned below:
   - **Severe :** Stationary traffic on matched segment
   - **Heavy :** Heavy traffic congestion
   - **Moderate :** Traffic flow is moderate
   - **Low :** Traffic is moving smoothly
   - **Closure :** Matched road segment is closed
   - **Not Applicable :** No traffic flow information available for matched segment.
   
- **trafficType:** numeric codes for trafficStatus; available values are:
   - **1 :**  closure
   - **2 :**  severe
   - **3 :**  heavy
   - **4 :**  moderate
   - **5 :**  low
   - **6 :** Not Applicable

**Swift**

```swift
let options = MapmyIndiaRoadTrafficDetailsOptions(latitude: 28.987, longitude: 78.323)
let manager = MapmyIndiaRoadTrafficDetailsManager.shared
manager.getTrafficRoadDetailsResults(options) { resposnse, error in
	if let error = error {
		print("Road traffic error: \(error.localizedDescription)")
	} else {
		if let response  = resposnse {
			let res: MapmyIndiaRoadTrafficDetailsResponse = response
			if let result : MapmyIndiaRoadTrafficDetailsResult = res.result {
				print(result.ditance)
			}
		}
	}
}       
    
```
<br/>

## Our many happy customers

![](https://www.mapmyindia.com/api/landing-page/images/pey-phone.png)  ![](https://www.mapmyindia.com/api/landing-page/images/tvs.png)  ![](https://www.mapmyindia.com/api/landing-page/images/olx.png)  ![](https://www.mapmyindia.com/api/landing-page/images/axis-bank.png)  ![](https://www.mapmyindia.com/api/landing-page/images/hdfc.png)  ![](https://www.mapmyindia.com/api/landing-page/images/sbi.png)  ![](https://www.mapmyindia.com/api/landing-page/images/voda-fone.png)  ![](https://www.mapmyindia.com/api/landing-page/images/idea.png)


<br/>

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
>  Written with [StackEdit](https://stackedit.io/) by MapmyIndia.