//
//  ViewController.swift
//  PointOnMap
//
//  Created by Ayush Dayal on 17/01/20.
//  Copyright © 2020 Ayush Dayal. All rights reserved.
//

import UIKit
import MapmyIndiaAPIKit
import Mapbox

class PointOnMapVC: UIViewController , MapmyIndiaMapViewDelegate {
    
    @IBOutlet weak var markerImage: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    var strType:String?
    var mapView:MapmyIndiaMapView!
    var results:[MapmyIndiaGeocodedPlacemark]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = strType
        let initialCorr = CLLocationCoordinate2D(latitude: 28.543253, longitude: 77.261647)
       // let mapFrame = CGRect(x: 0, y: 112, width: 414, height: 750)
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(initialCorr, zoomLevel: 15, animated: false)
        mapView.delegate = self
        view.addSubview(mapView)
        view.bringSubviewToFront(lbl)
        view.bringSubviewToFront(markerImage)
        callReverseGeocode(coordinate: mapView.centerCoordinate)
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        return nil
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return false
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        callReverseGeocode(coordinate: mapView.centerCoordinate)
    }
    
    func callReverseGeocode(coordinate: CLLocationCoordinate2D) {
        let reverseGeocodeManager =  MapmyIndiaReverseGeocodeManager.shared
        let revOptions = MapmyIndiaReverseGeocodeOptions(coordinate: coordinate, withRegion: .india)
        reverseGeocodeManager.reverseGeocode(revOptions) { (placemarks,
            attribution, error) in
            if let error = error {
                NSLog("%@", error)
            } else if let placemarks = placemarks, !placemarks.isEmpty {
                DispatchQueue.main.async {
                    self.results = placemarks
                    self.lbl.text = placemarks[0].formattedAddress
                    print("Reverse Geocode: \(placemarks[0].latitude ?? ""),\(placemarks[0].longitude ?? "")")
                }
            } else {
                print("No Result")
            }
        }
    }
    
}

