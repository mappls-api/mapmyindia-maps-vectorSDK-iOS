//
//  UserDefaultsManager.swift
//  MapDemo
//
//  Created by Apple on 06/08/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import Foundation
import MapmyIndiaUIWidgets

class UserDefaultsManager {
    static func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
    
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
    
    
    
//    static var attributionLength: MapmyIndiaContentLength = .long
    
//    static var attributionSize: MapmyIndiaContentSize = .medium
     
//    static var attributionVerticalPlacement : MapmyIndiaVerticalPlacement = .before
    
   
}
