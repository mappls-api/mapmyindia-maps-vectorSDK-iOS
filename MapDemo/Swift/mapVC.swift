//
//  mapVC.swift
//  MapDemo
//
//  Created by CE Info on 30/07/18.
//  Copyright © 2018 MMI. All rights reserved.
//

import UIKit
import Mapbox
import MapmyIndiaAPIKit
import MapboxDirections
import MapmyIndiaFeedbackUIKit

class mapVC: UIViewController, MapmyIndiaMapViewDelegate,AutoSuggestDelegates {
    func suggestionSelected(suggestion: MapmyIndiaAtlasSuggestion, placeName: String) {
         if let lat = suggestion.latitude, let lng = suggestion.longitude {
                   let coordinates = CLLocationCoordinate2DMake(CLLocationDegrees(truncating: lat),CLLocationDegrees(truncating: lng))
                   let annotation = MGLPointAnnotation()
                   annotation.coordinate = coordinates
                   mapView.addAnnotation(annotation)
                   mapView.centerCoordinate = coordinates
                   customSearchLabel.text = placeName
               }
    }
    
    @IBOutlet weak var btn_Instruction: UIButton!
    @IBOutlet weak var customGeocodeTextField: UITextField!
    @IBOutlet weak var customGeocodeUI: UIView!
    @IBOutlet weak var mapView: MapmyIndiaMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var constraintSearchBarHeight: NSLayoutConstraint!
    @IBOutlet weak var tableViewAutoSuggest: UITableView!
    @IBOutlet weak var vwFooter: UIView!
    @IBOutlet weak var lblInfo: UILabel!
    @IBOutlet weak var feedbackButton: UIButton!
    
    @IBAction func feedbackButtonPressed(_ sender: UIButton) {
        feedbackButtonHandler()
    }
    
    @IBOutlet weak var customSearchUI: UIView!
    @IBOutlet weak var customSearchLabel: UILabel!
    @IBAction func customSearch_btn(_ sender: UIButton) {
        customSearchLabel.text = ""
               if mapView.annotations!.count > 0{
                   mapView.removeAnnotations(mapView!.annotations!)
               }
    }
    
    @IBAction func customGeocode_btn(_ sender: UIButton) {
        let geocodeManager = MapmyIndiaAtlasGeocodeManager.shared
        let forOptions = MapmyIndiaAtlasGeocodeOptions(query: customGeocodeTextField.text ?? "", withRegion: .india)
        forOptions.maximumResultCount = 5
        geocodeManager.getGeocodeResults(forOptions) { (response,
            error) in
            DispatchQueue.main.async {
                if let error = error {
                    NSLog("%@", error)
                } else if let result = response, let placemarks = result.placemarks , placemarks.count > 0{
                    print("Forward Geocode: \(String(describing: placemarks[0].latitude)),\(String(describing: placemarks[0].longitude))")
                    print(placemarks[0].formattedAddress as Any)
                    self.mapView.removeAnnotations(self.mapView.annotations ??  [MGLAnnotation]())
                    let point = MGLPointAnnotation()
                    point.coordinate = CLLocationCoordinate2D(latitude: Double (truncating: placemarks[0].latitude!), longitude:
                        Double (truncating: placemarks[0].longitude!))
                    point.title = placemarks[0].formattedAddress
                    self.mapView.addAnnotation(point)
                    self.mapView.setCenter(CLLocationCoordinate2D(latitude: Double (truncating: placemarks[0].latitude!), longitude:Double (truncating: placemarks[0].longitude!)), zoomLevel: 11, animated: false)
                } else {
                    print("No results")
                }
            }
        }
    }
    
    @IBAction func btn_Instruction(_ sender: UIButton) {
        let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "InstructionTableVC") as! InstructionTableVC
        vctrl.requiredRoute = selectedRoute
        self.navigationController?.pushViewController(vctrl, animated: true)
    }
    
    let referenceLocation = CLLocation(latitude: 28.550667, longitude: 77.268959)
    var selectedRoute:Route?
    var searchSuggestions = [MapmyIndiaAtlasSuggestion]()
    var tempAnnotations = [MGLPointAnnotation]()
    var routes = [Route]()
    var routeAdvices = [MapmyIndiaTripAdvice]()
    var placemark: MapmyIndiaPlacemark?
    var routeStepArray = [RouteStep]()
    var requiredRouteStepsArray = [RouteStep]()
    let point = MGLPointAnnotation()
    var isForCustomAnnotationView = false
    var isCustomCalloutForPolyline = false
    var strType:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = strType
        self.mapView.delegate = self
        self.mapView.minimumZoomLevel = 4
        customSearchUI.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTap)))
        if strType != "AutoSuggest"{
             self.customSearchUI.isHidden = true
        }
        if strType != "Geocoding (Forward Geocode)"{
            self.customGeocodeUI.isHidden = true
        }
        if strType != "Route Advance" && strType != "Route Advance ETA"{
            self.btn_Instruction.isHidden = true
        }else{
            mapView.bringSubviewToFront(btn_Instruction)
        }
      }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @objc func handleTap(){
        if let vctrl = (UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AutoSuggestVC") as? AutoSuggestVC) {
            let navController = UINavigationController(rootViewController: vctrl)
            if let userLocation = mapView.userLocation {
                vctrl.centerCoordinate = userLocation.coordinate
            } else {
                vctrl.centerCoordinate = mapView.centerCoordinate
            }
            vctrl.delegate = self
            vctrl.mapZoomLevel = mapView.zoomLevel
            self.present(navController, animated: true, completion: nil)
            //self.navigationController?.pushViewController(vctrl, animated: true)
        }
    }
    
    func setData()  {
        self.title = strType
        
        switch strType {
        case "Zoom Level":
            mapView.setCenter(CLLocationCoordinate2DMake(28.550667, 77.268959), animated: false)
            mapView.zoomLevel = 15
            break
        case "Zoom Level With Animation":
            mapView.setCenter(CLLocationCoordinate2DMake(28.550667, 77.268959), animated: false)
            mapView.zoomLevel = 15
            feedbackButton.setTitle("Start Zoom", for: .normal)
            feedbackButton.isHidden = false
            feedbackButton.addTarget(self, action: #selector(zoomWithAnimation), for: .touchUpInside)
            break
        case "Center With Animation":
            mapView.setCenter(CLLocationCoordinate2DMake(28.550667, 77.268959), animated: false)
            mapView.zoomLevel = 15
            feedbackButton.setTitle("Start Center", for: .normal)
            feedbackButton.isHidden = false
            feedbackButton.addTarget(self, action: #selector(centerWithAnimation), for: .touchUpInside)
            break
        case "Current Location":
            self.mapView.showsUserLocation = true
            break
        case "Tracking Mode":
            mapView.userTrackingMode = .followWithCourse
            break
        case "Add Marker":
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: 28.550834, longitude:
                77.268918)
            point.title = "Annotation"
            mapView.addAnnotation(point)
            break
        case "Add Multiple Markers With Bounds":
            var annotations = [MGLPointAnnotation]()
            
            let coordinates = [
                CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918),
                CLLocationCoordinate2D(latitude: 28.551059, longitude: 77.268890),
                CLLocationCoordinate2D(latitude: 28.550938, longitude: 77.267641),
                CLLocationCoordinate2D(latitude: 28.551764, longitude: 77.267575),
                CLLocationCoordinate2D(latitude: 28.552068, longitude: 77.267599),
                CLLocationCoordinate2D(latitude: 28.553836, longitude: 77.267450),
                ]
            for coordinate in coordinates {
                let annotation = MGLPointAnnotation()
                annotation.coordinate = coordinate
                annotations.append(annotation)
            }
            self.mapView.addAnnotations(annotations)
            self.mapView.showAnnotations(annotations, animated: true)
            break
        case "Remove Marker":
            let point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: 28.550834, longitude:
                77.268918)
            point.title = "Annotation"
            mapView.addAnnotation(point)
            
            mapView.removeAnnotation(point) // to remove a single marker
//            mapView.removeAnnotations(point) // to clear multiple markers on map
        case "Polyline":
            var coordinates = [
                CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918),
                CLLocationCoordinate2D(latitude: 28.551059, longitude: 77.268890),
                CLLocationCoordinate2D(latitude: 28.550938, longitude: 77.267641),
                CLLocationCoordinate2D(latitude: 28.551764, longitude: 77.267575),
                CLLocationCoordinate2D(latitude: 28.552068, longitude: 77.267599),
                CLLocationCoordinate2D(latitude: 28.553836, longitude: 77.267450),
                ]
            let polyline = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
            mapView.addAnnotation(polyline)
            let shapeCam = mapView.cameraThatFitsShape(polyline, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            mapView.setCamera(shapeCam, animated: false)
            break
        case "Polygons":
            var coordinates = [
                CLLocationCoordinate2D(latitude: 28.550834, longitude:
                    77.268918),
                CLLocationCoordinate2D(latitude: 28.551059, longitude:
                    77.268890),
                CLLocationCoordinate2D(latitude: 28.550938, longitude:
                    77.267641),
                CLLocationCoordinate2D(latitude: 28.551764, longitude:
                    77.267575),
                CLLocationCoordinate2D(latitude: 28.552068, longitude:
                    77.267599),
                CLLocationCoordinate2D(latitude: 28.553836, longitude:
                    77.267450)
                ]
            let polygon = MGLPolygon(coordinates: &coordinates, count:UInt(coordinates.count))
            mapView.addAnnotation(polygon)
            let shapeCam = mapView.cameraThatFitsShape(polygon, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            mapView.setCamera(shapeCam, animated: false)
            break
        case "Circles":
            let circleCoordinates = InteriorPolygonExample_Swift.polygonCircleForCoordinate(coordinate: CLLocationCoordinate2D(latitude: 28.550834, longitude:
                77.268918), withMeterRadius: 100)
            let polygon = MGLPolygon(coordinates: circleCoordinates, count: UInt(circleCoordinates.count))
            mapView.addAnnotation(polygon)
            let shapeCam = mapView.cameraThatFitsShape(polygon, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            mapView.setCamera(shapeCam, animated: false)
            break
        case "Autosuggest":
             self.customSearchUI.isHidden = false
             mapView.setCenter(referenceLocation.coordinate, animated: false)
             mapView.zoomLevel = 16
             let annotation = MGLPointAnnotation()
             annotation.coordinate = referenceLocation.coordinate
             mapView.addAnnotation(annotation)
             break
        case "Geocoding (Forward Geocode)":
           // searchBar.isHidden = true
            self.customGeocodeUI.isHidden = false
           // self.constraintSearchBarHeight.constant = 65
            self.searchBar.delegate = self
            searchBar.text = "MapmyIndia, Okhla"
            let geocodeManager = MapmyIndiaGeocodeManager.shared
            let forOptions = MapmyIndiaForwardGeocodeOptions(query: searchBar.text!, withRegion: .india)
            forOptions.pincode = "110020"
            geocodeManager.geocode(forOptions) { (placemarks, attribution,
                error) in
                if let error = error {
                    NSLog("%@", error)
                } else if let placemarks = placemarks, !placemarks.isEmpty {
                    print("Forward Geocode: \(placemarks[0].latitude ?? ""),\(placemarks[0].longitude ?? "")")
                    print(placemarks[0].formattedAddress as Any)
                    self.mapView.removeAnnotations(self.mapView.annotations ??  [MGLAnnotation]())
                    let point = MGLPointAnnotation()
                    point.coordinate = CLLocationCoordinate2D(latitude: Double (placemarks[0].latitude ?? "")!, longitude:
                        Double (placemarks[0].longitude ?? "")!)
                    point.title = placemarks[0].formattedAddress
                    self.mapView.addAnnotation(point)
                    self.mapView.setCenter(CLLocationCoordinate2D(latitude: Double (placemarks[0].latitude ?? "")!, longitude:Double (placemarks[0].longitude ?? "")!), zoomLevel: 17, animated: false)
                    
                } else {
                    print("No results")
                }
            }
        case "Atlas Geocode":
            callAtlasGeocode()
            break
        case "Reverse Geocoding":
            let singleTap = UITapGestureRecognizer(target: self, action:
                #selector(didTapMap(tap:)))
            mapView.addGestureRecognizer(singleTap)
            break
        case "Nearby Search":
            searchBar.isHidden = false
            searchBar.delegate = self
            self.constraintSearchBarHeight.constant = 65
            mapView.addSubview(searchBar)
            searchBar.isUserInteractionEnabled = true
            searchBar.placeholder = "Type Here eg:- Shoes/Hotels"
            mapView.setCenter(referenceLocation.coordinate, animated: false)
            mapView.zoomLevel = 16
            let annotation = MGLPointAnnotation()
            annotation.coordinate = referenceLocation.coordinate
            mapView.addAnnotation(annotation)
            break
            
        case "Place/eLoc Detail":
            searchBar.isHidden = false
            self.constraintSearchBarHeight.constant = 65
            searchBar.isUserInteractionEnabled = false
            searchBar.text = "mmi000"
            mapView.addSubview(searchBar)
            let placeDetailManager = MapmyIndiaPlaceDetailManager.shared
            let placeOptions = MapmyIndiaPlaceDetailGeocodeOptions(placeId:
                searchBar.text!, withRegion: .india)
            placeDetailManager.getPlaceDetail(placeOptions) { (placemarks,
                attribution, error) in
                if let error = error {
                    NSLog("%@", error)
                } else if let placemarks = placemarks, !placemarks.isEmpty {
                    print("Place Detail Geocode: \(placemarks[0].latitude ?? ""),\(placemarks[0].longitude ?? "")")
                    print(placemarks[0].formattedAddress as Any)
                    
                    let point = MGLPointAnnotation()
                    point.coordinate = CLLocationCoordinate2D(latitude: Double (placemarks[0].latitude ?? "")!, longitude:
                        Double (placemarks[0].longitude ?? "")!)
                    point.title = placemarks[0].formattedAddress
                    self.mapView.addAnnotation(point)
                    self.mapView.setCenter(CLLocationCoordinate2D(latitude: Double (placemarks[0].latitude ?? "")!, longitude:Double (placemarks[0].longitude ?? "")!), zoomLevel: 11, animated: false)
                    self.placemark = placemarks[0]
                    self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Detail", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.showPlaceDetail))
                } else {
                    print("No results")
                }
            }
            
            break
        case "Driving Distance":
//
//            let singleTap = UITapGestureRecognizer(target: self, action:
//                #selector(didTapMap(tap:)))
//            mapView.addGestureRecognizer(singleTap)

            let distanceManager = MapmyIndiaDrivingDistanceManager.shared
            let distanceOptions = MapmyIndiaDrivingDistanceOptions(center:
                CLLocation(latitude: 28.543014, longitude: 77.242342), points:
                [CLLocation(latitude: 28.520638, longitude: 77.201959)])
            
            var point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: 28.543014, longitude:77.242342)
            self.mapView.addAnnotation(point)
            tempAnnotations.append(point)
            
            point = MGLPointAnnotation()
            point.coordinate = CLLocationCoordinate2D(latitude: 28.520638, longitude:77.201959)
            self.mapView.addAnnotation(point)
            tempAnnotations.append(point)
            
            self.mapView.showAnnotations(tempAnnotations, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
            
            distanceManager.getResult(distanceOptions) { (placemarks,
                attribution, error) in
                if let error = error {
                    NSLog("%@", error)
                } else if let placemarks = placemarks, !placemarks.isEmpty {
                    print("Driving Distance: \(String(describing: placemarks[0].duration)),\(String(describing: placemarks[0].length))")
                    print("\(String(describing: placemarks[0].duration))")
                    
                    self.vwFooter.isHidden = false
                    self.lblInfo.text = String(format: "Driving Distance: %d m, Duration: %d sec " ,placemarks[0].length?.intValue ?? 0 , placemarks[0].duration?.intValue ?? 0)
                    
                } else {
                    print("No results")
                }
            }
            break
        case "Distance Matrix":
            callDistanceMatrix(isETA: false)
            break
        case "Distance Matrix ETA":
            callDistanceMatrix(isETA: true)
            break
        case "Route":
            self.routeAdvices = [MapmyIndiaTripAdvice]()
            
            let routeTripManager = MapmyIndiaRouteTripManager.shared
            let routeOptions = MapmyIndiaRouteTripOptions(startLocation:
                CLLocation(latitude: 13.038536, longitude: 80.246834), destinationLocation:
                CLLocation(latitude: 13.009697, longitude: 80.213878))
            routeOptions.withAdvices = true
            routeOptions.withAlternatives = true
            routeOptions.avoids = .avoidToll
            routeOptions.routeType = .shortest
            routeOptions.vehicleType = .passenger
            routeTripManager.getResult(routeOptions) { (result, attribution,
                error) in
                if let error = error {
                    NSLog("%@", error)
                } else if let result = result {
                    print("Driving Route: \(String(describing: result.status))")
                    if let alternatives = result.alternatives, !alternatives.isEmpty {
                        print("Driving Route Alternatives: \(String(describing: alternatives[0].duration)),\(String(describing: alternatives[0].length))")
                    }
                    if let trips = result.trips, !trips.isEmpty {
                        print("Driving Route Trips: \(String(describing: trips[0].duration)),\(String(describing: trips[0].length))")
                        
                        if let setPolyline = trips[0].pts, !setPolyline.isEmpty {
                            let coordinates: [CLLocationCoordinate2D] = decodePolyline(setPolyline, precision: 1e6)!
                            let polyline = MGLPolyline(coordinates: coordinates, count: UInt(coordinates.count))
                            self.mapView.addAnnotation(polyline)
                            let shapeCam = self.mapView.cameraThatFitsShape(polyline, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                            self.mapView.setCamera(shapeCam, animated: true)
                            self.routeAdvices = trips[0].advices ?? [MapmyIndiaTripAdvice]()
                            if self.routeAdvices.count > 0 {
                                // Add button to show advices
                                self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Advices", style: UIBarButtonItem.Style.plain, target: self, action: #selector(self.showAdvices))
                            }
                            self.vwFooter.isHidden = false
                            self.lblInfo.text = String(format: "Driving Distance: %d m, Duration: %d sec ", trips[0].length?.intValue ?? 0 , trips[0].duration?.intValue ?? 0)
                        }
                    }
                    print("\(String(describing: result.status))")
                } else {
                    print( "No results")
                }
            }
            break
        case "Route Advance":
            callRouteUsingDirectionsFramework(isETA: false)
            isCustomCalloutForPolyline = true
            break
        case "Route Advance ETA":
            callRouteUsingDirectionsFramework(isETA: true)
            isCustomCalloutForPolyline = true
            break
        case "Feedback":
            mapView.setCenter(CLLocationCoordinate2DMake(28.550667, 77.268959), animated: false)
            mapView.zoomLevel = 15
            feedbackButton.isHidden = false
            feedbackButton.addTarget(self, action: #selector(feedbackButtonHandler), for: .touchUpInside)
            break
        case "Animate Marker":
            isForCustomAnnotationView = true
            self.mapView.centerCoordinate = referenceLocation.coordinate
            self.mapView.zoomLevel = 12
            
            
            let annot = MGLPointAnnotation()
            annot.coordinate = referenceLocation.coordinate;
            mapView.addAnnotation(annot)
            
            // Move the annotation to a point that is offscreen.
            let coord: CLLocationCoordinate2D = CLLocationCoordinate2DMake(28.570288, 77.116392)
            DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + Double(Int64(2 * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: {
                UIView.animate(withDuration: 10, animations: {
                    annot.coordinate = coord
                })
            })
            break        
        case "Custom Marker":
            let coordinates = [
                CLLocationCoordinate2D(latitude: 28.551438, longitude: 77.265119),
                CLLocationCoordinate2D(latitude: 28.521438, longitude: 77.265179),
                CLLocationCoordinate2D(latitude: 28.571438, longitude: 77.26509),
                CLLocationCoordinate2D(latitude: 28.551438, longitude: 77.26319),
                CLLocationCoordinate2D(latitude: 28.511438, longitude: 77.261119),
                CLLocationCoordinate2D(latitude: 28.552438, longitude: 77.262119),
                ]
            var pointAnnotations = [CustomPointAnnotation]()
            for coordinate in coordinates {
                let count = pointAnnotations.count + 1
                let point = CustomPointAnnotation(coordinate: coordinate,
                                                  title: "Custom Point Annotation \(count)",
                    subtitle: nil)
                
                // Set the custom `image` and `reuseIdentifier` properties, later used in the `mapView:imageForAnnotation:` delegate method.
                // Create a unique reuse identifier for each new annotation image.
                point.reuseIdentifier = "customAnnotation\(count)"
                // This dot image grows in size as more annotations are added to the array.
                point.image = UIImage(named: "Vehicle")
                
                // Append each annotation to the array, which will be added to the map all at once.
                pointAnnotations.append(point)
            }
            mapView.addAnnotations(pointAnnotations)
            if let annotations = mapView.annotations {
                mapView.showAnnotations(annotations, animated: true)
            }
            break        
        default:
            break
        }
    }
    
    @objc func zoomWithAnimation() {
        let mapCamera = self.mapView.camera
        mapCamera.altitude = 50000
        self.mapView.fly(to: mapCamera, withDuration: 3.0, completionHandler: {
            
        })
    }
    
    @objc func centerWithAnimation() {
        let mapCamera = self.mapView.camera
        mapCamera.centerCoordinate = CLLocationCoordinate2DMake(28.612733, 77.231129)
        self.mapView.fly(to: mapCamera, withDuration: 5.0) {
            
        }
    }
    
    @objc func feedbackButtonHandler() {
        let navVC = MapmyIndiaFeedbackUIKitManager.shared.getViewController(location: CLLocation(latitude: mapView.centerCoordinate.latitude, longitude: mapView.centerCoordinate.longitude), moduleId: "")
        self.present(navVC, animated: true, completion: nil)
    }
    
    @objc func showPlaceDetail() {
        let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as? ListVC
        vctrl?.placemark = placemark
        self.navigationController?.pushViewController(vctrl!, animated: true)
    }
    
    @objc func showAdvices() {
        let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as? ListVC
        vctrl?.routeAdvices = routeAdvices
        self.navigationController?.pushViewController(vctrl!, animated: true)
    }
    
    //  MARK: -  Map Delegate
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        self.mapView.showsUserLocation = false
        self.searchBar.isHidden = true
        self.tableViewAutoSuggest.isHidden = true
        mapView.setCenter(CLLocationCoordinate2D(latitude: 28.550845, longitude: 77.268955), zoomLevel: 4, animated: false)
        
        self.setData()
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        // Always allow callouts to popup when annotations are tapped.
        return true
    }
    
    
    //  MARK: -  Default button Method
    @objc func didTapMap(tap: UITapGestureRecognizer) {
        
        if tap.state == .ended {
            //Do Whatever You want on End of Gesture
            let location = tap.location(in: mapView)
            let coordinate = mapView.convert(location,toCoordinateFrom: mapView)
            
            // Add annotation:
            switch strType {
            case "Reverse Geocoding":
                let reverseGeocodeManager = MapmyIndiaReverseGeocodeManager.shared
                let revOptions = MapmyIndiaReverseGeocodeOptions(coordinate:
                    coordinate, withRegion: .india)
                reverseGeocodeManager.reverseGeocode(revOptions) { (placemarks,
                    attribution, error) in
                    if let error = error {
                        NSLog("%@", error)
                    } else if let placemarks = placemarks, !placemarks.isEmpty {
                        print("Reverse Geocode: \(placemarks[0].latitude ?? ""),\(placemarks[0].longitude ?? "")")
                        print( placemarks[0].formattedAddress ?? "")
                        
                        self.mapView.removeAnnotations(self.mapView.annotations ??  [MGLAnnotation]())
                        let point = MGLPointAnnotation()
                        point.coordinate = CLLocationCoordinate2D(latitude: Double (placemarks[0].latitude ?? "")!, longitude:
                            Double (placemarks[0].longitude ?? "")!)
                        point.title = placemarks[0].formattedAddress
                        self.mapView.addAnnotation(point)
                        self.tempAnnotations.append(point)
                        self.mapView.setCenter(CLLocationCoordinate2D(latitude: Double (placemarks[0].latitude ?? "")!, longitude:Double (placemarks[0].longitude ?? "")!), animated: false)
                        self.vwFooter.isHidden = false
                        //self.lblInfo.text = String(format: "latitude: %f , longitude: %f" ,coordinate.latitude , coordinate.longitude )
                        self.lblInfo.text = String(format: "Address: %@" ,placemarks[0].formattedAddress!)
                    } else {
                        print("No results")
                    }
                }
                break
            case "Driving Distance":
                break
            default:
                break
            }
        }
    }
    
    func callAtlasGeocode() {
        searchBar.isHidden = false
      //  self.constraintSearchBarHeight.constant = 65
        self.searchBar.delegate = self
        searchBar.text = "MapmyIndia, Okhla"
        
        let atlasGeocodeManager = MapmyIndiaAtlasGeocodeManager.shared
        let atlasGeocodeOptions = MapmyIndiaAtlasGeocodeOptions(query: searchBar.text!, withRegion: .india)
        
        atlasGeocodeManager.getGeocodeResults(atlasGeocodeOptions) { (response, error) in
            DispatchQueue.main.async {
                if let error = error {
                    NSLog("%@", error)
                } else if let result = response, let placemarks = result.placemarks, placemarks.count > 0 {
                    if let latitudeNumber = placemarks[0].latitude, let longitudeNumber = placemarks[0].longitude {
                        let latitudeValue = Double(exactly: latitudeNumber) ?? 0
                        let longitudeValue = Double(exactly: longitudeNumber) ?? 0
                        
                        print("Atlas Geocode: \(latitudeValue),\(longitudeValue)")
                        print(placemarks[0].formattedAddress ?? "")
                        
                        self.mapView.removeAnnotations(self.mapView.annotations ??  [MGLAnnotation]())
                        let point = MGLPointAnnotation()
                        let coordinate = CLLocationCoordinate2D(latitude: latitudeValue, longitude: longitudeValue)
                        point.coordinate = coordinate
                        point.title = placemarks[0].formattedAddress
                        self.mapView.addAnnotation(point)
                        self.mapView.setCenter(coordinate, zoomLevel: 17, animated: false)
                    }
                } else {
                    print("No results")
                }
            }
        }
    }
    
    func callDistanceMatrix(isETA: Bool) {
        let distanceMatrixManager = MapmyIndiaDrivingDistanceMatrixManager.shared
        let distanceMatrixOptions = MapmyIndiaDrivingDistanceMatrixOptions(center:
            CLLocation(latitude: 28.543014, longitude: 77.242342), points:
            [CLLocation(latitude: 28.520638, longitude: 77.201959)])
        
        if isETA {
            distanceMatrixOptions.withTraffic = true
        }
        
        var point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 28.543014, longitude:77.242342)
        self.mapView.addAnnotation(point)
        tempAnnotations.append(point)
        
        point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 28.520638, longitude:77.201959)
        self.mapView.addAnnotation(point)
        tempAnnotations.append(point)
        
        self.mapView.showAnnotations(tempAnnotations, edgePadding: UIEdgeInsets(top: 100, left: 100, bottom: 100, right: 100), animated: true)
        
        distanceMatrixManager.getResult(distanceMatrixOptions) { (result, error) in
            if let error = error {
                NSLog("%@", error)
            } else if let result = result, let results = result.results, let durations = results.durations?[0], let distances = results.distances?[0] {
                let pointCount = distanceMatrixOptions.points?.count ?? -1
                for i in 0..<pointCount {
                    if i < durations.count && i < distances.count {
                        let duration = durations[i].intValue
                        let distance = distances[i].intValue
                        print("Driving Distance Matrix\(isETA ? " ETA" : "") \(i): duration: \(duration) distance: \(distance)")
                        
                        DispatchQueue.main.async {
                            self.vwFooter.isHidden = false
                            self.lblInfo.text = String(format: "Distance: %d m, Duration: %d sec ", distance, duration)
                        }
                        if (i == 0) {
                            break
                        }
                    }
                }
            } else {
                print("No results")
            }
        }
    }
    
    func callRouteUsingDirectionsFramework(isETA: Bool) {
        let origin = Waypoint(coordinate: CLLocationCoordinate2DMake(19.072919845581055,72.98474884033203), name: "MapmyIndia")
        let destination = Waypoint(coordinate: CLLocationCoordinate2DMake(19.036991119384766,73.01266479492188), name: "")
        origin.allowsArrivingOnOppositeSide = false
       destination.allowsArrivingOnOppositeSide = false
        
        let options = RouteOptions(waypoints: [origin, destination])
        options.routeShapeResolution = .full
        options.includesAlternativeRoutes = true
        
        if isETA {
            options.profileIdentifier = .automobileWithTraffic
        }
        
        Directions(restKey: MapmyIndiaAccountManager.restAPIKey()).calculate(options) { (waypoints, routes, error) in
           if let _ = error { return }
            
            guard let allRoutes = routes, allRoutes.count > 0 else { return }

            self.routes = allRoutes
            DispatchQueue.main.async {
                self.plotRouteOnMap(routeIndex: 0)
            }
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
                       } else {
                           self.mapView.addAnnotation(myPolyline)
                       }
                    DispatchQueue.main.async {
                    self.vwFooter.isHidden = false
                    self.lblInfo.text = String(format: "Driving Distance: %d m, Duration: %d sec ", Int(route.distance), Int(route.expectedTravelTime))
                    }
                   }
               }
               self.mapView.addAnnotation(polylines[routeIndex])
               self.mapView.showAnnotations(polylines, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: false)
               self.selectRoute(route: self.routes[0])
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
}

extension mapVC : UITableViewDataSource, UITableViewDelegate {
    
    //    MARK: - Tableview Delegate
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return  self.searchSuggestions.count
    }
    
    internal func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        cell.textLabel?.text =  self.searchSuggestions[indexPath.row].placeName
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        self.tableViewAutoSuggest.isHidden = true
        let tempSelect = self.searchSuggestions[indexPath.row]
        let point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: Double (truncating: tempSelect.latitude ?? 0.0), longitude: Double (truncating: tempSelect.longitude ?? 0.0))
        self.mapView.addAnnotation(point)
        mapView.setCenter(CLLocationCoordinate2D(latitude:Double (truncating: tempSelect.latitude ?? 0.0), longitude:  Double (truncating: tempSelect.longitude ?? 0.0) ), zoomLevel: 11, animated: false)
        
    }
}

extension mapVC: UISearchBarDelegate {
    
    //  MARK: -  Search Delegate
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if !searchText.isEmpty && searchText.count > 2 {
            updateListResults(searchQuery: searchText)
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text {
            if !searchText.isEmpty && searchText.count > 2 {
                updateListResults(searchQuery: searchText, isTextSearch: true)
            }
        }
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        self.view.endEditing(true)
        self.tableViewAutoSuggest.isHidden = true
        searchBar.text = ""
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(true, animated: true)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.setShowsCancelButton(false, animated: true)
    }
    
    
    //    MARK: -  Webservice Method
    
    fileprivate func updateListResults(searchQuery: String, isTextSearch: Bool = false) {
        switch strType {
        case "Nearby Search":
            let nearByManager = MapmyIndiaNearByManager.shared
            let nearByOptions = MapmyIndiaNearbyAtlasOptions(query: searchQuery, location: referenceLocation, withRegion: .india)
            nearByOptions.bounds = MapmyIndiaRectangularRegion(topLeft: CLLocationCoordinate2D(latitude: 28.563838, longitude: 77.244345), bottomRight: CLLocationCoordinate2D(latitude: 28.541898, longitude: 77.294514))
            nearByManager.getNearBySuggestions(nearByOptions) { (suggestions, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        NSLog("%@", error)
                    } else if let suggestions = suggestions, !suggestions.isEmpty {
                        self.searchSuggestions.removeAll()
                        self.searchSuggestions = suggestions
                        print("Near by: \(suggestions[0].latitude ?? 0),\(suggestions[0].longitude ?? 0)")
                        print(suggestions[0].placeAddress as Any)
                        print(suggestions[0].distance as Any)
                        self.tableViewAutoSuggest.isHidden = false
                        self.mapView.bringSubviewToFront(self.tableViewAutoSuggest)
                        self.tableViewAutoSuggest.delegate = self
                        self.tableViewAutoSuggest.dataSource = self
                        self.tableViewAutoSuggest.reloadData()
                    } else {
                        print( "No results")
                    }
                }
            }
            break
            
        default:
            break
        }
    }
    
    
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
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor.red
    }
    
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        // Set the line width for polyline annotations
        return 10.0
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        // Set the alpha for all shape annotations to 1 (full opacity)
        return 0.5
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        if isForCustomAnnotationView {
            let annotationView = MGLAnnotationView()
            annotationView.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
            annotationView.backgroundColor = UIColor.blue
            return annotationView
        }
        if isCustomCalloutForPolyline{
            let annotationView = MGLAnnotationView()
            annotationView.isOpaque = true
            return annotationView
        }
        return nil
 }
    
    func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
        if let point = annotation as? CustomPointAnnotation,
            let image = point.image,
            let reuseIdentifier = point.reuseIdentifier {
            if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier) {
                // The annotatation image has already been cached, just reuse it.
                return annotationImage
            } else {
                // Create a new annotation image.                
                return MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
            }
        }
        // Fallback to the default marker image.
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        // Instantiate and return our custom callout view.
        if annotation is CustomPointAnnotation{
            return CustomCalloutView(representedObject: annotation)
        }
        if isCustomCalloutForPolyline{
            if annotation is MGLPointAnnotation{
            return CustomCalloutViewForPolyline(representedObject: annotation)
            }
        }
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
           if annotation is MGLPolyline {
               if let customPolyline = annotation as? CustomPolyline, !customPolyline.isSelected {
                   let polylineAnnotations = mapView.annotations?.filter({ (annotation) -> Bool in
                       if annotation is MGLPolyline {
                           return true
                       }
                       return false
                   })
                   if let polylines = polylineAnnotations {
                       self.mapView.removeAnnotations(polylines)
                   }
                   if self.routes.count > 0 {
                       plotRouteOnMap(routeIndex: customPolyline.routeIndex)
                       let selectedRoute = self.routes[customPolyline.routeIndex]
                       self.selectRoute(route: selectedRoute)
                   }
               }
           }
       }

}

// MARK:- CustomPolyline Class

class CustomPolyline: MGLPolyline{

    var routeIndex:Int = -1
    var isSelected:Bool = true
    
    
}
