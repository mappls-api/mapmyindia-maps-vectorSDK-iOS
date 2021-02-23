import UIKit
import MapmyIndiaMaps
import MapmyIndiaDirections
import MapmyIndiaAPIKit
import MapmyIndiaUIWidgets
import MapmyIndiaDirectionsUI

class DirectionUIViewController: UIViewController {
    
    

    var mapView: MapmyIndiaDirectionsMapView!
    var placeBottomSheet: UIView!
    var placeNameLabel: UILabel!
    var placeAddressLabel: UILabel!
    var eLocIcon: UIButton!
    var eLocLabel: UILabel!
    var destinationDistaceLabel: UILabel!
    var destinationIcon: UIImageView!
    var timeRequiredLabel: UILabel!
    var timeRequiredIcon: UIImageView!
    var directionButton: UIButton!
    let directions: Directions! = nil
    var searchView: UIView!
    var searchTextView: UILabel!
    var crossButton: UIButton!
    var searchButton: UIButton!
    var sideLine: UIButton!
    var  currentLocationButton: UIButton!
    var tableView: UITableView!
    var tableViewheight = 100
    var noLocationButton: UIButton!
    var locationModel = [MapmyIndiaDirectionsLocation]()
    var bottomBannerView: MapmyIndiaDirectionsBottomBannerView!
    var navigationView: UIView!
    var dirAttributions : MBAttributeOptions = []
    
    var waypoints: [Waypoint] = [] {
        didSet {
            waypoints.forEach {
                $0.coordinateAccuracy = -1
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let settingsBarButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped))
        self.navigationItem.rightBarButtonItems = [settingsBarButton]
        
        mapView = MapmyIndiaDirectionsMapView(frame: self.view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.coronaNovalButton.isHidden = true
        mapView.coronaNovalButtonMargins.y = 200
        mapView.delegate = self
        mapView.showsUserLocation = true
        view.addSubview(mapView)
//        self.navigationController?.navigationBar.isHidden = true
        
        setUpSearchViewLayout()
        searchTextView.isUserInteractionEnabled = true
        let gestureRecoognizor = UITapGestureRecognizer(target: self, action: #selector(onSearchViewTaped))
        searchTextView.addGestureRecognizer(gestureRecoognizor)
        
        setUpButtonSheetLayout()
        setUpCurrentLocationLayout()
        setupTestButtonsLayout()
        directionButton.addTarget(self, action: #selector(directionButtonClicked), for: .touchUpInside)
    }
    @objc func settingsButtonTapped(sender: UIBarButtonItem) {
        let vc = LocationChooserTableViewDirectionUIPlugin()
        vc.delegate = self
        navigationController?.pushViewController(vc, animated: false)
    }
    
    override func viewDidLayoutSubviews() {
        directionButton.setGradientBackground(firstColor: UIColor(rgb: 0xE52629), secondColor: UIColor(rgb: 0xEC672C))
        currentLocationButton.layer.cornerRadius = currentLocationButton.bounds.width / 2
        currentLocationButton.tintColor = .black
    }
    
    func removeAllAnnotations() {
        guard let annotations = mapView.annotations else { return print("Annotations Error") }
        
        if annotations.count != 0 {
            for annotation in annotations {
                mapView.removeAnnotation(annotation)
            }
        } else {
            return
        }
    }
    
    
    func setUpSearchViewLayout(){
        
        searchView = UIView()
        mapView.addSubview(searchView)
        
        noLocationButton = UIButton()
        noLocationButton.setImage(UIImage(named: "ic_home_directions_accent_28"), for: .normal)
        noLocationButton.addTarget(self, action: #selector(noLocationButtonClicked), for: .touchUpInside)
        searchView.addSubview(noLocationButton)
        
        searchTextView = UILabel()
        searchView.addSubview(searchTextView)
        
        searchView.translatesAutoresizingMaskIntoConstraints = false
        searchView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        searchView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        searchView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        searchView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        if #available(iOS 11.0, *) {
            searchView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        } else {
            searchView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 20).isActive = true
        }
        searchView.backgroundColor = UIColor.white
        searchView.layer.cornerRadius = 4

        noLocationButton.translatesAutoresizingMaskIntoConstraints = false
        noLocationButton.trailingAnchor.constraint(equalTo: searchView.trailingAnchor, constant: -7).isActive = true
        noLocationButton.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        noLocationButton.widthAnchor.constraint(equalToConstant: 30).isActive = true
       
        searchTextView.translatesAutoresizingMaskIntoConstraints = false
        searchTextView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        searchTextView.trailingAnchor.constraint(equalTo: noLocationButton.leadingAnchor).isActive = true
        searchTextView.leadingAnchor.constraint(equalTo: searchView.leadingAnchor, constant: 7).isActive = true
        searchTextView.centerYAnchor.constraint(equalTo: searchView.centerYAnchor).isActive = true
        searchTextView.text = "Search for place & eLocs"
        searchTextView.textColor = UIColor.gray
    }
    
    @objc func onSearchViewTaped() {
        let autocompleteViewController = getAutocompleteViewControllerInstance()
        self.navigationController?.navigationBar.isHidden = false
        
        autocompleteViewController.delegate = self
        if let navigation = self.navigationController {
            navigation.pushViewController(autocompleteViewController, animated: true)
        }
        else {
            self.present(autocompleteViewController, animated: false, completion: nil)
        }
    }
    
    @objc func directionButtonClicked() {
        let sy = DefaultStyle.init()
        let directionVC = MapmyIndiaDirectionsViewController(for: locationModel, style: sy)
        directionVC.delegate = self
        makeAttributionArray()
        directionVC.attributationOptions = dirAttributions
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(directionVC, animated: false)
    }
    @objc func noLocationButtonClicked() {
        locationModel.removeAll()
        let sy = DefaultStyle.init()
        let directionVC = MapmyIndiaDirectionsViewController(for: locationModel, style: sy)
        makeAttributionArray()
        directionVC.attributationOptions = dirAttributions
        directionVC.delegate = self
        self.navigationController?.pushViewController(directionVC, animated: false)
        self.navigationController?.navigationBar.isHidden = true
    }
    private func getAutocompleteViewControllerInstance() -> MapmyIndiaAutocompleteViewController {
        let autocompleteViewController = MapmyIndiaAutocompleteViewController()
        autocompleteViewController.delegate = self
        return autocompleteViewController
    }
    
    func setUpButtonSheetLayout() {
        placeBottomSheet = UIView()
        directionButton = UIButton()
        eLocIcon = UIButton()
        eLocLabel = UILabel()
        timeRequiredLabel = UILabel()
        timeRequiredIcon = UIImageView(image: UIImage(named: "timeRemening_icon"))
        destinationDistaceLabel = UILabel()
        destinationIcon = UIImageView(image: UIImage(named: "timeRemening_icon"))
        placeAddressLabel = UILabel()
        placeNameLabel = UILabel()
        
        mapView.addSubview(placeBottomSheet)
        placeBottomSheet.addSubview(directionButton)
        placeBottomSheet.addSubview(eLocIcon)
        placeBottomSheet.addSubview(eLocLabel)
        placeBottomSheet.addSubview(timeRequiredLabel)
        placeBottomSheet.addSubview(timeRequiredIcon)
        placeBottomSheet.addSubview(destinationDistaceLabel)
        placeBottomSheet.addSubview(destinationIcon)
        placeBottomSheet.addSubview(placeAddressLabel)
        placeBottomSheet.addSubview(placeNameLabel)
        
        placeBottomSheet.translatesAutoresizingMaskIntoConstraints = false
        placeBottomSheet.heightAnchor.constraint(equalToConstant: 190).isActive = true
        placeBottomSheet.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        placeBottomSheet.topAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
        placeBottomSheet.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        placeBottomSheet.backgroundColor = UIColor.white
        
        directionButton.translatesAutoresizingMaskIntoConstraints = false
        directionButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        directionButton.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
        directionButton.bottomAnchor.constraint(equalTo: placeBottomSheet.bottomAnchor, constant: -7).isActive = true
        directionButton.leadingAnchor.constraint(equalTo: placeBottomSheet.leadingAnchor, constant: 30).isActive = true
        directionButton.trailingAnchor.constraint(equalTo: placeBottomSheet.trailingAnchor, constant: -30).isActive = true
        directionButton.setTitle("Directions", for: .normal)
        
        directionButton.layer.cornerRadius = 7
        directionButton.setImage(UIImage(named: "ic_directions_24px"), for: .normal)
        directionButton.imageEdgeInsets = UIEdgeInsets(top: 0, left: self.view.bounds.width -  90  , bottom: 0, right: 0)
        
        eLocIcon.translatesAutoresizingMaskIntoConstraints = false
        eLocIcon.leadingAnchor.constraint(equalTo: placeBottomSheet.leadingAnchor,constant: 10).isActive = true
        eLocIcon.bottomAnchor.constraint(equalTo: directionButton.topAnchor,constant: -20).isActive = true
        eLocIcon.tintColor = .black
        eLocIcon.backgroundColor = .white
        eLocIcon.setImage(UIImage(named: "eloc_icon"), for: .normal)
                
        eLocLabel.translatesAutoresizingMaskIntoConstraints = false
        eLocLabel.attributedText = NSAttributedString(string: "eLoc.me/9082EO", attributes:
            [.underlineStyle: NSUnderlineStyle.single.rawValue])
        eLocLabel.leadingAnchor.constraint(equalTo: eLocIcon.trailingAnchor,constant: 0).isActive = true
        eLocLabel.centerYAnchor.constraint(equalTo: eLocIcon.centerYAnchor).isActive = true
        eLocLabel.textColor = .systemBlue
        eLocLabel.font = UIFont.init(name: "SFProText-Medium", size: 11)
        
        timeRequiredLabel.translatesAutoresizingMaskIntoConstraints = false
        timeRequiredLabel.trailingAnchor.constraint(equalTo: placeBottomSheet.trailingAnchor, constant: -10).isActive = true
        timeRequiredLabel.centerYAnchor.constraint(equalTo: eLocLabel.centerYAnchor).isActive = true
        timeRequiredLabel.textColor = .black
        timeRequiredLabel.text = "9 mins(s)"
        timeRequiredLabel.font = UIFont.init(name: "SFProText-Medium", size: 13)
        
        timeRequiredIcon.translatesAutoresizingMaskIntoConstraints = false
        timeRequiredIcon.trailingAnchor.constraint(equalTo: timeRequiredLabel.leadingAnchor, constant: -3).isActive = true
        timeRequiredIcon.centerYAnchor.constraint(equalTo: eLocLabel.centerYAnchor).isActive = true
        
        destinationDistaceLabel.translatesAutoresizingMaskIntoConstraints = false
        destinationDistaceLabel.trailingAnchor.constraint(equalTo: placeBottomSheet.trailingAnchor, constant: -10).isActive = true
        destinationDistaceLabel.bottomAnchor.constraint(equalTo: eLocLabel.topAnchor, constant: -7).isActive = true
        destinationDistaceLabel.textColor = .black
        destinationDistaceLabel.text = "3.0 Kms"
        destinationDistaceLabel.font = UIFont.init(name: "SFProText-Medium", size: 16)
        
        destinationIcon.translatesAutoresizingMaskIntoConstraints = false
        destinationIcon.trailingAnchor.constraint(equalTo: destinationDistaceLabel.leadingAnchor, constant: -3).isActive = true
        destinationIcon.centerYAnchor.constraint(equalTo: destinationDistaceLabel.centerYAnchor).isActive = true
        
        placeAddressLabel.translatesAutoresizingMaskIntoConstraints = false
        placeAddressLabel.leadingAnchor.constraint(equalTo: placeBottomSheet.leadingAnchor,constant: 10).isActive = true
        placeAddressLabel.bottomAnchor.constraint(equalTo: destinationIcon.topAnchor, constant: -10).isActive = true
        placeAddressLabel.text = "Sector 13, Hisar, Haryana, 125001"
        placeAddressLabel.textColor = .black
        placeAddressLabel.font = UIFont.init(name: "SFProText-Medium", size: 16)
        
        placeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        placeNameLabel.leadingAnchor.constraint(equalTo: placeBottomSheet.leadingAnchor,constant: 10).isActive = true
        placeNameLabel.bottomAnchor.constraint(equalTo: placeAddressLabel.topAnchor, constant: -7).isActive = true
        placeNameLabel.text = "Dabar Chowk Park"
        placeNameLabel.textColor = .black
        placeNameLabel.font = UIFont.boldSystemFont(ofSize: 18)
    }
    
    func setupTestButtonsLayout() {
     /*   let testButton1 = UIButton()
        testButton1.setTitle("Test with source & destination", for: .normal)
        testButton1.backgroundColor = .brown
        testButton1.addTarget(self, action: #selector(testButton1Clicked), for: .touchUpInside)
        self.view.addSubview(testButton1)
        
        let testButton2 = UIButton()
        testButton2.setTitle("Test with one waypoint", for: .normal)
        testButton2.backgroundColor = .darkGray
        testButton2.addTarget(self, action: #selector(testButton2Clicked), for: .touchUpInside)
        self.view.addSubview(testButton2)

        testButton1.translatesAutoresizingMaskIntoConstraints = false
        testButton1.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        testButton1.topAnchor.constraint(equalTo: searchView.bottomAnchor, constant: 60).isActive = true
        testButton1.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        testButton2.translatesAutoresizingMaskIntoConstraints = false
        testButton2.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
        testButton2.topAnchor.constraint(equalTo: testButton1.bottomAnchor, constant: 10).isActive = true
        testButton2.heightAnchor.constraint(equalToConstant: 30).isActive = true */
      
//        let customThemeWithTwoWayPoint = UIButton()
//        customThemeWithTwoWayPoint.setTitle("Custom Theme With Waypoints", for: .normal)
//        customThemeWithTwoWayPoint.backgroundColor = .gray
//        self.view.addSubview(customThemeWithTwoWayPoint)
//
//        customThemeWithTwoWayPoint.translatesAutoresizingMaskIntoConstraints = false
//        customThemeWithTwoWayPoint.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20).isActive = true
//        customThemeWithTwoWayPoint.topAnchor.constraint(equalTo: self.searchView.bottomAnchor, constant: 10).isActive = true
//        customThemeWithTwoWayPoint.heightAnchor.constraint(equalToConstant: 30).isActive = true
//        customThemeWithTwoWayPoint.addTarget(self, action: #selector(customThemeTest), for: .touchUpInside)
 
    }
     
   /* @objc func customThemeTest() {
        locationModel.removeAll()
        let locationModel = MapmyIndiaDirectionsLocation(location: "77.2639,28.5354", displayName: "Govindpuri", displayAddress: "", locationType: .suggestion)
        let locationModel1 = MapmyIndiaDirectionsLocation(location: "85.5013,26.5887", displayName: "Sitamarhi", displayAddress: "", locationType: .suggestion)
        self.locationModel.append(locationModel)
        self.locationModel.append(locationModel1)
        
        let directionVC = MapmyIndiaDirectionsViewController(for: self.locationModel, style: NightStyle.init())
        MapmyIndiaDirectionsBottomBannerView.appearance().backgroundColor = .gray
        MapmyIndiaDirectionsTopBannerView.appearance().backgroundColor = .blue
        directionVC.resourceIdentifier = MBDirectionsResourceIdentifier(UserDefaultsManager.resourceIdentifier)
        directionVC.profileIdentifier = MBDirectionsProfileIdentifier(UserDefaultsManager.profileIdentifier)
        directionVC.delegate = self
        
        
        self.navigationController?.navigationBar.isHidden = true
        self.navigationController?.pushViewController(directionVC, animated: false)
    } */
    
    func setUpCurrentLocationLayout() {
        currentLocationButton = UIButton()
        
        mapView.addSubview(currentLocationButton)
        currentLocationButton.translatesAutoresizingMaskIntoConstraints = false
        currentLocationButton.bottomAnchor.constraint(equalTo: placeBottomSheet.topAnchor, constant: -70).isActive = true
        currentLocationButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -30).isActive = true
        currentLocationButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        currentLocationButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        currentLocationButton.tintColor = .black
        currentLocationButton.setImage(UIImage(named: "FocusCurrentLocation"), for: .normal)
        currentLocationButton.backgroundColor = .white
        
        currentLocationButton.addTarget(self, action: #selector(currentLocationTapHandler(sender:)), for: .allEvents)
    }
    
    func bottomViewAnimateUp() {
        UIView.animate(withDuration: 0.2 , animations: {
            self.placeBottomSheet.transform = CGAffineTransform(translationX: 0, y: -190)
            self.mapView.logoView.transform = CGAffineTransform(translationX: 0, y: -160)
            self.currentLocationButton.transform = CGAffineTransform(translationX: 0, y: -160)
        })
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
    
    @objc func currentLocationTapHandler(sender: UIGestureRecognizer) {
        let userLocation = mapView.userLocation?.location?.coordinate
        print("userlocation \(String(describing: userLocation))")
        if mapView.userLocation?.location != nil {
            let coor = mapView.userLocation?.coordinate
            let initialCorr = CLLocationCoordinate2D(latitude: CLLocationDegrees(coor?.latitude ?? 00) , longitude: CLLocationDegrees(coor?.longitude ?? 00))
            
            mapView.setCenter(initialCorr, zoomLevel: 7, animated: false)
            let camera = MGLMapCamera(lookingAtCenter: mapView.centerCoordinate, altitude: 4500, pitch: 15, heading: 180)
            mapView.setCamera(camera, withDuration: 2, animationTimingFunction: CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut))
        }
        else{
            guard URL(string: UIApplication.openSettingsURLString) != nil else {
                return
            }
            
            let alertController = UIAlertController (title: "Turn on location", message: "Go to Settings? turn on location", preferredStyle: .alert)
            
            let settingsAction = UIAlertAction (title: "Settings", style: .default) { (_) -> Void in
                
                guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                    return
                }
                
                if UIApplication.shared.canOpenURL(settingsUrl) {
                    if #available(iOS 10.0, *) {
                        UIApplication.shared.open(settingsUrl, completionHandler: { (success) in
                            print("Settings opened: \(success)") // Prints true
                        })
                    } else {
                        // Fallback on earlier versions
                    }
                }
            }
            alertController.addAction(settingsAction)
            let cancelAction = UIAlertAction(title: "Cancel", style: .default, handler: nil)
            alertController.addAction(cancelAction)
            self.navigationController?.present(alertController, animated: true, completion: nil)
        }
    }
}

extension DirectionUIViewController: MapmyIndiaMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        print(userLocation ?? 00)
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
    }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        var annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: "pisa")
        if annotationImage == nil {
        }
        
        return annotationImage
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}

extension DirectionUIViewController: MapmyIndiaAutocompleteViewControllerDelegate {
    func didAutocomplete(viewController: MapmyIndiaAutocompleteViewController, withPlace place: MapmyIndiaAtlasSuggestion) {
        navigationController?.navigationBar.isHidden = true
        navigationController?.popViewController(animated: false)
        searchTextView.text = place.placeAddress
        placeAddressLabel.text = place.placeAddress
        placeNameLabel.text = place.placeName
        eLocLabel.text = "eloc.me/\(String(describing: place.eLoc ?? "create eLoc"))"
        
        
        removeAllAnnotations()
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(truncating: place.latitude!), longitude: CLLocationDegrees(truncating: place.longitude!))
        mapView.addAnnotation(point)
        bottomViewAnimateUp()
        
        let userLocationObject = CLLocation(latitude: CLLocationDegrees(truncating: place.latitude!), longitude: CLLocationDegrees(truncating: place.longitude!))
        let wayPoints = Waypoint(location: userLocationObject, name: "\(place.placeName ?? "not found")")
        self.locationModel.removeAll()
        var location: String = ""
        if let lon = place.longitude , let lat = place.latitude {
            location = "\(lon),\(lat)"
            mapView.setCenter(CLLocationCoordinate2D(latitude: CLLocationDegrees(truncating: place.latitude!), longitude: CLLocationDegrees(truncating: place.longitude!)), zoomLevel: 13, animated: false)
        } else {
            if let eloc = place.eLoc {
                location = "\(eloc)"
                mapView.setMapCenterAtEloc(eloc, zoomLevel: 13, animated: false, completionHandler: nil)
            }
        }

        let locationModel = MapmyIndiaDirectionsLocation(location: location, displayName: place.placeName, displayAddress: place.placeAddress, locationType: .suggestion)
        self.locationModel.insert(locationModel, at: 0)
        waypoints.append(wayPoints)
    }
    
    func didFailAutocomplete(viewController: MapmyIndiaAutocompleteViewController, withError error: NSError) {
        
    }
    
    func wasCancelled(viewController: MapmyIndiaAutocompleteViewController) {
        self.navigationController?.navigationBar.isHidden = true
    }
}


extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}


extension DirectionUIViewController: LocationChooserTableViewDirectionUIPluginDelegate {
    func locationsPikcedForDistancesUI(sourceLocations: [String], destinationLocations: [String], resource: MapmyIndiaDistanceMatrixResourceIdentifier, profile: MapmyIndiaDirectionsProfileIdentifier) {
    }
    
    func locationsPikcedForDirectionsUI(sourceLocation: MapmyIndiaDirectionsLocation, destinationLocation: MapmyIndiaDirectionsLocation, viaLocations: [MapmyIndiaDirectionsLocation], resource: MBDirectionsResourceIdentifier, profile: MBDirectionsProfileIdentifier, attributions: MBAttributeOptions) {
        
        var source = [MapmyIndiaDirectionsLocation]()
        source.append(sourceLocation)
        
        var destinations = [MapmyIndiaDirectionsLocation]()
        destinations.append(destinationLocation)
        
        var viaPoint = [MapmyIndiaDirectionsLocation]()
        viaPoint = viaLocations
        let locations = source + viaPoint + destinations
        let style1 = DefaultStyle.init()
        let directions = MapmyIndiaDirectionsViewController(for: locations, style: style1)
        directions.delegate = self
        directions.profileIdentifier = profile
        directions.resourceIdentifier = resource
        directions.attributationOptions = attributions
        self.navigationController?.pushViewController(directions, animated: false)
        self.navigationController?.navigationBar.isHidden = true
        
        
    }
}
extension DirectionUIViewController : MapmyIndiaDirectionsViewControllerDelegate {
    func didRequestForGoBack(for view: MapmyIndiaDirectionsTopBannerView) {
        self.navigationController?.navigationBar.isHidden = false
    }
    
    func didRequestForAddViapoint(_ sender: UIButton, for isEditMode: Bool) {
        
    }
    
    func didRequestDirections() {
        
    }
    
    func didRequestForStartNavigation(for index: Int) {
        
    }
    
    
}
