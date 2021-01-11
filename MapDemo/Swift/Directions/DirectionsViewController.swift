import UIKit
import MapmyIndiaMaps
import MapmyIndiaDirections

class DirectionsViewController: UIViewController {
    var mapView: MapmyIndiaMapView!
    var locationsChooserButton: UIButton!
    var indicatorView: UIActivityIndicatorView!
    
    var footerView: UIView!
    var footerViewLabel: UILabel!
    var footerViewButton: UIButton!
    
    var routes = [Route]()
    var selectedRoute:Route?
    let point = MGLPointAnnotation()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Distance Matrix"
        
        self.setupViews()
        self.setupConstraints()
        self.openLocationChooser()
    }
    
    @objc func openLocationChooser() {
        let locationsChooserVC = LocationsChooserTableViewController()
        locationsChooserVC.mode = .direction
        locationsChooserVC.delegate = self
        self.navigationController?.pushViewController(locationsChooserVC, animated: true)
    }
  
    func setupViews() {
        mapView = MapmyIndiaMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.delegate = self
        self.view.addSubview(mapView)
        
        locationsChooserButton = UIButton()
        locationsChooserButton.backgroundColor = .systemBlue
        locationsChooserButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        locationsChooserButton.setTitle("Choose Locations", for: .normal)
        locationsChooserButton.addTarget(self, action: #selector(openLocationChooser), for: .touchUpInside)
        locationsChooserButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(locationsChooserButton)
        
        indicatorView = UIActivityIndicatorView(style: .gray)
        indicatorView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.view.addSubview(indicatorView)
        
        footerView = UIView()
        footerView.isHidden = true
        footerView.backgroundColor = UIColor.lightGray.withAlphaComponent(0.5)
        footerView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(footerView)
        
        footerViewLabel = UILabel()
        footerViewLabel.numberOfLines = 0
        footerViewLabel.translatesAutoresizingMaskIntoConstraints = false
        self.footerView.addSubview(footerViewLabel)
        
        footerViewButton = UIButton()
        footerViewButton.translatesAutoresizingMaskIntoConstraints = false
        footerViewButton.backgroundColor = UIColor.blue
        footerViewButton.layer.borderWidth = 1
        footerViewButton.layer.borderColor = UIColor.white.cgColor
        footerViewButton.setTitle("Directions", for: .normal)
        footerViewButton.addTarget(self, action: #selector(openInstructionsViewController), for: .touchUpInside)
        self.footerView.addSubview(footerViewButton)
    }
    
    func setupConstraints() {
        mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        mapView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        mapView.bottomAnchor.constraint(equalTo: footerView.topAnchor, constant: 0).isActive = true
        mapView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        locationsChooserButton.trailingAnchor.constraint(equalTo: self.view.safeTrailingAnchor, constant: -10).isActive = true
        locationsChooserButton.topAnchor.constraint(equalTo: self.view.safeTopAnchor, constant: 10).isActive = true
        
        indicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
                
        footerView.heightAnchor.constraint(equalToConstant: 120).isActive = true
        footerView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        footerView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: 0).isActive = true
        footerView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        footerViewButton.widthAnchor.constraint(equalToConstant: 100).isActive = true
        footerViewButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
        footerViewButton.centerYAnchor.constraint(equalTo: footerView.centerYAnchor, constant: 0).isActive = true
        footerViewButton.rightAnchor.constraint(equalTo: footerView.rightAnchor, constant: -4).isActive = true
                
        footerViewLabel.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 4).isActive = true
        footerViewLabel.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -4).isActive = true
        footerViewLabel.leftAnchor.constraint(equalTo: footerView.leftAnchor, constant: 4).isActive = true
        footerViewLabel.rightAnchor.constraint(equalTo: footerViewButton.leftAnchor, constant: -4).isActive = true
    }
    
    func callDirections(sourceLocation: String, destinationLocation: String, viaLocations: [String], resource: MBDirectionsResourceIdentifier, profile: MBDirectionsProfileIdentifier) {
        self.clearMap()
        self.routes.removeAll()
        
        let origin = Waypoint(eLoc: sourceLocation, name: "MapmyIndia")
        let destination = Waypoint(eLoc: destinationLocation, name: "")
        let viaPoints = viaLocations.map { (locationString) -> Waypoint in
            Waypoint(eLoc: locationString, name: "")
        }
        origin.allowsArrivingOnOppositeSide = false
        destination.allowsArrivingOnOppositeSide = false
        
        let allWaypoints = [origin] + viaPoints + [destination]
        
        let options = RouteOptions(waypoints: allWaypoints)
        options.routeShapeResolution = .full
        options.includesAlternativeRoutes = true
        
        options.resourceIdentifier = resource
        options.profileIdentifier = profile
        
        footerView.isHidden = true
        indicatorView.isHidden = true
        indicatorView.startAnimating()
        Directions(restKey: MapmyIndiaAccountManager.restAPIKey()).calculate(options) { (waypoints, routes, error) in
            self.indicatorView.isHidden = false
            self.indicatorView.stopAnimating()
            self.footerView.isHidden = false
            
            if let _ = error {
                self.footerViewLabel.text = error?.localizedDescription
                return
            }
            guard let allRoutes = routes, allRoutes.count > 0 else { return }
            
            self.routes = allRoutes
            self.plotRouteOnMap(routeIndex: 0)
            self.footerView.isHidden = false
        }
    }
    
    func plotRouteOnMap(routeIndex: Int){
        var polylines = [CustomPolyline]()
        if self.routes.count > 0 {
            for i in 0...self.routes.count - 1 {
                let route = self.routes[i]
                if let routeCoordinates = route.coordinates {
                    let myPolyline = CustomPolyline(coordinates: routeCoordinates, count: UInt(routeCoordinates.count))
                    myPolyline.routeIndex = i
                    polylines.append(myPolyline)
                    if i == routeIndex {
                        myPolyline.isSelected = true
                        self.selectedRoute = route
                        
                        self.footerView.isHidden = false
                        self.footerViewLabel.text = String(format: "Selected Route:\nDriving Distance: %d meters\nDuration: %d seconds", Int(route.distance), Int(route.expectedTravelTime))
                    } else {
                        self.mapView.addAnnotation(myPolyline)
                    }
                }
            }
            self.mapView.addAnnotation(polylines[routeIndex])
            self.mapView.showAnnotations(polylines, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: false)
            self.selectRoute(route: self.selectedRoute!)
        } else {
            self.clearMap()
        }
    }
    
    func clearMap() {
        if let mapAnnotations = self.mapView.annotations as? MGLAnnotation {
            self.mapView.removeAnnotation(mapAnnotations)
        }
        let polylineAnnotations = mapView.annotations?.filter({ (annotation) -> Bool in
            if annotation is MGLPolyline {
                return true
            }
            return false
        })
        if let polylines = polylineAnnotations {
            self.mapView.removeAnnotations(polylines)
        }
        
    }
    
    func selectRoute(route: Route) {
        point.title = "\(route.expectedTravelTime) seconds"
        if let routeCoordinates = route.coordinates, routeCoordinates.count > 0 {
            if routeCoordinates.count > 2 {
                let midIndex = (routeCoordinates.count/2) - 1
                print("Route Midindex:- \(midIndex)")
                point.coordinate = routeCoordinates[midIndex]
            } else {
                point.coordinate = routeCoordinates[0]
            }
            mapView.addAnnotation(point)
            self.mapView.selectAnnotation(self.point, animated: false)
        }
    }
    
    @objc func openInstructionsViewController(_ sender: UIButton) {
        let instructionTableVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstructionTableVC") as! InstructionTableVC
        instructionTableVC.requiredRoute = selectedRoute
        self.navigationController?.pushViewController(instructionTableVC, animated: true)
    }
}

extension DirectionsViewController: MapmyIndiaMapViewDelegate {
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        // Give our polyline a unique color by checking
        if annotation is MGLPolyline {
            if let customPolyline = annotation as? CustomPolyline, customPolyline.isSelected {
                return .blue
            }
            return .red
        }
        return mapView.tintColor
    }
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        // Set the line width for polyline annotations
        return 10.0
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        // Set the alpha for all shape annotations to 1 (full opacity)
        return 0.6
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        let annotationView = MGLAnnotationView()
        annotationView.isOpaque = true
        return annotationView
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        // Instantiate and return our custom callout view.
        if annotation is MGLPointAnnotation {
            return CustomCalloutViewForPolyline(representedObject: annotation)
        }
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
        if annotation is MGLPolyline {
            if let customPolyline = annotation as? CustomPolyline, !customPolyline.isSelected {
                // Remove existing polylines
                self.clearMap()
                
                // Plot polylines
                if self.routes.count > 0 {
                    plotRouteOnMap(routeIndex: customPolyline.routeIndex)
                    let selectedRoute = self.routes[customPolyline.routeIndex]
                    self.selectRoute(route: selectedRoute)
                }
            }
        }
    }
}

extension DirectionsViewController: LocationsChooserTableViewControllerDelegate {
    func locationsPikcedForDirections(sourceLocation: String, destinationLocation: String, viaLocations: [String], resource: MBDirectionsResourceIdentifier, profile: MBDirectionsProfileIdentifier) {
        self.callDirections(sourceLocation: sourceLocation, destinationLocation: destinationLocation, viaLocations: viaLocations, resource: resource, profile: profile)
    }
    
    func locationsPikcedForDistances(sourceLocations: [String], destinationLocations: [String], resource: MapmyIndiaDistanceMatrixResourceIdentifier, profile: MapmyIndiaDirectionsProfileIdentifier) {
        
    }
}
