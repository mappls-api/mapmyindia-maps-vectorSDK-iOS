//
//  MapDemoSettingsVC.swift
//  MapDemo
//
//  Created by Apple on 06/08/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit

class MapDemoSettingsVC: UITableViewController {
    
    let placePickerSettings = PlacePickerSettingType.allCases
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @objc func switchChanged(_ sender : UISwitch) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let currentType = placePickerSettings[indexPath.row]
        
        if currentType == .isCustomMarkerView {
            UserDefaultsManager.isCustomMarkerView = sender.isOn
        } else if currentType == .isMarkerShadowViewHidden {
            UserDefaultsManager.isMarkerShadowViewHidden = sender.isOn
        } else if currentType == .isCustomSearchButtonBackgroundColor {
            UserDefaultsManager.isCustomSearchButtonBackgroundColor = sender.isOn
        } else if currentType == .isCustomSearchButtonImage {
            UserDefaultsManager.isCustomSearchButtonImage = sender.isOn
        } else if currentType == .isSearchButtonHidden {
            UserDefaultsManager.isSearchButtonHidden = sender.isOn
        } else if currentType == .isCustomPlaceNameTextColor {
            UserDefaultsManager.isCustomPlaceNameTextColor = sender.isOn
        } else if currentType == .isCustomAddressTextColor {
            UserDefaultsManager.isCustomAddressTextColor = sender.isOn
        } else if currentType == .isCustomPickerButtonTitleColor {
            UserDefaultsManager.isCustomPickerButtonTitleColor = sender.isOn
        } else if currentType == .isCustomPickerButtonBackgroundColor {
            UserDefaultsManager.isCustomPickerButtonBackgroundColor = sender.isOn
        } else if currentType == .isCustomPickerButtonTitle {
            UserDefaultsManager.isCustomPickerButtonTitle = sender.isOn
        } else if currentType == .isCustomInfoLabelTextColor {
            UserDefaultsManager.isCustomInfoLabelTextColor = sender.isOn
        } else if currentType == .isCustomInfoBottomViewBackgroundColor {
            UserDefaultsManager.isCustomInfoBottomViewBackgroundColor = sender.isOn
        } else if currentType == .isCustomPlaceDetailsViewBackgroundColor {
            UserDefaultsManager.isCustomPlaceDetailsViewBackgroundColor = sender.isOn
        } else if currentType == .isInitializeWithCustomLocation {
            UserDefaultsManager.isInitializeWithCustomLocation = sender.isOn
        } else if currentType == .isBottomInfoViewHidden {
            UserDefaultsManager.isBottomInfoViewHidden = sender.isOn
        } else if currentType == .isBottomPlaceDetailViewHidden {
            UserDefaultsManager.isBottomPlaceDetailViewHidden = sender.isOn
        }
    }
    
    func getValueForPlacePickerSetting(_ placePickerSetting : PlacePickerSettingType) -> Bool {
        switch placePickerSetting {
        case .isCustomMarkerView:
            return UserDefaultsManager.isCustomMarkerView
        case .isMarkerShadowViewHidden:
            return UserDefaultsManager.isMarkerShadowViewHidden
        case .isCustomSearchButtonBackgroundColor:
            return UserDefaultsManager.isCustomSearchButtonBackgroundColor
        case .isCustomSearchButtonImage:
            return UserDefaultsManager.isCustomSearchButtonImage
        case .isSearchButtonHidden:
            return UserDefaultsManager.isSearchButtonHidden
        case .isCustomPlaceNameTextColor:
            return UserDefaultsManager.isCustomPlaceNameTextColor
        case .isCustomAddressTextColor:
            return UserDefaultsManager.isCustomAddressTextColor
        case .isCustomPickerButtonTitleColor:
            return UserDefaultsManager.isCustomPickerButtonTitleColor
        case .isCustomPickerButtonBackgroundColor:
            return UserDefaultsManager.isCustomPickerButtonBackgroundColor
        case .isCustomPickerButtonTitle:
            return UserDefaultsManager.isCustomPickerButtonTitle
        case .isCustomInfoLabelTextColor:
            return UserDefaultsManager.isCustomInfoLabelTextColor
        case .isCustomInfoBottomViewBackgroundColor:
            return UserDefaultsManager.isCustomInfoBottomViewBackgroundColor
        case .isCustomPlaceDetailsViewBackgroundColor:
            return UserDefaultsManager.isCustomPlaceDetailsViewBackgroundColor
        case .isInitializeWithCustomLocation:
            return UserDefaultsManager.isInitializeWithCustomLocation
        case .isBottomInfoViewHidden:
            return UserDefaultsManager.isBottomInfoViewHidden
        case .isBottomPlaceDetailViewHidden:
            return UserDefaultsManager.isBottomPlaceDetailViewHidden
        }
    }
}

//MARK:- Table View Controller Methods
extension MapDemoSettingsVC {
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return placePickerSettings.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Place Picker"
        }
        return nil
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentType = placePickerSettings[indexPath.row]
        
        let cellIdentifier = "switchCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            if let accessoryView = cell.accessoryView, accessoryView.isKind(of: UISwitch.self) {
                let switchView = accessoryView as! UISwitch
                switchView.isOn = getValueForPlacePickerSetting(currentType)
                switchView.tag = indexPath.row
            }
            return cell
        } else {
            let newCell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            newCell.textLabel?.text = currentType.description
            let switchView = UISwitch(frame: .zero)
            switchView.isOn = getValueForPlacePickerSetting(currentType)
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            newCell.accessoryView = switchView
            return newCell
        }
    }
}

public enum PlacePickerSettingType: UInt, CustomStringConvertible, CaseIterable {
    case isCustomMarkerView
    case isMarkerShadowViewHidden
    case isCustomSearchButtonBackgroundColor
    case isCustomSearchButtonImage
    case isSearchButtonHidden
    case isCustomPlaceNameTextColor
    case isCustomAddressTextColor
    case isCustomPickerButtonTitleColor
    case isCustomPickerButtonBackgroundColor
    case isCustomPickerButtonTitle
    case isCustomInfoLabelTextColor
    case isCustomInfoBottomViewBackgroundColor
    case isCustomPlaceDetailsViewBackgroundColor
    case isInitializeWithCustomLocation
    case isBottomInfoViewHidden
    case isBottomPlaceDetailViewHidden
    
    public var description: String {
        switch self {
        case .isCustomMarkerView:
            return "Custom Marker"
        case .isMarkerShadowViewHidden:
            return "Marker Shadow Hidden"
        case .isCustomSearchButtonBackgroundColor:
            return "Search Button Custom Back Color"
        case .isCustomSearchButtonImage:
            return "Search Button Custom Image"
        case .isSearchButtonHidden:
            return "Search Button Hidden"
        case .isCustomPlaceNameTextColor:
            return "Place Name Custom Text Color"
        case .isCustomAddressTextColor:
            return "Address Custom Text Color"
        case .isCustomPickerButtonTitleColor:
            return "Picker Button Custom Title Color"
        case .isCustomPickerButtonBackgroundColor:
            return "Picker Button Custom Back Color"
        case .isCustomPickerButtonTitle:
            return "Picker Button Custom Title"
        case .isCustomInfoLabelTextColor:
            return "Info Label Custom Text Color"
        case .isCustomInfoBottomViewBackgroundColor:
            return "Info View Custom Back Color"
        case .isCustomPlaceDetailsViewBackgroundColor:
            return "Place Detail View Custom Back Color"
        case .isInitializeWithCustomLocation:
            return "Custom Initial Location"
        case .isBottomInfoViewHidden:
            return "Info View Hidden"
        case .isBottomPlaceDetailViewHidden:
            return "Place Details View Hidden"
        }
    }
}

//public enum MapDemoSettingType: UInt, CustomStringConvertible, CaseIterable {
//
//}
