public enum AttributionsOptionsType: UInt, CustomStringConvertible, CaseIterable {
//    case distance
//    case expectedTravelTime
//    case speed
    case congestionLevel
    
    public var description: String {
        switch self {
//        case .distance:
//            return "Distance"
//        case .expectedTravelTime:
//            return "Expected Travel Time"
//        case .speed:
//            return "Speed"
        case .congestionLevel:
            return "Congestion Level"
      
        }
    }
}
import UIKit


class AttributionSettingTableViewController: UIViewController {
    var tableView: UITableView!
    let attributionsOptionSetting = AttributionsOptionsType.allCases
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        self.view.backgroundColor = .white
            
    }
    
    func setupTableView(){
        tableView = UITableView()
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        tableView.topAnchor.constraint(equalTo: self.view.safeTopAnchor, constant: 0).isActive = true
        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 0).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: 0).isActive = true
        
    }
    @objc func switchChanged(_ sender : UISwitch) {
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let currentType = attributionsOptionSetting[indexPath.row]
        if currentType == .congestionLevel {
            UserDefaultsManager.isCongestionLevel = sender.isOn
        }
//        else if currentType == .distance {
//            UserDefaultsManager.isDistance = sender.isOn
//        }
//        else if currentType == .expectedTravelTime {
//            UserDefaultsManager.isExpectedTravelTime = sender.isOn
//        }
//        else if currentType == .speed {
//            UserDefaultsManager.isSpeed = sender.isOn
//        }
        tableView.reloadData()
        
    }
    func getValueForPlacePickerSetting(_ attributionSetting : AttributionsOptionsType) -> Bool {
        switch attributionSetting {
//        case .distance:
//            print(UserDefaultsManager.isDistance)
//            return UserDefaultsManager.isDistance
//        case .speed:
//            return UserDefaultsManager.isSpeed
//        case .expectedTravelTime:
//            return UserDefaultsManager.isExpectedTravelTime
        case .congestionLevel:
            return UserDefaultsManager.isCongestionLevel
        
        }
    }
}
extension AttributionSettingTableViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributionsOptionSetting.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var tableCell: UITableViewCell!
        let cellIdentifier = "attriutionCell"
        var switchView: UISwitch!
        let currentType = attributionsOptionSetting[indexPath.row]
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            tableCell = cell
            if let accessoryView = tableCell.accessoryView, accessoryView.isKind(of: UISwitch.self) {
                switchView = accessoryView as? UISwitch
                switchView.isOn = self.getValueForPlacePickerSetting(currentType)
            }
        } else {
            tableCell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            switchView = UISwitch(frame: .zero)
            tableCell.accessoryView = switchView
            switchView.tag = indexPath.row
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            switchView.isOn = self.getValueForPlacePickerSetting(currentType)
        }
        tableCell.textLabel?.text = attributionsOptionSetting[indexPath.row].description
        return tableCell
    }
}
