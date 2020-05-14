# Changes to the MapmyIndia's Sample for available iOS SDKs

## 1.4.6 - 13 May, 2020

#### Changed

- Map SDK version 5.7.5 released with dependency of MapmyIndiaSafetyPlugin through Cocoapods.
- A sample is added to demonstrated features of MapmyIndiaSafetyPlugin with title `safetyPlugin`.


## 1.4.5 - 24 Apr, 2020

#### Fixed

- Fixed an issue where app was not able to run on device because MapmyIndiaFeedbackUIKit framework was not added in Linked Libraries of Sample Application.

- Map SDK updated to version 5.7.1
    - Tile issue fixed where tiles not fetching after expiring of vector key.

## 1.4.4 - 06 Apr, 2020

#### Added

- Sample is made compatible with available MapmyIndia's Cocoapods libraries by adding a podfile.
    - Mapbox framework is replaced with **MapmyIndiaMaps**.
    - MapboxDirections framework is replaced with **MapmyIndiaDirections**.
    - Changes in route calling method are made as per latest SDK where to call route ETA API resourceIdentifier parameter will be used and required value will be `.routeETA`.    

- MapmyIndiaFeedbackKit framework is now part of project itself, No need to download seperately.

- Changelog file CHANGELOG.md is added in sample project.

## 1.4.3 - 06 Apr, 2020

#### Fixed

- Folder structure was fixed where empty `Dependencies` folder was not avaialble in project.