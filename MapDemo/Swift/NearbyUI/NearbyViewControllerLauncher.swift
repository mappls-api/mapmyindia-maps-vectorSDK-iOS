import UIKit
import MapmyIndiaNearbyUI
import MapmyIndiaAPIKit
import MapmyIndiaMaps
class NearbyViewControllerLauncher: UIViewController {
    var button = UIButton()
    var pod : MMIPodTypeIdentifier = .none
    var radius: Int = 1000
    var orderby: MMISortByOrderType = .ascending
    var searchby: MMISearchByType = .distance
    var refLocation : String? = nil
    var bound: MapmyIndiaRectangularRegion!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        let settingsBarButton = UIBarButtonItem(title: "Filter Settings", style: .plain, target: self, action: #selector(settingsButtonTapped))
        self.navigationItem.rightBarButtonItems = [settingsBarButton]
        setupButtonLayout()
    }
    
    func setupButtonLayout() {
        
        let nearbyUIConfigurationSetting = UIButton()
        nearbyUIConfigurationSetting.setTitle("Nearby CustomUI", for: .normal)
        nearbyUIConfigurationSetting.backgroundColor = .magenta
        self.view.addSubview(nearbyUIConfigurationSetting)
//        nearbyUIConfigurationSetting.addTarget(self, action: #selector(launchCustomUI), for: .touchUpInside)
        
        nearbyUIConfigurationSetting.translatesAutoresizingMaskIntoConstraints = false
        nearbyUIConfigurationSetting.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        nearbyUIConfigurationSetting.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        nearbyUIConfigurationSetting.topAnchor.constraint(equalTo: self.view.safeTopAnchor, constant: 70).isActive = true
        nearbyUIConfigurationSetting.heightAnchor.constraint(equalToConstant: 35).isActive = true
        
        button.backgroundColor = .brown
        self.view.addSubview(button)
        button.setTitle("launch nearby VC", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(launchNearby), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        button.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        button.heightAnchor.constraint(equalToConstant: 35).isActive = true
        button.topAnchor.constraint(equalTo: self.view.topAnchor,constant: 300).isActive = true
//        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
    }
    /*@objc func launchCustomUI() {
//        let categoryConfiguration = MapmyIndiaNearbyCategoryConfiguration()
        let configuration = MapmyIndiaNearbyConfiguration()
//        let uiConfiguration = configuration.mapmyIndiaNearbyUIConfiguration
        
        categoryConfiguration.nextButtonTitle = "MOVE"
        categoryConfiguration.nextButtonBackgroundColor = .cyan
        categoryConfiguration.changeLocationButtonTitle = "Change Custom Location"
        categoryConfiguration.locationDetailsViewBackground = .yellow
        categoryConfiguration.navigationImage = UIImage(named: "icon1")!
        uiConfiguration.circleAlpha = 0.2
        uiConfiguration.refLocationCircleColor = .red
        uiConfiguration.nearbyFilterViewContainerBackgroundColor = .brown
        uiConfiguration.segmentedControlBackgroundColor = .darkGray
        uiConfiguration.segmentedControlSelectedSegmentTintColor = .orange
        uiConfiguration.segmentedControlSelectedforegroundColor = .red
        uiConfiguration.tableCellSeparatorColor = .white
        uiConfiguration.tableCellBackgroundColor = .darkGray
        uiConfiguration.distanceTextColor = #colorLiteral(red: 0.9375645388, green: 0.9883071891, blue: 1, alpha: 1)
        uiConfiguration.placeNameTextColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        uiConfiguration.placeAddressTextColor = .yellow
        uiConfiguration.paginationContainerViewBackgroundColor = .gray

        configuration.mapmyIndiaNearbyFilterConfiguration = getFilterValue()
        configuration.mapmyIndiaNearbyUIConfiguration = uiConfiguration
        
 
        let customNearbyUIVC = MapmyIndiaNearbyCategoriesViewController()
        customNearbyUIVC.mapmyIndiaNearbyCategoryConfiguration = categoryConfiguration
        customNearbyUIVC.mapmyIndiaNearbyConfiguration = configuration
        self.navigationController?.pushViewController(customNearbyUIVC, animated: false)
    } */
    func converToCoordinate(location: String) -> CLLocationCoordinate2D? {
        let locationString = location.split(separator: ",")
        if locationString.count < 2 {
            return nil
        } else if locationString.count == 2 {
            let latitude: Double = Double(locationString.first!) ?? 0.0
            let longitue: Double = Double(locationString.last!) ?? 0.0
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitue))
            print("coordinate: \(latitude), \(longitue)")
            return coordinate
        } else {
            return nil
        }
    }
    @objc func settingsButtonTapped() {
        let vc = NearbyFilterConfigurationSetting()
        vc.delegate = self
        self.navigationController?.pushViewController(vc, animated: false)
    }

    @objc func launchNearby() {
        let vc = MapmyIndiaNearbyCategoriesViewController()
        let configuration = MapmyIndiaNearbyConfiguration()
        configuration.mapmyIndiaNearbyFilterConfiguration = getFilterValue()
        vc.mapmyIndiaNearbyConfiguration = configuration
        self.navigationController?.pushViewController(vc, animated: false)
    }
    
    func getFilterValue() -> MapmyIndiaNearbyFilterConfiguration {
      
        let configuration = MapmyIndiaNearbyConfiguration()
        let filter = configuration.mapmyIndiaNearbyFilterConfiguration
        filter.radius = radius
        filter.pod = pod
        filter.searchBy = searchby
        filter.sortBy = MapmyIndiaSortByDistanceWithOrder(orderBy: orderby)
        if refLocation != nil && refLocation != "" {
            filter.refLocation = refLocation
        }
        if bound != nil {
            filter.bounds = bound
        }
        filter.bounds = bound
        return filter
        
    }
}
extension NearbyViewControllerLauncher: NearbyFilterConfigurationSettingDelegate {
    
    
    func nearbyFilterConfiguration(radius: String, refLocation: String, pod: MMIPodTypeIdentifier, orderby: MMISortByOrderType, searchby: MMISearchByType, bound:[String] ) {
        self.pod = pod
        self.orderby = orderby
        self.radius = Int(radius) ?? 1000
        self.searchby = searchby
        self.refLocation = refLocation
        var bottomRight: CLLocationCoordinate2D!
        var topLeft: CLLocationCoordinate2D!
        if let topRightStringCoordinate = bound.first, let topLeftStringCoordinate = bound.last {
            topLeft = converToCoordinate(location: topRightStringCoordinate)
            bottomRight = converToCoordinate(location: topLeftStringCoordinate)
            if let topLeft = topLeft ,let bottomRight = bottomRight {
                let b = MapmyIndiaRectangularRegion(topLeft: topLeft, bottomRight: bottomRight)
                self.bound = b
            }
        }
    }
}
