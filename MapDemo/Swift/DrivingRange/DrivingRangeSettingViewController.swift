
import UIKit
import MapmyIndiaAPIKit
import MapmyIndiaUIWidgets
import MapmyIndiaDirections
import MapmyIndiaDirectionsUI
import CoreLocation
import MapmyIndiaDrivingRangePlugin

protocol DrivingRangeSettingViewControllerDelegate {
    func locationsPikcedForDirectionsUI(options: MapmyIndiaDrivingRangeOptions)
}

class DrivingRangeSettingViewController: UITableViewController {
    var delegate: DrivingRangeSettingViewControllerDelegate?
    let sectionForShowLocation = 0
    let sectionForSelectLocation = 1
    let SectionForRangeInfo = 2
    let SectionForSpeedInfo = 3
    

    var isShowRangeInfoTextField: Bool = true
    var isShowSpeedInfoTextField: Bool = true
    var sourceLocations = [String]()
    var userLocation: CLLocationCoordinate2D!
    var destinationLocations = [String]()
    var attributions = [String]()
    var dirAttributions : MBAttributeOptions = []
    var indexPathForRows: IndexPath?
    
    var selectedResourceDistance: MapmyIndiaDistanceMatrixResourceIdentifier = .default
    var selectedProfileDistance: MapmyIndiaDirectionsProfileIdentifier = .driving
    
    var selectedResourceDirection: MBDirectionsResourceIdentifier = .routeAdv
    var selectedProfileDirection: MBDirectionsProfileIdentifier = .driving
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Driving range"
        self.tableView.separatorStyle = .none
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneButtonClicked))
        sourceLocations = [""]
        destinationLocations = [""]
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    var rangeInfo: Int = 0
    var speedInfo: Int = 0
    
    @objc func doneButtonClicked() {
        if sourceLocations.indices.contains(1) && self.sourceLocations.last != "Enter time in min." && self.sourceLocations.last != ""  && userLocation != nil {
            var mapmyIndiaDrivingRangeRangeTypeInfo : MapmyIndiaDrivingRangeRangeTypeInfo!
            var mapmyIndiaDrivingRangeOptimalSpeed: MapmyIndiaDrivingRangeSpeed!
            if let rangeInfos = sourceLocations.last {
                var contours = [MapmyIndiaDrivingRangeContour]()
//                if rangeInfos.contains(",") {
                    let rageInfo = rangeInfos.split(separator: ",")
                    for r in rageInfo {
                        if let intValue = Int(r) {
                            contours.append(MapmyIndiaDrivingRangeContour(value: intValue))
                        }
                    }
//                }
                if rangeInfo == 0 {
                    mapmyIndiaDrivingRangeRangeTypeInfo = MapmyIndiaDrivingRangeRangeTypeInfo(rangeType: .time, contours: contours)
                } else {
                    mapmyIndiaDrivingRangeRangeTypeInfo = MapmyIndiaDrivingRangeRangeTypeInfo(rangeType: .distance, contours: contours)
                }
            }
            
            if self.destinationLocations.indices.contains(1),let speedInfos = self.destinationLocations.last  {
                if speedInfo == 0 {
                    mapmyIndiaDrivingRangeOptimalSpeed = MapmyIndiaDrivingRangeOptimalSpeed()
                } else if speedInfo == 1 {
                    mapmyIndiaDrivingRangeOptimalSpeed = MapmyIndiaDrivingRangePredictiveSpeedFromCurrentTime()
                } else if speedInfo == 2 {
                    if  speedInfos != "", let timeStamp = TimeInterval(speedInfos) {
                        mapmyIndiaDrivingRangeOptimalSpeed = MapmyIndiaDrivingRangePredictiveSpeedFromCustomTime(timestamp: timeStamp)
                    }
                    
                }
            }
            let location = CLLocation(latitude: userLocation.latitude, longitude: userLocation.longitude)
            var drivingRangeOptions: MapmyIndiaDrivingRangeOptions!
            guard mapmyIndiaDrivingRangeRangeTypeInfo != nil else {
                emptyFieldError()
                return
            }
            if let option = mapmyIndiaDrivingRangeOptimalSpeed {
                drivingRangeOptions  = MapmyIndiaDrivingRangeOptions(location: location, rangeTypeInfo: mapmyIndiaDrivingRangeRangeTypeInfo, speedTypeInfo: option)
            } else {
                drivingRangeOptions  = MapmyIndiaDrivingRangeOptions(location: location, rangeTypeInfo: mapmyIndiaDrivingRangeRangeTypeInfo)
            }
            
            
            drivingRangeOptions.isShowLocations = isShowLocation
            delegate?.locationsPikcedForDirectionsUI(options: drivingRangeOptions)
            self.navigationController?.popViewController(animated: false)
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
    var isShowLocation = false
    @objc func switchChanged(_ sender : UISwitch) {
        isShowLocation = sender.isOn
        tableView.reloadData()
    }
    
    @objc func getTitleForDetailTextCell(indexPath: IndexPath) -> String {
        switch indexPath.section {
        case sectionForShowLocation:
            return "Show location"
        case sectionForSelectLocation:
            return "Select location"
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
        sourceLocations[1] = textField.text ?? ""
    }
    
    @objc func destinationValueChanged(_ textField: UITextField) {
        destinationLocations[1] = textField.text ?? ""
    }

    var placeHolderText :String = ""
    @objc func sourceLocationButtonPressed(_ button: UIButton) {
        let row = button.tag
        indexPathForRows = IndexPath(row: row, section: SectionForRangeInfo)
        let alertController = UIAlertController(title: "Range Info?", message: "Select type of Range info", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Time", style: .default, handler: { (alertAction) in
            self.isShowRangeInfoTextField = false
            if self.sourceLocations.indices.contains(1) {
                self.sourceLocations[1] = "Enter time in min."
            } else {
                self.sourceLocations.append("Enter time in min.")
            }
            self.rangeInfo = 0
            self.tableView.reloadData()
                
        }))
        alertController.addAction(UIAlertAction(title: "Distance", style: .default, handler: { (alertAction) in
            if self.sourceLocations.indices.contains(1) {
                self.sourceLocations[1] = "Enter distance in Kms."
            } else {
                self.sourceLocations.append("Enter distance in Kms.")
            }
            self.rangeInfo = 1
            self.tableView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
        
        }))
        present(alertController, animated: false, completion: nil)
    }
    
    var speedInfoTextFieldPlaceHolder: String = ""
    var isUserIntrctionOn = true
    @objc func destinationLocationButtonPressed(_ button: UIButton) {
        let row = button.tag
        indexPathForRows = IndexPath(row: row, section: SectionForSpeedInfo)
        let alertController = UIAlertController(title: "Speed info?", message: "Select type of speed info ", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Speed from custom time", style: .default, handler: { (alertAction) in
            self.isShowSpeedInfoTextField = false
            if self.destinationLocations.indices.contains(1) {
                self.destinationLocations[1] = "Select date"
                self.speedInfoTextFieldPlaceHolder = "Select date"
            } else {
                self.speedInfoTextFieldPlaceHolder = "Select date"
                self.destinationLocations.append("Select date")
            }
            self.isUserIntrctionOn = true
            self.speedInfo = 2
            self.tableView.reloadData()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Speed from current time", style: .default, handler: { (alertAction) in
            self.speedInfoTextFieldPlaceHolder = "Current time"
            if self.destinationLocations.indices.contains(1) {
                self.destinationLocations[1] = ""
            } else {
                self.destinationLocations.append("")
            }
            self.speedInfo = 1
            self.isUserIntrctionOn = false
            self.tableView.reloadData()
            
        }))
        
        alertController.addAction(UIAlertAction(title: "Optimal speed", style: .default, handler: { (alertAction) in
            self.speedInfo = 0
            if self.destinationLocations.indices.contains(1) {
                self.destinationLocations[1] = ""
            } else {
                self.destinationLocations.append("")
            }
            self.speedInfoTextFieldPlaceHolder = "Optimal speed"
            self.isUserIntrctionOn = false
            self.tableView.reloadData()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (alertAction) in
        
        }))
        present(alertController, animated: false, completion: nil)
    }
    
    
    @objc func openAutocompleteController() {
        let autoCompleteVC = MapmyIndiaAutocompleteViewController()
        autoCompleteVC.delegate = self
        present(autoCompleteVC, animated: true, completion: nil)
    }

   @objc func setCoordinateValueForSourceOrDestinationLocationField(selectedPlace: MapmyIndiaAtlasSuggestion) {
       if let latitude = selectedPlace.latitude, let longitude = selectedPlace.longitude {
           userLocation = CLLocationCoordinate2D(latitude: CLLocationDegrees(truncating: latitude), longitude: CLLocationDegrees(truncating: longitude))
           tableView.reloadData()
       }
    }
    

    var myTextField = UITextField()
   
    
    var textString = ""
    @objc func tapDone(sender: UITextField) {
        print(sender.tag)
        let cell = tableView.cellForRow(at: indexPathForRows!) as! LocationChooserTableViewCell
        
        if let datePicker = cell.destinationLocationTextField.inputView as? UIDatePicker { // 2-1
            let dateformatter = DateFormatter()// 2-2
            dateformatter.dateFormat = "YYYY-MM-DDTHH:MM"
            dateformatter.dateStyle = .full // 2-3
            textString = dateformatter.string(from: datePicker.date) //2-4
            
            print(dateformatter.string(from: datePicker.date))
            print(datePicker.date.timeIntervalSince1970)
            destinationLocations[1] = "\(datePicker.date.timeIntervalSince1970)"
        }
        self.tableView.reloadData()
    }
    
    @objc func openAttributionSetting(){
        let attributionVC = AttributionSettingTableViewController()
        self.navigationController?.pushViewController(attributionVC, animated: false)
    }
}

extension DrivingRangeSettingViewController {
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
            return 5
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case sectionForShowLocation:
            return 1
        case sectionForSelectLocation:
            return 1
        case SectionForRangeInfo:
            return sourceLocations.count
        case SectionForSpeedInfo:
            return destinationLocations.count
        default:
            return 0
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell!
        let section = indexPath.section
        switch section {
        case sectionForShowLocation:
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
            tableCell.textLabel?.text = "Show Locations"
        case sectionForSelectLocation:
            let cellIdentifier = "detailTextCell"
            self.indexPathForRows = indexPath
            if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
                tableCell = cell
            } else {
                tableCell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
                tableCell.accessoryType = .disclosureIndicator
            }
            tableCell.textLabel?.text = getTitleForDetailTextCell(indexPath: indexPath)
            if let userLocation = userLocation {
                tableCell.detailTextLabel?.text = "\(userLocation.latitude), \(userLocation.longitude)"
            }
            
        case SectionForRangeInfo:
            let cellIdentifier = "locationChooserCell"
            tableCell = LocationChooserTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            self.indexPathForRows = indexPath
            if let locationCell = tableCell as? LocationChooserTableViewCell {
                locationCell.destinationAutocompleteWidgetButton.isHidden = true
                locationCell.destinationLocationTextField.isHidden = true
                
                
                if indexPath.row == 0 {
                    locationCell.accessoryType = .disclosureIndicator
                    locationCell.sourceAutocompleteWidgetButton.setTitle("Select range info type", for: .normal)
                    locationCell.sourceAutocompleteWidgetButton.setTitleColor(UIColor.lightGray, for: .normal)
                    locationCell.sourceAutocompleteWidgetButton.contentHorizontalAlignment = .left
                    locationCell.sourceAutocompleteWidgetButton.addTarget(self, action: #selector(sourceLocationButtonPressed), for: .touchUpInside)
                    locationCell.sourceAutocompleteWidgetButton.isHidden = false
                    locationCell.sourceLocationTextField.isHidden = true
                    
                } else if indexPath.row ==  1 {
                    locationCell.sourceLocationTextField.placeholder = sourceLocations.last
                    locationCell.sourceLocationTextField.addTarget(self, action: #selector(sourceValueChanged), for: .editingChanged)
                    locationCell.sourceLocationTextField.keyboardType = .phonePad
                    locationCell.sourceAutocompleteWidgetButton.isHidden = true
                    locationCell.sourceLocationTextField.isHidden = false
                    
                }
            }
        case SectionForSpeedInfo:
            let cellIdentifier = "locationChooserCell1"
            tableCell = LocationChooserTableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            self.indexPathForRows = indexPath
            if let locationCell = tableCell as? LocationChooserTableViewCell {
                locationCell.sourceLocationTextField.isHidden = true
                locationCell.sourceAutocompleteWidgetButton.isHidden = true
                locationCell.destinationLocationTextField.tag = indexPath.row
               
                locationCell.destinationLocationTextField.isUserInteractionEnabled = isUserIntrctionOn
                if indexPath.row == 0 {
                    locationCell.accessoryType = .disclosureIndicator
                    locationCell.destinationAutocompleteWidgetButton.setTitle("Select Speed info type", for: .normal)
                    locationCell.destinationAutocompleteWidgetButton.setTitleColor(UIColor.lightGray, for: .normal)
                    locationCell.destinationAutocompleteWidgetButton.contentHorizontalAlignment = .left
                    locationCell.destinationAutocompleteWidgetButton.addTarget(self, action: #selector(destinationLocationButtonPressed), for: .touchUpInside)
                    locationCell.destinationAutocompleteWidgetButton.isHidden = false
                    locationCell.destinationLocationTextField.isHidden = true
                    
                }  else if indexPath.row == 1 {
                    locationCell.destinationLocationTextField.placeholder = speedInfoTextFieldPlaceHolder
                    locationCell.destinationLocationTextField.addTarget(self, action: #selector(destinationValueChanged), for: .editingChanged)
                    locationCell.destinationLocationTextField.setInputViewDatePicker(target: self, selector: #selector(tapDone))
                    locationCell.destinationLocationTextField.keyboardType = .numberPad
                    locationCell.destinationLocationTextField.isHidden = false
                    if textString != "" && speedInfo == 2 {locationCell.destinationLocationTextField.placeholder = textString}
                    locationCell.destinationAutocompleteWidgetButton.isHidden = true
                }
            }
            
        default:
            tableCell = UITableViewCell()
        }
        return tableCell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        if section == SectionForRangeInfo
            || section == SectionForSpeedInfo{
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
            viewHeader.addSubview(addButton)
            
            let textLabel = UILabel()
            textLabel.translatesAutoresizingMaskIntoConstraints = false
            textLabel.textColor = .white
            textLabel.font = UIFont.boldSystemFont(ofSize: 20)
            if section == SectionForRangeInfo {
                textLabel.text = "Range Info"
            } else if section == SectionForSpeedInfo {
                textLabel.text = "Speed Info"
            }
            viewHeader.addSubview(textLabel)
            
            addButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
            addButton.heightAnchor.constraint(equalTo: addButton.widthAnchor).isActive = true
            addButton.trailingAnchor.constraint(equalTo: viewHeader.trailingAnchor, constant: -8).isActive = true
            addButton.centerYAnchor.constraint(equalTo: viewHeader.centerYAnchor, constant: 0).isActive = true
            
            textLabel.leftAnchor.constraint(equalTo: viewHeader.leftAnchor, constant: 8).isActive = true
            textLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -8).isActive = true
            textLabel.centerYAnchor.constraint(equalTo: viewHeader.centerYAnchor, constant: 0).isActive = true
            if ((section == SectionForRangeInfo || section == SectionForSpeedInfo)) {
                addButton.isHidden = true
            }
            
            return viewHeader
        }
        return nil
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.section {
        case sectionForSelectLocation:
            openAutocompleteController()
        default:
            break
        }
    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == SectionForRangeInfo
            || section == SectionForSpeedInfo {
            return 40
        }
        return 0
    }
    
}
extension DrivingRangeSettingViewController: MapmyIndiaAutocompleteViewControllerDelegate {
    func didAutocomplete(viewController: MapmyIndiaAutocompleteViewController, withPlace place: MapmyIndiaAtlasSuggestion) {
        self.dismiss(animated: false) {
            if let _ = place.latitude, let _ = place.longitude {
                self.setCoordinateValueForSourceOrDestinationLocationField(selectedPlace: place)
            }
        }
    }
    
    func didFailAutocomplete(viewController: MapmyIndiaAutocompleteViewController, withError error: NSError) {
        
    }
    
    func wasCancelled(viewController: MapmyIndiaAutocompleteViewController) {
        
    }
}


extension UITextField {
    
    func setInputViewDatePicker(target: Any, selector: Selector) {
        // Create a UIDatePicker object and assign to inputView
        let screenWidth = UIScreen.main.bounds.width
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))//1
        datePicker.datePickerMode = .dateAndTime //2
        // iOS 14 and above
        if #available(iOS 14, *) {// Added condition for iOS 14
          datePicker.preferredDatePickerStyle = .wheels
          datePicker.sizeToFit()
        }
        self.inputView = datePicker //3
        
        // Create a toolbar and assign it to inputAccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: screenWidth, height: 44.0)) //4
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil) //5
        let cancel = UIBarButtonItem(title: "Cancel", style: .plain, target: nil, action: #selector(tapCancel)) // 6
        let barButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector) //7
        toolBar.setItems([cancel, flexible, barButton], animated: false) //8
        self.inputAccessoryView = toolBar //9
    }
    
    @objc func tapCancel() {
        self.resignFirstResponder()
    }
    
}
