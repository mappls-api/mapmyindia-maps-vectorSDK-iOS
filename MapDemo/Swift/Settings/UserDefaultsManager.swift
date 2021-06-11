//
//  UserDefaultsManager.swift
//  MapDemo
//
//  Created by Apple on 06/08/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import Foundation
import MapmyIndiaUIWidgets
import MapmyIndiaDirections

class UserDefaultsManager {
    static func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
    
    // GeofenceUI Costant.
    private static let polygonFillColorKey = "polygonFillColorKey"
    private static let polygonStrokeColorKey = "polygonStrokeColorKey"
    private static let circleFillColorKey = "circleFillColorKey"
    private static let circleStrokeColorKey = "circleStrokeColorKey"
    private static let markerFillColorKey = "markerFillColorKey"
    private static let markerStrokeColorKey = "markerStrokeColorKey"
    private static let draggingEdgesLineColorKey = "draggingEdgesLineColorKey"
    private static let polygonDrawingOverlayColorKey = "polygonDrawingOverlayColorKey"
    private static let geofencePolygonStrokeWidthKey = "geofencePolygonStrokeWidthKey"
    private static let geofenceCircleStrokeWidthKey = "geofenceCircleStrokeWidthKey"
    
    
    
    
    private static let isCustomMarkerViewKey = "isCustomMarkerViewKey"
    static var isCustomMarkerView: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomMarkerViewKey) {
                return UserDefaults.standard.bool(forKey: isCustomMarkerViewKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomMarkerViewKey)
        }
    }
    
    private static let isMarkerShadowViewHiddenKey = "isMarkerShadowViewHiddenKey"
    static var isMarkerShadowViewHidden: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isMarkerShadowViewHiddenKey) {
                return UserDefaults.standard.bool(forKey: isMarkerShadowViewHiddenKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isMarkerShadowViewHiddenKey)
        }
    }
    
    private static let isCustomSearchButtonBackgroundColorKey = "isCustomSearchButtonBackgroundColorKey"
    static var isCustomSearchButtonBackgroundColor: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomSearchButtonBackgroundColorKey) {
                return UserDefaults.standard.bool(forKey: isCustomSearchButtonBackgroundColorKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomSearchButtonBackgroundColorKey)
        }
    }
    
    private static let isCustomSearchButtonImageKey = "isCustomSearchButtonImageKey"
    static var isCustomSearchButtonImage: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomSearchButtonImageKey) {
                return UserDefaults.standard.bool(forKey: isCustomSearchButtonImageKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomSearchButtonImageKey)
        }
    }
    
    private static let isSearchButtonHiddenKey = "isSearchButtonHiddenKey"
    static var isSearchButtonHidden: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isSearchButtonHiddenKey) {
                return UserDefaults.standard.bool(forKey: isSearchButtonHiddenKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isSearchButtonHiddenKey)
        }
    }
    
    private static let isCustomPlaceNameTextColorKey = "isCustomPlaceNameTextColorKey"
    static var isCustomPlaceNameTextColor: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomPlaceNameTextColorKey) {
                return UserDefaults.standard.bool(forKey: isCustomPlaceNameTextColorKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomPlaceNameTextColorKey)
        }
    }
    
    private static let isCustomAddressTextColorKey = "isCustomAddressTextColorKey"
    static var isCustomAddressTextColor: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomAddressTextColorKey) {
                return UserDefaults.standard.bool(forKey: isCustomAddressTextColorKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomAddressTextColorKey)
        }
    }
    
    private static let isCustomPickerButtonTitleColorKey = "isCustomPickerButtonTitleColorKey"
    static var isCustomPickerButtonTitleColor: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomPickerButtonTitleColorKey) {
                return UserDefaults.standard.bool(forKey: isCustomPickerButtonTitleColorKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomPickerButtonTitleColorKey)
        }
    }
    
    private static let isCustomPickerButtonBackgroundColorKey = "isCustomPickerButtonBackgroundColorKey"
    static var isCustomPickerButtonBackgroundColor: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomPickerButtonBackgroundColorKey) {
                return UserDefaults.standard.bool(forKey: isCustomPickerButtonBackgroundColorKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomPickerButtonBackgroundColorKey)
        }
    }
    
    private static let isCustomPickerButtonTitleKey = "isCustomPickerButtonTitleKey"
    static var isCustomPickerButtonTitle: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomPickerButtonTitleKey) {
                return UserDefaults.standard.bool(forKey: isCustomPickerButtonTitleKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomPickerButtonTitleKey)
        }
    }
    
    private static let isCustomInfoLabelTextColorKey = "isCustomInfoLabelTextColorKey"
    static var isCustomInfoLabelTextColor: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomInfoLabelTextColorKey) {
                return UserDefaults.standard.bool(forKey: isCustomInfoLabelTextColorKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomInfoLabelTextColorKey)
        }
    }
    
    private static let isCustomInfoBottomViewBackgroundColorKey = "isCustomInfoBottomViewBackgroundColorKey"
    static var isCustomInfoBottomViewBackgroundColor: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomInfoBottomViewBackgroundColorKey) {
                return UserDefaults.standard.bool(forKey: isCustomInfoBottomViewBackgroundColorKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomInfoBottomViewBackgroundColorKey)
        }
    }
    
    private static let isCustomPlaceDetailsViewBackgroundColorKey = "isCustomPlaceDetailsViewBackgroundColorKey"
    static var isCustomPlaceDetailsViewBackgroundColor: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCustomPlaceDetailsViewBackgroundColorKey) {
                return UserDefaults.standard.bool(forKey: isCustomPlaceDetailsViewBackgroundColorKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCustomPlaceDetailsViewBackgroundColorKey)
        }
    }
    
    private static let isInitializeWithCustomLocationKey = "isInitializeWithCustomLocationKey"
    static var isInitializeWithCustomLocation: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isInitializeWithCustomLocationKey) {
                return UserDefaults.standard.bool(forKey: isInitializeWithCustomLocationKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isInitializeWithCustomLocationKey)
        }
    }
    
                //placePickerView.autocompleteFilter = MapmyIndiaAutocompleteFilter()
    
    private static let isBottomInfoViewHiddenKey = "isBottomInfoViewHiddenKey"
    static var isBottomInfoViewHidden: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isBottomInfoViewHiddenKey) {
                return UserDefaults.standard.bool(forKey: isBottomInfoViewHiddenKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isBottomInfoViewHiddenKey)
        }
    }
    
    private static let isBottomPlaceDetailViewHiddenKey = "isBottomPlaceDetailViewHiddenKey"
    static var isBottomPlaceDetailViewHidden: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isBottomPlaceDetailViewHiddenKey) {
                return UserDefaults.standard.bool(forKey: isBottomPlaceDetailViewHiddenKey)
            }
            else {
                return true
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isBottomPlaceDetailViewHiddenKey)
        }
    }
    
    private static let attributionHorizontalAlignmentKey = "attributionHorizontalAlignmentKey"
    static var attributionHorizontalAlignment: Int {
        get {
            if isKeyPresentInUserDefaults(key: attributionHorizontalAlignmentKey) {
                return UserDefaults.standard.integer(forKey: attributionHorizontalAlignmentKey)
            }
            else {
                return Int(MapmyIndiaHorizontalContentAlignment.center.rawValue)
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: attributionHorizontalAlignmentKey)
        }
    }
    
    private static let attributionSizeKey = "attributionSizeKey"
    static var attributionSize: Int {
        get {
            if isKeyPresentInUserDefaults(key: attributionSizeKey) {
                return UserDefaults.standard.integer(forKey: attributionSizeKey)
            }
            else {
                return Int(MapmyIndiaContentSize.medium.rawValue)
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: attributionSizeKey)
        }
    }
    
    private static let attributionVerticalPlacementKey = "attributionVerticalPlacementKey"
    static var attributionVerticalPlacement: Int {
        get {
            if isKeyPresentInUserDefaults(key: attributionVerticalPlacementKey) {
                return UserDefaults.standard.integer(forKey: attributionVerticalPlacementKey)
            }
            else {
                return Int(MapmyIndiaVerticalPlacement.before.rawValue)
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: attributionVerticalPlacementKey)
        }
    }
    
    private static let profileIdentifierKey = "profileIdentifierKey"
    static var profileIdentifier: String {
        get {
            if isKeyPresentInUserDefaults(key: profileIdentifierKey) {
                return UserDefaults.standard.string(forKey: profileIdentifierKey)!
            }
            else {
                return String(MBDirectionsProfileIdentifier.driving.rawValue)
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: profileIdentifierKey)
        }
    }

    private static let resourceIdentifierKey = "resourceIdentifierKey"
    static var resourceIdentifier: String {
        get {
            if isKeyPresentInUserDefaults(key: resourceIdentifierKey) {
                return UserDefaults.standard.string(forKey: resourceIdentifierKey)!
            }
            else {
                return String(MBDirectionsResourceIdentifier.routeAdv.rawValue)
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: resourceIdentifierKey)
        }
    }
    
    private static let isDistanceKey = "isDistanceKey"
    static var isDistance: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isDistanceKey) {
                return UserDefaults.standard.bool(forKey: isDistanceKey)
            }
            else {
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isDistanceKey)
        }
    }
    
    private static let isExpectedTravelTimeKey = "expectedTravelTimeKey"
    static var isExpectedTravelTime: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isExpectedTravelTimeKey) {
                return UserDefaults.standard.bool(forKey: isExpectedTravelTimeKey)
            }
            else {
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isExpectedTravelTimeKey)
        }
    }
    
    private static let isSpeedKey = "isSpeedKey"
    static var isSpeed: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isSpeedKey) {
                return UserDefaults.standard.bool(forKey: isSpeedKey)
            }
            else {
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isSpeedKey)
        }
    }
    
    private static let isCongestionLevelKey = "isCongestionLevelKey"
    static var isCongestionLevel: Bool {
        get {
            if isKeyPresentInUserDefaults(key: isCongestionLevelKey) {
                return UserDefaults.standard.bool(forKey: isCongestionLevelKey)
            }
            else {
                return false
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: isCongestionLevelKey)
        }
    }
    
    // Static var for Geofence UI
    static var polygonFillColor: UIColor {
        get {
            let defaultColor = UIColor.blue.withAlphaComponent(0.3)
            if isKeyPresentInUserDefaults(key: polygonFillColorKey) {
                return UserDefaults.standard.colorForKey(key: polygonFillColorKey) ?? defaultColor
            }
            else {
                return defaultColor
            }
        }
        set {
            UserDefaults.standard.setColor(color: newValue, forKey: polygonFillColorKey)
        }
    }
    static var polygonStrokeColor: UIColor {
        get {
            let defaultColor = UIColor.green.withAlphaComponent(0.3)
            if isKeyPresentInUserDefaults(key: polygonStrokeColorKey) {
                return UserDefaults.standard.colorForKey(key: polygonStrokeColorKey) ?? defaultColor
            }
            else {
                return defaultColor
            }
        }
        set {
            UserDefaults.standard.setColor(color: newValue, forKey: polygonStrokeColorKey)
        }
    }
    static var circleFillColor: UIColor {
        get {
            let defaultColor = UIColor.blue.withAlphaComponent(0.3)
            if isKeyPresentInUserDefaults(key: circleFillColorKey) {
                return UserDefaults.standard.colorForKey(key: circleFillColorKey) ?? defaultColor
            }
            else {
                return defaultColor
            }
        }
        set {
            UserDefaults.standard.setColor(color: newValue, forKey: circleFillColorKey)
        }
    }
    static var circleStrokeColor: UIColor {
        get {
            let defaultColor = UIColor.green.withAlphaComponent(0.3)
            if isKeyPresentInUserDefaults(key: circleStrokeColorKey) {
                return UserDefaults.standard.colorForKey(key: circleStrokeColorKey) ?? defaultColor
            }
            else {
                return defaultColor
            }
        }
        set {
            UserDefaults.standard.setColor(color: newValue, forKey: circleStrokeColorKey)
        }
    }
    static var markerFillColor: UIColor {
        get {
            let defaultColor = UIColor.red.withAlphaComponent(0.3)
            if isKeyPresentInUserDefaults(key: markerFillColorKey) {
                return UserDefaults.standard.colorForKey(key: markerFillColorKey) ?? defaultColor
            }
            else {
                return defaultColor
            }
        }
        set {
            UserDefaults.standard.setColor(color: newValue, forKey: markerFillColorKey)
        }
    }
    static var markerStrokeColor: UIColor {
        get {
            let defaultColor = UIColor.red.withAlphaComponent(0.5)
            if isKeyPresentInUserDefaults(key: markerStrokeColorKey) {
                return UserDefaults.standard.colorForKey(key: markerStrokeColorKey) ?? defaultColor
            }
            else {
                return defaultColor
            }
        }
        set {
            UserDefaults.standard.setColor(color: newValue, forKey: markerStrokeColorKey)
        }
    }
    static var draggingEdgesLineColor: UIColor {
        get {
            let defaultColor = UIColor.blue
            if isKeyPresentInUserDefaults(key: draggingEdgesLineColorKey) {
                return UserDefaults.standard.colorForKey(key: draggingEdgesLineColorKey) ?? defaultColor
            }
            else {
                return defaultColor
            }
        }
        set {
            UserDefaults.standard.setColor(color: newValue, forKey: draggingEdgesLineColorKey)
        }
    }
    static var polygonDrawingOverlayColor: UIColor {
        get {
            let defaultColor = UIColor.clear
            if isKeyPresentInUserDefaults(key: polygonDrawingOverlayColorKey) {
                return UserDefaults.standard.colorForKey(key: polygonDrawingOverlayColorKey) ?? defaultColor
            }
            else {
                return defaultColor
            }
        }
        set {
            UserDefaults.standard.setColor(color: newValue, forKey: polygonDrawingOverlayColorKey)
        }
    }
    static var geofencePolygonStrokeWidth: Double {
        get {
            if isKeyPresentInUserDefaults(key: geofencePolygonStrokeWidthKey) {
                return UserDefaults.standard.double(forKey: geofencePolygonStrokeWidthKey)
            }
            else {
                return 2
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: geofencePolygonStrokeWidthKey)
        }
    }
    static var geofenceCircleStrokeWidth: Double {
        get {
            if isKeyPresentInUserDefaults(key: geofenceCircleStrokeWidthKey) {
                return UserDefaults.standard.double(forKey: geofenceCircleStrokeWidthKey)
            }
            else {
                return 2
            }
        }
        set {
            UserDefaults.standard.set(newValue, forKey: geofenceCircleStrokeWidthKey)
        }
    }
    
    
}

extension UserDefaults {
  func colorForKey(key: String) -> UIColor? {
    var colorReturnded: UIColor?
    if let colorData = data(forKey: key) {
      do {
        if let color = try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(colorData) as? UIColor {
          colorReturnded = color
        }
      } catch {
        print("Error UserDefaults")
      }
    }
    return colorReturnded
  }
  
  func setColor(color: UIColor?, forKey key: String) {
    var colorData: NSData?
    if let color = color {
      do {
        let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: false) as NSData?
        colorData = data
      } catch {
        print("Error UserDefaults")
      }
    }
    set(colorData, forKey: key)
  }
}
