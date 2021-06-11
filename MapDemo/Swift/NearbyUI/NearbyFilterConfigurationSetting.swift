
import UIKit
import MapmyIndiaAPIKit
import MapmyIndiaUIWidgets
import MapmyIndiaDirections


protocol NearbyFilterConfigurationSettingDelegate {
    func nearbyFilterConfiguration(radius: String, refLocation: String, pod: MMIPodTypeIdentifier, orderby: MMISortByOrderType, searchby: MMISearchByType, bound: [String])
}

class NearbyFilterConfigurationSetting: UITableViewController {
//    public var mode: LocationsChooserMode = .distance
    var delegate: NearbyFilterConfigurationSettingDelegate?
    
//    let sectionForAutocompleteSwitch = 0
    let sectionForPodFilter = 1
    let sectionForSortbyFilter = 2
    let sectionForSearchBy = 3
    let Radius = 4
    let refLocation = 5
    let sectionForBound = 6
    
    
    
    var shouldOpenAutocomplete: Bool = true
    var sourceLocations = [String]()
    var destinationLocations = [String]()
    var viaLocations = ["",""]
    var indexPathForSourceOrDesitnation: IndexPath?
    
    var selectedNearbyPod: MMIPodTypeIdentifier = .none
    var selectedSortbyFilter: MMISortByOrderType = .ascending
    var selectedSearchbyFilter: MMISearchByType = .distance
    
//    var selectedResourceDirection: MBDirectionsResourceIdentifier = .routeAdv
//    var selectedProfileDirection: MBDirectionsProfileIdentifier = .driving
//    var attributions : MBAttributeOptions = []
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Nearby Filter Configurations"
        self.tableView.separatorStyle = .singleLineEtched
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonClicked))
            sourceLocations = [""]
            destinationLocations = [""]
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    @objc func doneButtonClicked() {
        
            print(sourceLocations.count)
            if sourceLocations.count > 0 && destinationLocations.count > 0 {
                
                delegate?.nearbyFilterConfiguration(radius: sourceLocations.first!, refLocation: destinationLocations.first!, pod: selectedNearbyPod, orderby: selectedSortbyFilter, searchby: selectedSearchbyFilter, bound: viaLocations)
                dismiss()
            } else {
                emptyFieldError()
            }
            
        
        
    }
    
    func emptyFieldError() {
        let alert = UIAlertController(title: "Empty Field!", message: "Please fill empty fields first.", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func dismiss() {
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
        case sectionForPodFilter:
            return "Pod"
        case sectionForSortbyFilter:
            return "Sort by"
        case sectionForSearchBy:
            return "SearchBy"
        default:
            return ""
        }
    }
    
    @objc func getDetailsForDetailTextCell(indexPath: IndexPath) -> String {
        switch indexPath.section {
        case sectionForPodFilter:
            switch selectedNearbyPod {
            case .city:
                return "city"
            case .district:
                return "district"
            case .locality:
                return "locality"
            case .none:
                return "none"
            case .state:
                return "state"
            case .subSubLocality:
                return "subSubLocality"
            case .subdistrict:
                return "subdistrict"
            case .sublocality:
                return "sublocality"
            default:
                return ""
            }
            
        case sectionForSortbyFilter:
            switch selectedSortbyFilter {
            case .ascending:
                return "ascending"
            case .descending:
                return "descending"
            default:
                return ""
            }
            
        case sectionForSearchBy:
            switch selectedSearchbyFilter {
            case .distance:
                return "distance"
            case .importance:
                return "importance"
            default:
                return ""
            }
            
        default:
            return ""
        }
    }

    
    @objc func getValueForSource(row: Int) -> String {
        return sourceLocations[row]
    }
    
    @objc func getValueForDestination(row: Int) -> String {
        return destinationLocations[row]
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
    
    @objc func viaLocationButtonPressed(_ button: UIButton) {
        let row = button.tag
        indexPathForSourceOrDesitnation = IndexPath(row: row, section: sectionForBound)
        openAutocompleteController()
    }
    
    @objc func sourceLocationButtonPressed(_ button: UIButton) {
        let row = button.tag
        indexPathForSourceOrDesitnation = IndexPath(row: row, section: Radius)
        openAutocompleteController()
    }
    
    @objc func destinationLocationButtonPressed(_ button: UIButton) {
        let row = button.tag
        indexPathForSourceOrDesitnation = IndexPath(row: row, section: refLocation)
        openAutocompleteController()
    }
    

    
    @objc func openAutocompleteController() {
        let autoCompleteVC = MapmyIndiaAutocompleteViewController()
        autoCompleteVC.delegate = self
        present(autoCompleteVC, animated: true, completion: nil)
    }
    
    @objc func openActionSheetToChooseLocationType(selectedPlace: MapmyIndiaAtlasSuggestion) {
        let alterView = UIAlertController(title: "Select eLoc or Coordinate", message: "Please select eLoc or coordinate.", preferredStyle: .actionSheet)
        alterView.addAction(UIAlertAction(title: "Coordinate", style: .default, handler: { [self] (handler) in
            setCoordinateValueForSourceOrDestinationLocationField(selectedPlace: selectedPlace)
        }))

        alterView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (handler) in
        }))
        present(alterView, animated: true, completion: nil)
    }
    
    
    @objc func setCoordinateValueForSourceOrDestinationLocationField(selectedPlace: MapmyIndiaAtlasSuggestion) {
        if let indexPath = indexPathForSourceOrDesitnation {
            if let latitude = selectedPlace.latitude, let longitude = selectedPlace.longitude {
               if indexPath.section == refLocation {
                    destinationLocations[indexPath.row] = "\(latitude),\(longitude)"
                }
                if indexPath.section == sectionForBound && indexPath.row == 0 {
                    viaLocations[indexPath.row] = "\(latitude),\(longitude)"
                } else if indexPath.section == sectionForBound && indexPath.row == 1 {
                    viaLocations[indexPath.row] = "\(latitude),\(longitude)"
                }
                tableView.reloadData()
            }
        }
    }
    
    @objc func openAttributionSetting(){
        let attributionVC = AttributionSettingTableViewController()
        self.navigationController?.pushViewController(attributionVC, animated: false)
    }
    
    @objc func setElocValueForSourceOrDestinationLocationField(selectedPlace: MapmyIndiaAtlasSuggestion) {
        if let indexPath = indexPathForSourceOrDesitnation {
            if let eLoc = selectedPlace.eLoc {
                if indexPath.section == refLocation {
                    destinationLocations[indexPath.row] = eLoc
                }
                tableView.reloadData()
            }
        }
    }
    
    @objc func openActionSheetToChooseNearbyFilterPod() {
        let alterView = UIAlertController(title: "Select eLoc or Coordinate", message: "Please select eLoc or coordinate.", preferredStyle: .actionSheet)
        alterView.addAction(UIAlertAction(title: "city", style: .default, handler: { [self] (handler) in
          
                selectedNearbyPod = .city
           
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "district", style: .default, handler: { [self] (handler) in
           
                selectedNearbyPod = .district
           
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "locality", style: .default, handler: { [self] (handler) in
           
                selectedNearbyPod = .locality
           
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "none", style: .default, handler: { [self] (handler) in
           
                selectedNearbyPod = .none
           
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "state", style: .default, handler: { [self] (handler) in
           
                selectedNearbyPod = .state
           
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "subSubLocality", style: .default, handler: { [self] (handler) in
           
                selectedNearbyPod = .subSubLocality
           
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "subdistrict", style: .default, handler: { [self] (handler) in
           
                selectedNearbyPod = .subdistrict
           
            tableView.reloadData()
        }))
        
        alterView.addAction(UIAlertAction(title: "sublocality", style: .default, handler: { [self] (handler) in
           
                selectedNearbyPod = .sublocality
           
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (handler) in
        }))
        present(alterView, animated: true, completion: nil)
    }
    
    @objc func openActionSheetToChooseSortByFilter() {
        let alterView = UIAlertController(title: "Sort by Filter", message: "nearby sortby filter", preferredStyle: .actionSheet)

        alterView.addAction(UIAlertAction(title: "ascending", style: .default, handler: { [self] (handler) in
            
            selectedSortbyFilter = .ascending
           
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "descending", style: .default, handler: { [self] (handler) in
            
            selectedSortbyFilter = .descending
            
            tableView.reloadData()
        }))
       
        alterView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (handler) in
        }))
        present(alterView, animated: true, completion: nil)
    }
    
    @objc func openActionSheetToChooseSearchByFilter() {
        let alterView = UIAlertController(title: "Search by Filter", message: "nearby searchBy filter", preferredStyle: .actionSheet)

        alterView.addAction(UIAlertAction(title: "distance", style: .default, handler: { [self] (handler) in
            
            selectedSearchbyFilter = .distance
           
            tableView.reloadData()
        }))
        alterView.addAction(UIAlertAction(title: "importance", style: .default, handler: { [self] (handler) in
            
            selectedSearchbyFilter = .importance
            
            tableView.reloadData()
        }))
       
        alterView.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (handler) in
        }))
        present(alterView, animated: true, completion: nil)
    }
}

extension NearbyFilterConfigurationSetting {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
            return 7
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case sectionForPodFilter:
            return 1
        case sectionForSortbyFilter:
            return 1
        
        case sectionForSearchBy:
            return 1
           
        case Radius:
            return sourceLocations.count
        case refLocation:
            return destinationLocations.count
        case sectionForBound:
            return 2
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell!
        let section = indexPath.section
        switch section {
        case sectionForPodFilter, sectionForSortbyFilter, sectionForSearchBy:
            let cellIdentifier = "detailTextCell"
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
                tableCell = cell
            } else {
                tableCell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
                tableCell.accessoryType = .disclosureIndicator
            }
            tableCell.textLabel?.text = getTitleForDetailTextCell(indexPath: indexPath)
            tableCell.detailTextLabel?.text = getDetailsForDetailTextCell(indexPath: indexPath)
        
        case Radius, refLocation, sectionForBound:
            let cellIdentifier = "locationChooserCell"
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) as? NearbyUIFilterConfigurationCell {
                tableCell = cell
            } else {
                tableCell = NearbyUIFilterConfigurationCell(style: .default, reuseIdentifier: cellIdentifier)
                if let locationCell = tableCell as? NearbyUIFilterConfigurationCell {
                    locationCell.nearbyRadiusTextField.addTarget(self, action: #selector(sourceValueChanged), for: .editingChanged)
                    locationCell.destinationLocationTextField.addTarget(self, action: #selector(destinationValueChanged), for: .editingChanged)
                    locationCell.boundTextField.addTarget(self, action: #selector(viaValueChanged), for: .editingChanged)
                    locationCell.autocompleteWidgetButton.addTarget(self, action: #selector(sourceLocationButtonPressed), for: .touchUpInside)
                    locationCell.refLocationAutocompleteWidgetButton.addTarget(self, action: #selector(destinationLocationButtonPressed), for: .touchUpInside)
                    locationCell.viaAutocompleteWidgetButton.addTarget(self, action: #selector(viaLocationButtonPressed), for: .touchUpInside)
                }
            }
            if let locationCell = tableCell as? NearbyUIFilterConfigurationCell {
                locationCell.nearbyRadiusTextField.tag = indexPath.row
                locationCell.nearbyRadiusTextField.text = (section == Radius) ? getValueForSource(row: indexPath.row) : ""
                locationCell.nearbyRadiusTextField.isHidden = (section == Radius) ? false : true
                
                locationCell.destinationLocationTextField.tag = indexPath.row
                locationCell.destinationLocationTextField.text = (section == refLocation) ? getValueForDestination(row: indexPath.row) : ""
                locationCell.destinationLocationTextField.isHidden = (section == refLocation) ? false : true
                
                locationCell.autocompleteWidgetButton.tag = indexPath.row
                locationCell.autocompleteWidgetButton.isHidden = (shouldOpenAutocomplete && section == Radius) ? true : true
                
                locationCell.boundTextField.tag = indexPath.row
                locationCell.boundTextField.text = (section == sectionForBound) ? viaLocations[indexPath.row] : ""
                
                locationCell.refLocationAutocompleteWidgetButton.tag = indexPath.row
                locationCell.refLocationAutocompleteWidgetButton.isHidden = (shouldOpenAutocomplete && section == refLocation) ? false : true
                
                locationCell.boundTextField.tag = indexPath.row
                locationCell.boundTextField.placeholder = (section == sectionForBound && indexPath.row == 0) ? "Top Left" : "Bottom Right"
                locationCell.boundTextField.isHidden = (section == sectionForBound) ? false : true
                
                locationCell.viaAutocompleteWidgetButton.tag = indexPath.row
                locationCell.viaAutocompleteWidgetButton.isHidden = (shouldOpenAutocomplete && section == sectionForBound) ? false : true
                
              
            }
            
        default:
            tableCell = UITableViewCell()
        }
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == Radius
            || section == refLocation || section == sectionForBound {
            let viewHeader = UIView()
            viewHeader.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
            let textLabel = UILabel()
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            textLabel.textColor = .white
            textLabel.font = UIFont.boldSystemFont(ofSize: 20)
            if section == Radius {
                textLabel.text = "Radius"
            } else if section == refLocation {
                textLabel.text = "Ref Location"
            } else if section == sectionForBound {
                textLabel.text = "Bound"
            }
            viewHeader.addSubview(textLabel)
            textLabel.leftAnchor.constraint(equalTo: viewHeader.leftAnchor, constant: 8).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: viewHeader.trailingAnchor, constant: -20).isActive = true
            textLabel.centerYAnchor.constraint(equalTo: viewHeader.centerYAnchor, constant: 0).isActive = true

            return viewHeader
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case sectionForPodFilter:
            openActionSheetToChooseNearbyFilterPod()
        case sectionForSortbyFilter:
            openActionSheetToChooseSortByFilter()
        case sectionForSearchBy:
            openActionSheetToChooseSearchByFilter()
        default:
            break
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == Radius
            || section == refLocation || section == sectionForBound{
            return 30
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        if indexPath.section == Radius  {
            return true
        } else if indexPath.section == refLocation {
            return true
        } else {
            return false
        }
        
    }

    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == .delete) {
            if indexPath.section == refLocation  && destinationLocations.count > 1 {
                destinationLocations.remove(at: indexPath.row)
                tableView.reloadData()
            } else if indexPath.section == Radius && sourceLocations.count > 1 {
                sourceLocations.remove(at: indexPath.row)
                tableView.reloadData()
            }
        }
    }
    
}

extension NearbyFilterConfigurationSetting: MapmyIndiaAutocompleteViewControllerDelegate {
    func didAutocomplete(viewController: MapmyIndiaAutocompleteViewController, withPlace place: MapmyIndiaAtlasSuggestion) {
        self.dismiss(animated: false) {
            if let _ = place.latitude, let _ = place.longitude {
//                self.openActionSheetToChooseLocationType(selectedPlace: place)
                self.setCoordinateValueForSourceOrDestinationLocationField(selectedPlace: place)
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
