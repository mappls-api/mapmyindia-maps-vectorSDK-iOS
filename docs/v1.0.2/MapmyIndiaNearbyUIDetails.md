![MapmyIndia APIs](https://www.mapmyindia.com/api/img/mapmyindia-api.png)

# MapmyIndia Nearby Search Widget - Advanced Details for iOS

For installation / basic information  [click here](https://github.com/MapmyIndia/mapmyindia-maps-vectorSDK-iOS/wiki/MapmyIndiaNearbyUI)

## [Optional Configurations](#Optional-Configurations)

#### [MapmyIndiaNearbyCategories](#MapmyIndiaNearbyCategories)

It is the class of type `NSObject` that is used to get the information for the nearby categories to show in `MapmyIndiaNearbyCategoriesViewController`.

It contains the following properties.

- *title:-* It is of type `String` used for the title of the categories button 

- *selectedBackgroundColor:-* It is of type `UIColor` used for  the background color for selected  category button.

- *unselectedBackgroundColor:-* It is of type `UIColor` used for  the background color for unselected  category button.

- *selectedImage:-* It is of type `UIImage` used for selected category button image.

- *unselectedImage:-* It is of type `UIImage` used for unselected category button image.

- *unselectedTextColor:-* It is of type `UIColor` used for  title text color  for unselected category button.

- *selectedTextColor:-* It is of type `UIColor` used for title text color  for selected category button.

- *isSelected:-* It is the `Bool` property for showing either the category button is selected or not.

- *tintColor:-* It is used to change the image color of the selected category button. It will be used when the user will be using a single png image for both the selected and unselected categories button.

- *categoryKeywords:-* It is an array of `String` which is used as a keyword in the query of nearby search.

- *mapNearbyCategoryIcon:-* It is of `UIImage` type which is used as a category image icon for individual category while plotting icon for the nearby search result.

#### [MapmyIndiaNearbyCategoryConfiguration](#MapmyIndiaNearbyCategoryConfiguration)

It is a class of type `NSObject` that is used for configuring the UI properties of the `MapmyIndiaNearbyCategoriesViewController` class.

It contains the following properties.

- *titleViewContainerBackgroundColor:* It is the property of type `UIColor` used for setting the background color of titleViewContainer 

- *titleViewBackgroundColor:-* It is the property of type `UIColor` used for setting the background color of titleView 
    
 - *titleColor:-* It is the property of type `UIColor` used for setting the title color of title 
    
- *titleFont:* It is the property of type `UIFont` used for setting the title font of title 
    
 - *navigationImage:-* It is the property of type `UIImage` used for setting the image in navigationImageView

 - *nextButtonTitle:* It is the property of type `String` used for set the Next button title
    
 - *nextButtonTextFont:* It is the property of type `UIFont` used for set the Next button title  font
    
 - *nextButtonTextColor:* It is the property of type `UIColor` used for set the Next button title  color
    
 - *nextButtonBorderColor:* It is the property of type `UIColor` used for set the Next button border  color
    
 - *nextButtonBorderWidth:* It is the property of type `CGFloat` used for set the Next button border  width
 
 - *nextButtonCornerRadius:* It is the property of type `CGFloat` used for set the Next button corner radius
 
 - *nextButtonBackgroundColor:* It is the property of type `UIColor` used for set the Next button background color
 
 - *locationDetailsViewBackground:* It is the property of type `UIColor` used for set the locationDetailsView background color
 
 - *locationDetailsViewCornerRadius:* It is the property of type `CGFloat` used for set the locationDetailsView corner radius 
    
 - *locationDetailsViewShadowColor*: It is the property of type `UIColor` used for set the locationDetailsView shadow color 
 
 - *locationDetailsViewShadowOpacity:* It is the property of type `Float` used for set the locationDetailsView shadow opacity 
    
 - *locationDetailsViewShadowOffset:* It is the property of type `CGSize` used for set the locationDetailsView shadow offset 
    
 - *locationDetailsViewShadowRadius:* It is the property of type `CGFloat` used for set the locationDetailsView shadow radius 
    
 - *locationDetailsInfoLabelText*: It is the property of type `String` used for set the locationDetailsInfoLabel text 
    
 - *locationDetailsInfoLabelTextColor:* It is the property of type `UIColor` used for set the locationDetailsInfoLabel text   color
    
 - *locationDetailsInfoLabelTextFont*: It is the property of type `UIFont` used for set the locationDetailsInfoLabel text  font
    
 - *locationDetailsFormatedAddressLabelTextColor:* It is the property of type `UIColor` used for set the locationDetailsFormatedAddressLabel text color
 
 - *locationDetailsFormatedAddressLabelTextFont:* It is the property of type `UIFont` used for set the locationDetailsFormatedAddressLabel text font.

 - *changeLocationButtonTitle:*  It is the property of type `String` used to set the changeLocationButton title.

 - *changeLocationButtonTitleColor:* It is the property of type `UIColor` used for set the changeLocationButton title color.

 - *changeLocationButtonTitleFont:* It is the property of type `UIFont` used for set the changeLocationButton title Font.

 - *usedCurrentLocationButtonTitle:*  It is the property of type `String` used for set the useCurrentLocationButton title. 

 - *usedCurrentLocationButtonTitleColor:* It is the property of type `UIColor` used for set the useCurrentLocationButton title color. 

 - *usedCurrentLocationButtonTitleFont:* It is the property of type `UIFont` used for set the useCurrentLocationButton title font.  


#### [MapmyIndiaNearbyConfiguration](#MapmyIndiaNearbyConfiguration)

A object of type `MapmyIndiaNearbyConfiguration` which will be required in `MapmyIndiaNearbyMapViewController` to  configure the UI components and nearby request parametes

It contains two object 

- mapmyIndiaNearbyUIConfiguration:- It will helps to configure UI Components of `MapmyIndiaNearbyMapViewController` and it is of type `MapmyIndiaNearbyUIConfiguration`.
- mapmyIndiaNearbyFilterConfiguration:- It will helps to send custom request parameters in mapmyIndiaNearbyApi and it is of type `MapmyIndiaNearbyFilterConfiguration`.

#### [MapmyIndiaNearbyUIConfiguration](#MapmyIndiaNearbyUIConfiguration)

Its contains following properies 

- *refLocationIcon:* An Icon image of type `UIImage` for the refLocation set by user which will be in the center of the map.

- *refLocationCircleColor:* A property for filling color in circle.  of type `UIColor`

- *circleAlpha:*

- *paginationNextButtonImage:* A property  for pagination next button image  of type `UIImage`

- *paginationNextButtonbackgroundcolor:* A property  for pagination next button background of type `UIColor`

- *paginationContainerViewBackgroundColor:* A property  for paginationContainerViewBackground color of type `UIColor`.

- *paginationPreviousButtonImage:* A property  for pagination previous button image  of type `UIImage`.

- *paginationPreviousButtonbackgroundcolor:* A property  for pagination previous button background of type `UIColor`.

- *nearbyFilterViewContainerBackgroundColor:* A property  for FilterViewContainer background color of type `UIColor`

- *nearbyFilterCellBorderWidth:*  A property  for nearbyFilterCell border width  of type `CGFloat`

- *nearbyFilterCellBorderColor:*  A property  for nearbyFilterCell border color  of type `UIColor`

- *nearbyFilterCellCornerRadius:* A property  for nearbyFilterCell corner radius   of type `CGFloat`

- *nearbySegmentedViewContainerBackgroundColor:* A property  for nearbySegmentedViewContainer background color of type `UIColor`.

- *segmentedControlSelectedSegmentIndex:* A property  for segmentedControl SelectedSegmentIndex i.e which index should be selcted while opening the class `MapmyIndiaNearbyMapsViewController`

- *segmentedControlBackgroundColor:* A property  for segmentedControl background color of type `UIColor`

- *segmentedControlBorderColor:* A property  for segmentedControl border color of type `UIColor`

- *segmentedControlBorderWidth:*A property  for segmentedControl border width  of type `CGFloat`

- *segmentedControlSelectedSegmentTintColor:* A property  for segmentedControl SelectedSegmentTintColor i.e which index should be selcted while opening the class   of type `UIColor`

- *segmentedControlUnselectedforegroundColor:* A property  for segmentedControl unselected segment text color of type `UIColor`

- *segmentedControlSelectedforegroundColor:* A property  for segmentedControl selected segment text color  of type `UIColor`

- *segmentedControltTextFont:*  A property  for segmentedControl  segment text font  of type `UIFont`

- *tableCellBackgroundColor:* A property  for segmentedControl SelectedSegmentTintColor   of type `UIColor`

- *tableCellSeparatorColor:* A property  for segmentedControl unselected segment text color of type `UIColor`

- *placeNameTextColor:* The color of result name text in nearby  results of type `UIColor`

- *placeAddressTextColor:* The color result address in nearby  results of type `UIColor`

- *distanceTextColor:* The color of the distance in nearby results of type `UIColor`.


### [MapmyIndiaNearbyFilterConfiguration](#MapmyIndiaNearbyFilterConfiguration)

It is a configuration object to set the  value for nearby request parameters  in the `MapmyIndiaNearbyMapViewController` class

it contains the following properties.

 
1. **refLocation** A location provides the location around which the search will be performed it can be coordinate (latitude, longitude) or eLoc in `String` format.

3.  **radius (integer):**  provides the range of distance to search over (default: 1000, min: 500, max: 10000).

3. **sortBy:** It is used to sort results based on the value provided. It can accept object of `MapmyIndiaSortBy` or `MapmyIndiaSortByWithOrder`

3. **searchBy:** It is used to search places based on the preference provided. It is of enum type `MMISearchByType`  its value can be either `.importance` or `.distance`

3. **filters:**   On basis of this only a specific type of response returned. it can of type `MapmyIndiaNearbySearchFilter`.
MapmyIndiaNearbySearchFilter has the following properties.
	- filterKey :- It takes  value for `key`  to filter result.
	- filterValues :- It takes an array of different query values.
	- logicalOperator :- `logicalOperator` of enum `MapmyIndiaLogicalOperator`  its default value is `and`.


	``` swift 
	let filter = MapmyIndiaNearbyKeyValueFilter(filterKey: "brandId", filterValues: [String,String])
	```

4.  **bounds (x1,y1;x2,y2):**  Allows the developer to send in map bounds to provide a nearby search of the geobounds. where x1,y1 is the latitude,longitude.

5.	**isRichData:** It is of type `Bool`. It allows some additional information to receive in the `richInfo` parameter of the response.

6.	**shouldExplain:** It is of type `Bool`.

7.	**userName:** It is of type `String`. On basis of the value of this, some specific results bounded to a user.

8.  **pod**: It takes place type which helps in restricting the results to a certain chosen type  
    Below mentioned are the codes for the pod -
    -   Sublocality
    -   Locality
    -   City
    -   Village    
