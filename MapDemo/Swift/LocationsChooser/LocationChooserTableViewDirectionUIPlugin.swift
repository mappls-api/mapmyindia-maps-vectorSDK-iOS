//
//  LocationChooserTableViewDirectionUIPlugin.swift
//  MapDemo
//
//  Created by CEINFO on 18/01/21.
//  Copyright © 2021 MMI. All rights reserved.
//
import UIKit
import MapmyIndiaAPIKit
import MapmyIndiaUIWidgets
import MapmyIndiaDirections
import MapmyIndiaDirectionsUI


protocol LocationChooserTableViewDirectionUIPluginDelegate {
    func locationsPikcedForDistancesUI(sourceLocations: [String], destinationLocations: [String], resource: MapmyIndiaDistanceMatrixResourceIdentifier, profile: MapmyIndiaDirectionsProfileIdentifier)
    
    func locationsPikcedForDirectionsUI(sourceLocation: MapmyIndiaDirectionsLocation, destinationLocation: MapmyIndiaDirectionsLocation, viaLocations: [MapmyIndiaDirectionsLocation], resource: MBDirectionsResourceIdentifier, profile: MBDirectionsProfileIdentifier, attributions: MBAttributeOptions)
}

class LocationChooserTableViewDirectionUIPlugin: UITableViewController {
    var delegate: LocationChooserTableViewDirectionUIPluginDelegate?
    
    let sectionForAutocompleteSwitch = 0
    let sectionForResourceChooser = 1
    let sectionForProfileChooser = 2
    let sectionForAttributions = 3
    let sectionForSourceLocations = 4
    let sectionForDestinationLocations = 5
    let sectionForViaLocations = 6
    

    var shouldOpenAutocomplete: Bool = true
    var sourceLocations = [MapmyIndiaDirectionsLocation]()
    var destinationLocations = [MapmyIndiaDirectionsLocation]()
    var viaLocations = [MapmyIndiaDirectionsLocation]()
    var attributions = [String]()
    var dirAttributions : MBAttributeOptions = []
    var indexPathForSourceOrDesitnation: IndexPath?
    
    var selectedResourceDistance: MapmyIndiaDistanceMatrixResourceIdentifier = .default
    var selectedProfileDistance: MapmyIndiaDirectionsProfileIdentifier = .driving
    
    var selectedResourceDirection: MBDirectionsResourceIdentifier = .routeAdv
    var selectedProfileDirection: MBDirectionsProfileIdentifier = .driving
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Direction Location Chooser"
        self.tableView.separatorStyle = .none
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonClicked))
        sourceLocations = [MapmyIndiaDirectionsLocation(location: "", displayName: "", displayAddress: "", locationType: .none)]
        destinationLocations = [MapmyIndiaDirectionsLocation(location: "", displayName: "", displayAddress: "", locationType: .none)]
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @objc func doneButtonClicked() {
        print()
        if viaLocations.last?.location ?? "" == "" && viaLocations.count > 0 {
            viaLocations.remove(at: viaLocations.count - 1)
        }
        if self.sourceLocations.first?.location != "" && self.destinationLocations.first?.location != "" {
            delegate?.locationsPikcedForDirectionsUI(sourceLocation: self.sourceLocations.first!, destinationLocation: self.destinationLocations.first!, viaLocations: viaLocations, resource: selectedResourceDirection, profile: selectedProfileDirection, attributions: dirAttributions)
        } else {
            emptyFieldError()
        }
    }
    
    func emptyFieldError(){
        let alert = UIAlertController(title: "Empty Field!", message: "Please fill empty fields first.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismiss(){
        if let navVC = self.navigationController {
            navVC.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func switchChanged(_ sender : UISwitch) {
        shouldOpenAutocomplete = sender.isOn
        tableView.reloadData()
    }
    
    @objc func getTitleForDetailTextCell(indexPath: IndexPath) -> String {
        switch indexPath.section {
        case sectionForResourceChooser:
            return "Resource"
        case sectionForProfileChooser:
            return "Profile"
        default:
            return ""
        }
    }
    
    @objc func getDetailsForDetailTextCell(indexPath: IndexPath) -> String {
        switch indexPath.section {
        case sectionForResourceChooser:
            switch selectedResourceDirection {
            case .routeAdv:
                return "default"
            case .routeETA:
                return "eta"
            case .routeTraffic:
                return "traffic"
            default:
                return ""
            }
            
        case sectionForProfileChooser:
            switch selectedProfileDirection {
            case .driving:
                return "driving"
            case .walking:
                return "walking"
            case .biking:
                return "biking"
            case .trucking:
                return "trucking"
            default:
                return ""
            }
        default:
            return ""
        }
    }
    
    @objc func getValueForSource(row: Int) -> String {
        return sourceLocations[row].displayName ?? "None"
    }
    
    @objc func getValueForDestination(row: Int) -> String {
        return destinationLocations[row].displayName ?? ""
    }
    
    @objc func getValueForVia(row: Int) -> String {
        return viaLocations[row].displayName ?? ""
    }
    
    @objc func sourceValueChanged(_ textField: UITextField) {
//        let row = textField.tag
//        sourceLocations[row] = textField.text ?? ""
    }
    
    @objc func destinationValueChanged(_ textField: UITextField) {
//        let row = textField.tag
//        destinationLocations[row] = textField.text ?? ""
    }
    
    @objc func viaValueChanged(_ textField: UITextField) {
//        let row = textField.tag
//        viaLocations[row] = textField.text ?? ""
    }
    
    @objc func sourceLocationButtonPressed(_ button: UIButton) {
        let row = button.tag
        indexPathForSourceOrDesitnation = IndexPath(row: row, section: sectionForSourceLocations)
        openAutocompleteController()
    }
    
    @objc func destinationLocationButtonPressed(_ button: UIButton) {
        let row = button.tag
        indexPathForSourceOrDesitnation = IndexPath(row: row, section: sectionForDestinationLocations)
        openAutocompleteController()
    }
    
    @objc func viaLocationButtonPressed(_ button: UIButton) {
        let row = button.tag
        indexPathForSourceOrDesitnation = IndexPath(row: row, section: sectionForViaLocations)
        openAutocompleteController()
    }
    
    @objc func openAutocompleteController() {
        let autoCompleteVC = MapmyIndiaAutocompleteViewController()
        autoCompleteVC.delegate = self
        present(autoCompleteVC, animated: true, completion: nil)
    }
    
    @objc func addLocationButtonPressed(_ button: UIButton) {
        let section = button.tag
        let emptySourceFields = sourceLocations.filter { (location) -> Bool in
            let newLocation = location.location!.trimmingCharacters(in: .whitespacesAndNewlines)
            return newLocation.isEmpty
        }
        let emptyDestinationFields = destinationLocations.filter { (location) -> Bool in
            let newLocation = location.location!.trimmingCharacters(in: .whitespacesAndNewlines)
            return newLocation.isEmpty
        }
        let emptyViaFields = viaLocations.filter { (location) -> Bool in
            let newLocation = location.location!.trimmingCharacters(in: .whitespacesAndNewlines)
            return newLocation.isEmpty
        }
        if emptySourceFields.count > 0 || emptyDestinationFields.count > 0
            || emptyViaFields.count > 0 {
            let alert = UIAlertController(title: "Empty Field!", message: "Please fill empty fields first.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            switch section {
            case sectionForSourceLocations:
                if sourceLocations.count >= 1 {
                    break
                }
                sourceLocations.append(MapmyIndiaDirectionsLocation(location: "", displayName: "", displayAddress: "", locationType: .none))
                self.tableView.reloadData()
            case sectionForDestinationLocations:
                if destinationLocations.count >= 1 {
                    break
                }
                destinationLocations.append(MapmyIndiaDirectionsLocation(location: "", displayName: "", displayAddress: "", locationType: .none))
                self.tableView.reloadData()
            case sectionForViaLocations:
                viaLocations.append(MapmyIndiaDirectionsLocation(location: "", displayName: "", displayAddress: "", locationType: .none))
                self.tableView.reloadData()
            default:
                break
            }
        }
    }
    
    @objc func openActionSheetToChooseLocationType(selectedPlace: MapmyIndiaAtlasSuggestion) {
        let alterView = UIAlertController(title: "Select eLoc or Coordinate", message: "Please select eLoc or coordinate.", preferredStyle: .actionSheet)
        alterView.addAction(UIAlertAction(title: "Coordinate", style: .default, handler: { [self] (handler) in
            setCoordinateValueForSourceOrDestinationLocationField(selectedPlace: selectedPlace)
        }))
        alterView.addAction(UIAlertAction(title: "eLoc", style: .default, handler: { [self] (handler) in
            setElocValueForSourceOrDestinationLocationField(selectedPlace: selectedPlace)
        }))
        alterView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (handler) in
        }))
        present(alterView, animated: true, completion: nil)
    }
    
    
    @objc func setCoordinateValueForSourceOrDestinationLocationField(selectedPlace: MapmyIndiaAtlasSuggestion) {
        if let indexPath = indexPathForSourceOrDesitnation {
            if let latitude = selectedPlace.latitude, let longitude = selectedPlace.longitude {
                if indexPath.section == sectionForSourceLocations {
                    sourceLocations[indexPath.row] = MapmyIndiaDirectionsLocation(location: "\(longitude),\(latitude)", displayName: selectedPlace.placeName, displayAddress: selectedPlace.placeAddress, locationType: .suggestion)
//                        "\(longitude),\(latitude)"
                } else if indexPath.section == sectionForDestinationLocations {
                    destinationLocations[indexPath.row] = MapmyIndiaDirectionsLocation(location: "\(longitude),\(latitude)", displayName: selectedPlace.placeName, displayAddress: selectedPlace.placeAddress, locationType: .suggestion)
                } else if indexPath.section == sectionForViaLocations {
                    viaLocations[indexPath.row] = MapmyIndiaDirectionsLocation(location: "\(longitude),\(latitude)", displayName: selectedPlace.placeName, displayAddress: selectedPlace.placeAddress, locationType: .suggestion)
                }
                tableView.reloadData()
            }
        }
    }
    
    @objc func setElocValueForSourceOrDestinationLocationField(selectedPlace: MapmyIndiaAtlasSuggestion) {
        if let indexPath = indexPathForSourceOrDesitnation {
            if let eLoc = selectedPlace.eLoc {
                if indexPath.section == sectionForSourceLocations {
                    sourceLocations[indexPath.row] = MapmyIndiaDirectionsLocation(location: eLoc, displayName: selectedPlace.placeName, displayAddress: selectedPlace.placeAddress, locationType: .suggestion)
                } else if indexPath.section == sectionForDestinationLocations {
                    destinationLocations[indexPath.row] = MapmyIndiaDirectionsLocation(location: eLoc, displayName: selectedPlace.placeName, displayAddress: selectedPlace.placeAddress, locationType: .suggestion)
                } else if indexPath.section == sectionForViaLocations {
                    viaLocations[indexPath.row] = MapmyIndiaDirectionsLocation(location: eLoc, displayName: selectedPlace.placeName, displayAddress: selectedPlace.placeAddress, locationType: .suggestion)
                }
                tableView.reloadData()
            }
        }
    }
    
    @objc func openActionSheetToChooseResource() {
        let alterView = UIAlertController(title: "Select eLoc or Coordinate", message: "Please select eLoc or coordinate.", preferredStyle: .actionSheet)
        alterView.addAction(UIAlertAction(title: "default", style: .default, handler: { [self] (handler) in
      
                selectedResourceDirection = .routeAdv
            
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "eta", style: .default, handler: { [self] (handler) in
     
                selectedResourceDirection = .routeETA
            
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "traffic", style: .default, handler: { [self] (handler) in

                selectedResourceDirection = .routeTraffic
            
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (handler) in
        }))
        present(alterView, animated: true, completion: nil)
    }
    
    @objc func openActionSheetToChooseProfile() {
        let alterView = UIAlertController(title: "Select eLoc or Coordinate", message: "Please select eLoc or coordinate.", preferredStyle: .actionSheet)
        alterView.addAction(UIAlertAction(title: "driving", style: .default, handler: { [self] (handler) in

                selectedProfileDirection = .driving
            
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "walking", style: .default, handler: { [self] (handler) in
  
                selectedProfileDirection = .walking
            
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "biking", style: .default, handler: { [self] (handler) in

                selectedProfileDirection = .biking
            
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "trucking", style: .default, handler: { [self] (handler) in

                selectedProfileDirection = .trucking
            
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (handler) in
        }))
        present(alterView, animated: true, completion: nil)
    }
    
    @objc func openAttributionSetting(){
        let attributionVC = AttributionSettingTableViewController()
        self.navigationController?.pushViewController(attributionVC, animated: false)
    }
    
    @objc func makeAttributionArray() {
        dirAttributions = []
        print(UserDefaultsManager.isSpeed)
        print(UserDefaultsManager.isDistance)
        print(UserDefaultsManager.isCongestionLevel)
        print(UserDefaultsManager.isExpectedTravelTime)
        if UserDefaultsManager.isSpeed {
            dirAttributions.insert(.speed)
        }
        if UserDefaultsManager.isDistance {
            dirAttributions.insert(.distance)
        }
        if UserDefaultsManager.isCongestionLevel {
            dirAttributions.insert(.congestionLevel)
        }
        if UserDefaultsManager.isExpectedTravelTime {
            dirAttributions.insert(.expectedTravelTime)
        }
    }
}

extension LocationChooserTableViewDirectionUIPlugin {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
            return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case sectionForAutocompleteSwitch:
            return 0
        case sectionForResourceChooser:
            return 1
        case sectionForProfileChooser:
            return 1
        case sectionForSourceLocations:
            return sourceLocations.count
        case sectionForDestinationLocations:
            return destinationLocations.count
        case sectionForViaLocations:
            return viaLocations.count
        case sectionForAttributions:
            return 1
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell!
        let section = indexPath.section
        self.makeAttributionArray()
        switch section {
        case sectionForAutocompleteSwitch:
            let cellIdentifier = "switchCell"
            var switchView: UISwitch!
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
                tableCell = cell
                if let accessoryView = tableCell.accessoryView, accessoryView.isKind(of: UISwitch.self) {
                    switchView = accessoryView as? UISwitch
                }
            } else {
                tableCell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
                switchView = UISwitch(frame: .zero)
                switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
                tableCell.accessoryView = switchView
            }
            tableCell.textLabel?.text = "Autocomplete Widget"
            switchView.isOn = shouldOpenAutocomplete
        case sectionForResourceChooser, sectionForProfileChooser:
            let cellIdentifier = "detailTextCell"
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
                tableCell = cell
            } else {
                tableCell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
                tableCell.accessoryType = .disclosureIndicator
            }
            tableCell.textLabel?.text = getTitleForDetailTextCell(indexPath: indexPath)
            tableCell.detailTextLabel?.text = getDetailsForDetailTextCell(indexPath: indexPath)
        case sectionForSourceLocations, sectionForDestinationLocations, sectionForViaLocations:
            let cellIdentifier = "locationChooserCell"
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? LocationChooserTableViewCell {
                tableCell = cell
            } else {
                tableCell = LocationChooserTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
                if let locationCell = tableCell as? LocationChooserTableViewCell {
                    locationCell.sourceLocationTextField.addTarget(self, action: #selector(sourceValueChanged), for: .editingChanged)
                    locationCell.destinationLocationTextField.addTarget(self, action: #selector(destinationValueChanged), for: .editingChanged)
                    locationCell.viaLocationTextField.addTarget(self, action: #selector(viaValueChanged), for: .editingChanged)
                    locationCell.sourceAutocompleteWidgetButton.addTarget(self, action: #selector(sourceLocationButtonPressed), for: .touchUpInside)
                    locationCell.destinationAutocompleteWidgetButton.addTarget(self, action: #selector(destinationLocationButtonPressed), for: .touchUpInside)
                    locationCell.viaAutocompleteWidgetButton.addTarget(self, action: #selector(viaLocationButtonPressed), for: .touchUpInside)
                }
            }
            if let locationCell = tableCell as? LocationChooserTableViewCell {
                locationCell.sourceLocationTextField.tag = indexPath.row
                locationCell.sourceLocationTextField.text = (section == sectionForSourceLocations) ? getValueForSource(row: indexPath.row) : ""
                locationCell.sourceLocationTextField.isHidden = (section == sectionForSourceLocations) ? false : true
                
                locationCell.destinationLocationTextField.tag = indexPath.row
                locationCell.destinationLocationTextField.text = (section == sectionForDestinationLocations) ? getValueForDestination(row: indexPath.row) : ""
                locationCell.destinationLocationTextField.isHidden = (section == sectionForDestinationLocations) ? false : true
                
                locationCell.viaLocationTextField.tag = indexPath.row
                locationCell.viaLocationTextField.text = (section == sectionForViaLocations) ? getValueForVia(row: indexPath.row) : ""
                locationCell.viaLocationTextField.isHidden = (section == sectionForViaLocations) ? false : true
                
                locationCell.sourceAutocompleteWidgetButton.tag = indexPath.row
                locationCell.sourceAutocompleteWidgetButton.isHidden = (shouldOpenAutocomplete && section == sectionForSourceLocations) ? false : true
                
                locationCell.destinationAutocompleteWidgetButton.tag = indexPath.row
                locationCell.destinationAutocompleteWidgetButton.isHidden = (shouldOpenAutocomplete && section == sectionForDestinationLocations) ? false : true
                
                locationCell.viaAutocompleteWidgetButton.tag = indexPath.row
                locationCell.viaAutocompleteWidgetButton.isHidden = (shouldOpenAutocomplete && section == sectionForViaLocations) ? false : true
            }
            
        case sectionForAttributions:
            let cellIdentifier = "attributionCell"
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
                tableCell = cell
            }else {
                tableCell = UITableViewCell(style: .subtitle, reuseIdentifier: cellIdentifier)
                tableCell.accessoryType = .disclosureIndicator
            }
            tableCell.textLabel?.text = "Attributions"
            tableCell.detailTextLabel?.text = "\(dirAttributions)"
            
        default:
            tableCell = UITableViewCell()
        }
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == sectionForSourceLocations
            || section == sectionForDestinationLocations
            || section == sectionForViaLocations {
            let viewHeader = UIView()
            viewHeader.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            
            let addButton = UIButton()
            addButton.translatesAutoresizingMaskIntoConstraints = false
            addButton.backgroundColor = UIColor.white.withAlphaComponent(0.5)
            addButton.contentEdgeInsets = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
            addButton.layer.cornerRadius = 15
            addButton.layer.borderWidth = 1
            addButton.layer.borderColor = UIColor.white.cgColor
            addButton.setImage(UIImage(named: "plus.png"), for: .normal)
            addButton.imageView?.contentMode = .scaleAspectFit
            addButton.tag = section
            addButton.addTarget(self, action: #selector(addLocationButtonPressed), for: .touchUpInside)
            viewHeader.addSubview(addButton)
            
            let textLabel = UILabel()
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            textLabel.textColor = .white
            textLabel.font = UIFont.boldSystemFont(ofSize: 20)
            if section == sectionForSourceLocations {
                textLabel.text = "Source Locations"
            } else if section == sectionForDestinationLocations {
                textLabel.text = "Destination Locations"
            } else if section == sectionForViaLocations {
                textLabel.text = "Via Locations"
            }
            viewHeader.addSubview(textLabel)
            
            addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor).isActive = true
            addButton.trailingAnchor.constraint(equalTo: viewHeader.trailingAnchor, constant: -8).isActive = true
            addButton.centerYAnchor.constraint(equalTo: viewHeader.centerYAnchor, constant: 0).isActive = true
            
            textLabel.leftAnchor.constraint(equalTo: viewHeader.leftAnchor, constant: 8).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8).isActive = true
            textLabel.centerYAnchor.constraint(equalTo: viewHeader.centerYAnchor, constant: 0).isActive = true
            if ((section == sectionForSourceLocations || section == sectionForDestinationLocations)) {
                addButton.isHidden = true
            }
            
            return viewHeader
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case sectionForResourceChooser:
            openActionSheetToChooseResource()
        case sectionForProfileChooser:
            openActionSheetToChooseProfile()
        case sectionForAttributions:
            openAttributionSetting()
        default:
            break
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == sectionForSourceLocations
            || section == sectionForDestinationLocations
            || section == sectionForViaLocations {
            return 40
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == sectionForViaLocations{
            return true
        }else {
            return false
        }
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
          if indexPath.section == sectionForViaLocations {
                viaLocations.remove(at: indexPath.row)
                tableView.reloadData()
          }
        }
    }
}
extension LocationChooserTableViewDirectionUIPlugin: MapmyIndiaAutocompleteViewControllerDelegate {
    func didAutocomplete(viewController: MapmyIndiaAutocompleteViewController, withPlace place: MapmyIndiaAtlasSuggestion) {
        self.dismiss(animated: false) {
            if let _ = place.latitude, let _ = place.longitude {
                self.openActionSheetToChooseLocationType(selectedPlace: place)
            } else {
                self.setElocValueForSourceOrDestinationLocationField(selectedPlace: place)
            }
        }
    }
    
    func didFailAutocomplete(viewController: MapmyIndiaAutocompleteViewController, withError error: NSError) {
        
    }
    
    func wasCancelled(viewController: MapmyIndiaAutocompleteViewController) {
        
    }
    func didAutocomplete(viewController: MapmyIndiaAutocompleteViewController, withSuggestion suggestion: MapmyIndiaSearchPrediction) {
        
    }
}
