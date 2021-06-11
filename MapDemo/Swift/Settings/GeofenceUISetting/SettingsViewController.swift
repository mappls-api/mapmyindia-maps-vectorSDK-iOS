//
//  SettingsViewController.swift
//  GeofenceUISample
//
//  Created by Apple on 31/07/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import UIKit

public enum SettingType: UInt, CustomStringConvertible, CaseIterable {
    case polygonFillColor
    case polygonStrokeColor
    case circleFillColor
    case circleStrokeColor
    case markerFillColor
    case markerStrokeColor
    case draggingEdgesLineColor
    case polygonDrawingOverlayColor
    
    case geofencePolygonStrokeWidth
    case geofenceCircleStrokeWidth
    
    public var description: String {
        switch self {
        case .polygonFillColor:
            return "Polygon Fill Color"
        case .polygonStrokeColor:
            return "Polygon Stroke Color"
        case .circleFillColor:
            return "Circle Fill Color"
        case .circleStrokeColor:
            return "Circle Stroke Color"
        case .markerFillColor:
            return "Marker Fill Color"
        case .markerStrokeColor:
            return "Marker Stroke Color"
        case .draggingEdgesLineColor:
            return "Drawing Edges Color"
        case .polygonDrawingOverlayColor:
            return "Drawing Overlay Color"
        case .geofencePolygonStrokeWidth:
            return "Polygon Stroke Width"
        case .geofenceCircleStrokeWidth:
            return "Circle Stroke Width"
        }
    }
}

class SettingsViewController: UIViewController {
    
    let tableView = UITableView()
    
    let settings = SettingType.allCases
    
    var selectedSetting: SettingType?
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupTableView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        
        tableView.allowsSelection = false
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        //tableView.register(UITableViewCell.self, forCellReuseIdentifier: "colorPickerCell")
    }
    
    @objc func openColorPickerController() {
        let colorPickerVC = ColorPickerViewController(nibName: nil, bundle: nil)
        colorPickerVC.delegate = self
        colorPickerVC.modalPresentationStyle = .fullScreen
        self.navigationController?.present(colorPickerVC, animated: true, completion: nil)
    }
    
    func getTableViewCell(setting: SettingType, indexPath: IndexPath) -> UITableViewCell {
        var returnCell = UITableViewCell()
        switch setting {
        case .polygonFillColor, .polygonStrokeColor,
             .circleFillColor, .circleStrokeColor,
             .markerFillColor, .markerStrokeColor,
             .draggingEdgesLineColor, .polygonDrawingOverlayColor:
            let cellIdentifier = "colorPickerCell"
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
                if let colorButton = cell.accessoryView, colorButton.isKind(of: UIButton.self) {
                    colorButton.backgroundColor = getColorFromSetting(setting: setting)
                    //switchView.isOn = UserDefaultsManager.isRouteProductionMode
                    colorButton.tag = indexPath.row
                }
                returnCell = cell
            } else {
                let newCell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
                let colorButton = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
                colorButton.backgroundColor = getColorFromSetting(setting: setting)
                colorButton.tag = indexPath.row
                colorButton.addTarget(self, action: #selector(colorButtonPressed(_:)), for: .touchUpInside)
                newCell.accessoryView = colorButton
                returnCell = newCell
            }
        case .geofencePolygonStrokeWidth, .geofenceCircleStrokeWidth:
            let cellIdentifier = "stepperCell"
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
                if let accessoryView = cell.accessoryView, accessoryView.isKind(of: UIStepper.self) {
                    let stepper = accessoryView as! UIStepper
                    stepper.tag = indexPath.row
                    let stepperValue = getValueForStepperFromSetting(setting: setting)
                    stepper.value = stepperValue
                    cell.detailTextLabel?.text = "\(stepperValue)"
                }
                returnCell = cell
            } else {
                let newCell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
                let stepper = createGetStepperForSetting(setting: setting)
                stepper.tag = indexPath.row
                stepper.addTarget(self, action: #selector(stepperChanged(_:)), for: .valueChanged)
                newCell.accessoryView = stepper
                let stepperValue = getValueForStepperFromSetting(setting: setting)
                stepper.value = stepperValue
                newCell.detailTextLabel?.text = "\(stepperValue)"
                returnCell = newCell
            }
            //        case .markerStrokeWidth:
            //            let cellIdentifier = "colorPickerCell"
            //            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            //                if let accessoryView = cell.accessoryView, accessoryView.isKind(of: UISwitch.self) {
            //                    let switchView = accessoryView as! UISwitch
            //                    //switchView.isOn = UserDefaultsManager.isRouteProductionMode
            //                    switchView.tag = indexPath.row
            //                }
            //                returnCell = cell
            //            } else {
            //                let newCell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            //                newCell.textLabel?.text = "Production Mode:"
            //                let switchView = UISwitch(frame: .zero)
            //                //switchView.isOn = UserDefaultsManager.isRouteProductionMode
            //                switchView.tag = indexPath.row // for detect which row switch Changed
            //                switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            //                newCell.accessoryView = switchView
            //                returnCell = newCell
            //            }
        default:
            break
        }
        
        returnCell.textLabel?.text = setting.description
        
        return returnCell
    }
    
    func createGetStepperForSetting(setting: SettingType) -> UIStepper {
        let stepper = UIStepper(frame: .zero)
        stepper.minimumValue = 1
        stepper.maximumValue = 10
        stepper.stepValue = 1
        stepper.value = 1
        
        switch setting {
        default:
            break
        }
        
        return stepper
    }
    
    @objc func stepperChanged(_ sender: UIStepper) {
        let indexRow = sender.tag
        let setting = settings[indexRow]
        switch setting {
        case .geofencePolygonStrokeWidth:
            UserDefaultsManager.geofencePolygonStrokeWidth = sender.value
        case .geofenceCircleStrokeWidth:
            UserDefaultsManager.geofenceCircleStrokeWidth = sender.value
        default:
            break
        }
        
        let indexPath = IndexPath(row: indexRow, section: 0)
        tableView.reloadRows(at: [indexPath], with: .automatic)
    }
    
    @objc func switchChanged(_ sender : UISwitch) {
        //        print("table row switch Changed \(sender.tag)")
        //        print("The switch is \(sender.isOn ? "ON" : "OFF")")
        //        let indexPath = IndexPath(row: sender.tag, section: 0)
        //        let currentType = settings[indexPath.row]
        //        if currentType == .isRouteProductionMode {
        //            UserDefaultsManager.isRouteProductionMode = sender.isOn
        //        }
    }
    
    @objc func colorButtonPressed(_ sender : UIButton) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let setting = settings[indexPath.row]
        selectedSetting = setting
        openColorPickerController()
    }
    
    func getColorFromSetting(setting: SettingType) -> UIColor {
        switch setting {
        case .polygonFillColor:
            return UserDefaultsManager.polygonFillColor
        case .polygonStrokeColor:
            return UserDefaultsManager.polygonStrokeColor
        case .circleFillColor:
            return UserDefaultsManager.circleFillColor
        case .circleStrokeColor:
            return UserDefaultsManager.circleStrokeColor
        case .markerFillColor:
            return UserDefaultsManager.markerFillColor
        case .markerStrokeColor:
            return UserDefaultsManager.markerStrokeColor
        case .draggingEdgesLineColor:
            return UserDefaultsManager.draggingEdgesLineColor
        case .polygonDrawingOverlayColor:
            return UserDefaultsManager.polygonDrawingOverlayColor
        default:
            break
        }
        
        return .white
    }
    
    func getValueForStepperFromSetting(setting: SettingType) -> Double {
        switch setting {
        case .geofencePolygonStrokeWidth:
            return UserDefaultsManager.geofencePolygonStrokeWidth
        case .geofenceCircleStrokeWidth:
            return UserDefaultsManager.geofenceCircleStrokeWidth
        default:
            return 1
        }
    }
}

extension SettingsViewController: ColorPickerViewControllerDelegate {
    func didPickedColor(color: UIColor) {
        if let setting = selectedSetting {
            switch setting {
            case .polygonFillColor:
                UserDefaultsManager.polygonFillColor = color
            case .polygonStrokeColor:
                UserDefaultsManager.polygonStrokeColor = color
            case .circleFillColor:
                UserDefaultsManager.circleFillColor = color
            case .circleStrokeColor:
                UserDefaultsManager.circleStrokeColor = color
            case .markerFillColor:
                UserDefaultsManager.markerFillColor = color
            case .markerStrokeColor:
                UserDefaultsManager.markerStrokeColor = color
            case .draggingEdgesLineColor:
                UserDefaultsManager.draggingEdgesLineColor = color
            case .polygonDrawingOverlayColor:
                UserDefaultsManager.polygonDrawingOverlayColor = color
            default:
                break
            }
            
            if let indexRow = settings.firstIndex(of: setting) {
                let indexPath = IndexPath(row: indexRow, section: 0)
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        selectedSetting = nil
    }
    
    func didCancelColorPicker() {
        selectedSetting = nil
    }
}

extension SettingsViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return settings.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let settingsType = settings[indexPath.row]
        return getTableViewCell(setting: settingsType, indexPath: indexPath)
    }
}


