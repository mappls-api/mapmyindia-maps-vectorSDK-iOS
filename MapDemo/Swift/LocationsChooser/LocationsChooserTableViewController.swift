import UIKit
import MapmyIndiaAPIKit
import MapmyIndiaUIWidgets
import MapmyIndiaDirections

enum LocationsChooserMode: Int {
    case distance = 0
    case direction = 1
}

protocol LocationsChooserTableViewControllerDelegate {
    func locationsPikcedForDistances(sourceLocations: [String], destinationLocations: [String], resource: MapmyIndiaDistanceMatrixResourceIdentifier, profile: MapmyIndiaDirectionsProfileIdentifier)
    
    func locationsPikcedForDirections(sourceLocation: String, destinationLocation: String, viaLocations: [String], resource: MBDirectionsResourceIdentifier, profile: MBDirectionsProfileIdentifier)
}

class LocationsChooserTableViewController: UITableViewController {
    public var mode: LocationsChooserMode = .distance
    var delegate: LocationsChooserTableViewControllerDelegate?
    
    let sectionForAutocompleteSwitch = 0
    let sectionForResourceChooser = 1
    let sectionForProfileChooser = 2
    let sectionForSourceLocations = 3
    let sectionForDestinationLocations = 4
    let sectionForViaLocations = 5

    var shouldOpenAutocomplete: Bool = true
    var sourceLocations = [String]()
    var destinationLocations = [String]()
    var viaLocations = [String]()
    var indexPathForSourceOrDesitnation: IndexPath?
    
    var selectedResourceDistance: MapmyIndiaDistanceMatrixResourceIdentifier = .default
    var selectedProfileDistance: MapmyIndiaDirectionsProfileIdentifier = .driving
    
    var selectedResourceDirection: MBDirectionsResourceIdentifier = .routeAdv
    var selectedProfileDirection: MBDirectionsProfileIdentifier = .driving
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Location Chooser"
        self.tableView.separatorStyle = .none
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonClicked))
        
        if mode == .direction {
            sourceLocations = [""]
            destinationLocations = [""]
        }
    }
    
    @objc func doneButtonClicked() {
        if mode == .distance {
            print(sourceLocations.count)
            if sourceLocations.count > 0 && destinationLocations.count > 0 {
                delegate?.locationsPikcedForDistances(sourceLocations: self.sourceLocations, destinationLocations: self.destinationLocations, resource: selectedResourceDistance, profile: selectedProfileDistance)
                dismiss()
            } else {
                emptyFieldError()
            }
            
        } else if mode == .direction {
            if self.sourceLocations.first != "" && self.destinationLocations.first != "" {
                delegate?.locationsPikcedForDirections(sourceLocation: self.sourceLocations.first!, destinationLocation: self.destinationLocations.first!, viaLocations: viaLocations, resource: selectedResourceDirection, profile: selectedProfileDirection)
                self.dismiss()
            } else {
                emptyFieldError()
            }
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
            if mode == .distance {
                switch selectedResourceDistance {
                case .default:
                    return "default"
                case .eta:
                    return "eta"
                case .traffic:
                    return "traffic"
                default:
                    return ""
                }
            } else if mode == .direction {
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
            }
        case sectionForProfileChooser:
            if mode == .distance {
                switch selectedProfileDistance {
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
            } else if mode == .direction {
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
            }
        default:
            return ""
        }
        return ""
    }
    /*
    @objc func getValueForLocationCell(indexPath: IndexPath) -> String {
        switch indexPath.section {
        case 3:
            let sourceLocation = sourceLocations[indexPath.row]
            return sourceLocation
        case 4:
            let destinationLocation = destinationLocations[indexPath.row]
            return destinationLocation
        default:
            return ""
        }
    }
    */
    
    @objc func getValueForSource(row: Int) -> String {
        return sourceLocations[row]
    }
    
    @objc func getValueForDestination(row: Int) -> String {
        return destinationLocations[row]
    }
    
    @objc func getValueForVia(row: Int) -> String {
        return viaLocations[row]
    }
    
    @objc func sourceValueChanged(_ textField: UITextField) {
        let row = textField.tag
        sourceLocations[row] = textField.text ?? ""
    }
    
    @objc func destinationValueChanged(_ textField: UITextField) {
        let row = textField.tag
        destinationLocations[row] = textField.text ?? ""
    }
    
    @objc func viaValueChanged(_ textField: UITextField) {
        let row = textField.tag
        viaLocations[row] = textField.text ?? ""
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
            let newLocation = location.trimmingCharacters(in: .whitespacesAndNewlines)
            return newLocation.isEmpty
        }
        let emptyDestinationFields = destinationLocations.filter { (location) -> Bool in
            let newLocation = location.trimmingCharacters(in: .whitespacesAndNewlines)
            return newLocation.isEmpty
        }
        let emptyViaFields = viaLocations.filter { (location) -> Bool in
            let newLocation = location.trimmingCharacters(in: .whitespacesAndNewlines)
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
                if mode == .direction && sourceLocations.count >= 1 {
                    break
                }
                sourceLocations.append("")
                self.tableView.reloadData()
            case sectionForDestinationLocations:
                if mode == .direction && destinationLocations.count >= 1 {
                    break
                }
                destinationLocations.append("")
                self.tableView.reloadData()
            case sectionForViaLocations:
                viaLocations.append("")
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
                    sourceLocations[indexPath.row] = "\(longitude),\(latitude)"
                } else if indexPath.section == sectionForDestinationLocations {
                    destinationLocations[indexPath.row] = "\(longitude),\(latitude)"
                } else if indexPath.section == sectionForViaLocations {
                    viaLocations[indexPath.row] = "\(longitude),\(latitude)"
                }
                tableView.reloadData()
            }
        }
    }
    
    @objc func setElocValueForSourceOrDestinationLocationField(selectedPlace: MapmyIndiaAtlasSuggestion) {
        if let indexPath = indexPathForSourceOrDesitnation {
            if let eLoc = selectedPlace.eLoc {
                if indexPath.section == sectionForSourceLocations {
                    sourceLocations[indexPath.row] = eLoc
                } else if indexPath.section == sectionForDestinationLocations {
                    destinationLocations[indexPath.row] = eLoc
                } else if indexPath.section == sectionForViaLocations {
                    viaLocations[indexPath.row] = eLoc
                }
                tableView.reloadData()
            }
        }
    }
    
    @objc func openActionSheetToChooseResource() {
        let alterView = UIAlertController(title: "Select eLoc or Coordinate", message: "Please select eLoc or coordinate.", preferredStyle: .actionSheet)
        alterView.addAction(UIAlertAction(title: "default", style: .default, handler: { [self] (handler) in
            if mode == .distance {
                selectedResourceDistance = .default
            } else if mode == .direction {
                selectedResourceDirection = .routeAdv
            }
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "eta", style: .default, handler: { [self] (handler) in
            if mode == .distance {
                selectedResourceDistance = .eta
            } else if mode == .direction {
                selectedResourceDirection = .routeETA
            }
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "traffic", style: .default, handler: { [self] (handler) in
            if mode == .distance {
                selectedResourceDistance = .traffic
            } else if mode == .distance {
                selectedResourceDirection = .routeTraffic
            }
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (handler) in
        }))
        present(alterView, animated: true, completion: nil)
    }
    
    @objc func openActionSheetToChooseProfile() {
        let alterView = UIAlertController(title: "Select eLoc or Coordinate", message: "Please select eLoc or coordinate.", preferredStyle: .actionSheet)
        alterView.addAction(UIAlertAction(title: "driving", style: .default, handler: { [self] (handler) in
            if mode == .distance {
                selectedProfileDistance = .driving
            } else if mode == .distance {
                selectedProfileDirection = .driving
            }
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "walking", style: .default, handler: { [self] (handler) in
            if mode == .distance {
                selectedProfileDistance = .walking
            } else if mode == .distance {
                selectedProfileDirection = .walking
            }
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "biking", style: .default, handler: { [self] (handler) in
            if mode == .distance {
                selectedProfileDistance = .biking
            } else if mode == .distance {
                selectedProfileDirection = .biking
            }
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "trucking", style: .default, handler: { [self] (handler) in
            if mode == .distance {
                selectedProfileDistance = .trucking
            } else if mode == .distance {
                selectedProfileDirection = .trucking
            }
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (handler) in
        }))
        present(alterView, animated: true, completion: nil)
    }
}

extension LocationsChooserTableViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        if mode == .distance {
            return 5
        } else if mode == .direction {
            return 6
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case sectionForAutocompleteSwitch:
            return 1
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
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell!
        let section = indexPath.section
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
            //text.textAlignment = .right
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
            //addButton.topAnchor.constraint(equalTo: viewHeader.topAnchor, constant: 10).isActive = true
            //addButton.bottomAnchor.constraint(equalTo: viewHeader.bottomAnchor, constant: -10).isActive = true
            
            textLabel.leftAnchor.constraint(equalTo: viewHeader.leftAnchor, constant: 8).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8).isActive = true
            textLabel.centerYAnchor.constraint(equalTo: viewHeader.centerYAnchor, constant: 0).isActive = true
            //textLabel.topAnchor.constraint(equalTo: viewHeader.topAnchor, constant: 0).isActive = true
            //textLabel.bottomAnchor.constraint(equalTo: viewHeader.bottomAnchor, constant: 0).isActive = true
            
            
            if ((section == sectionForSourceLocations || section == sectionForDestinationLocations)
                    && mode == .direction) {
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
        if indexPath.section == sectionForSourceLocations && mode == .distance {
            return true
        } else if indexPath.section == sectionForDestinationLocations && mode == .distance {
            return true
        } else {
            return false
        }
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if indexPath.section == sectionForDestinationLocations && mode == .distance && destinationLocations.count > 1 {
                destinationLocations.remove(at: indexPath.row)
                tableView.reloadData()
            } else if indexPath.section == sectionForSourceLocations && mode == .distance && sourceLocations.count > 1 {
                sourceLocations.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
}

extension LocationsChooserTableViewController: MapmyIndiaAutocompleteViewControllerDelegate {
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
}
