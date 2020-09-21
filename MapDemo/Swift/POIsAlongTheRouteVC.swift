//
//  POIsAlongTheRouteVC.swift
//  MapDemo
//
//  Created by Apple on 10/09/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit
import MapmyIndiaAPIKit
import Polyline
import MapmyIndiaMaps
import MapmyIndiaDirections

class POIsAlongTheRouteVC: UIViewController {
    
    var mapView: MapmyIndiaMapView!
    var routes = [Route]()
    var selectedRoute:Route?
    let point = MGLPointAnnotation()
    var poiMarkers = [CustomPointAnnotation]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)
        
        // Do any additional setup after loading the view.
    }
    
    func getRoute() {
        let origin = Waypoint(coordinate: CLLocationCoordinate2DMake(19.072919845581055,72.98474884033203), name: "MapmyIndia")
        
        let destination = Waypoint(coordinate: CLLocationCoordinate2DMake(19.036991119384766,73.01266479492188), name: "")
        origin.allowsArrivingOnOppositeSide = false
        destination.allowsArrivingOnOppositeSide = false
        
        let options = RouteOptions(waypoints: [origin, destination])
        options.routeShapeResolution = .full
        options.includesAlternativeRoutes = true
        
        Directions(restKey: MapmyIndiaAccountManager.restAPIKey()).calculate(options) { (waypoints, routes, error) in
            if let _ = error { return }
            
            guard let allRoutes = routes, allRoutes.count > 0 else { return }
            
            self.routes = allRoutes
            DispatchQueue.main.async {
                self.plotRouteOnMap(routeIndex: 0)
            }
        }
    }
    
    func plotRouteOnMap(routeIndex: Int) {
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
                    
                }
            }
            self.mapView.addAnnotation(polylines[routeIndex])
            self.mapView.showAnnotations(polylines, edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20), animated: false, completionHandler: nil)
            self.selectRoute(route: self.routes[0])
        }
        
        let selectedRoute = self.routes[routeIndex]
        getPOIAlongTheRoute(coordinates: selectedRoute.coordinates!)
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
            self.mapView.selectAnnotation(self.point, animated: false, completionHandler: nil)
        }
    }
    
    func getPOIAlongTheRoute(coordinates: [CLLocationCoordinate2D]) {
        if let markers = self.mapView.annotations, markers.count > 0, self.poiMarkers.count > 0 {
            self.mapView.removeAnnotations(poiMarkers)
        }
        
        let routePath = Polyline(coordinates: coordinates, precision: 1e5).encodedPolyline
        let poiAlongTheRouteOptions = MapmyIndiaPOIAlongTheRouteOptions(path: routePath, category: "FODCOF")
        poiAlongTheRouteOptions.buffer = 1000
        let poiAlongTheRouteManager = MapmyIndiaPOIAlongTheRouteManager(restKey: MapmyIndiaAccountManager.restAPIKey(), clientId: MapmyIndiaAccountManager.atlasClientId(), clientSecret: MapmyIndiaAccountManager.atlasClientSecret(), grantType: MapmyIndiaAccountManager.atlasGrantType())
        let _ = poiAlongTheRouteManager.getPOIsAlongTheRoute(poiAlongTheRouteOptions) { (suggestions, error) in
            if let error = error {
                print("\(error.localizedDescription)")
            } else if let suggestions = suggestions {
                DispatchQueue.main.async {
                    self.plotPOIMarkers(suggestions: suggestions)
                }
            } else {
                print("NO Results")
            }
        }
    }
    
    func plotPOIMarkers(suggestions: [MapmyIndiaPOISuggestion]) {
        var markers = [CustomPointAnnotation]()
        for suggestion in suggestions {
            if let latitude = suggestion.latitude, let longitude = suggestion.longitude {
                let markerTitle = "\([suggestion.poi ?? "", suggestion.address ?? ""].joined(separator: ","))"
                let marker = CustomPointAnnotation(coordinate: CLLocationCoordinate2DMake(latitude, longitude), title: markerTitle, subtitle: nil)
                markers.append(marker)
            }
        }
        self.poiMarkers = markers
        self.mapView.addAnnotations(self.poiMarkers)
    }
}

extension POIsAlongTheRouteVC: MapmyIndiaMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        getRoute()
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
        return 0.7
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
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapView(_ mapView: MGLMapView, calloutViewFor annotation: MGLAnnotation) -> MGLCalloutView? {
        if let _ = annotation as? CustomPointAnnotation {
            // For POI markers, show callout
            return nil
        } else {
            // For polyline, show custom callout
            return CustomCalloutViewForPolyline(representedObject: annotation)
        }
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        if let _ = annotation as? CustomPointAnnotation {
            // For POI markers, show default marker
            return nil
        } else {
            // For polyline, show no marker
            let annotationView = MGLAnnotationView()
            annotationView.isOpaque = true
            return annotationView
        }
    }
}
