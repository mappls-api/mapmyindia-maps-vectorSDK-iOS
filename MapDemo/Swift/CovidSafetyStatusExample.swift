//
//  CovidSafetyStatusExample.swift
//  MapDemo
//
//  Created by apple on 18/06/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit
import MapmyIndiaMaps

@objc(CovidSafetyStatusExample_Swift)
class CovidSafetyStatusExample_Swift: UIViewController {

    @IBOutlet weak var mapView: MapmyIndiaMapView!
    
    @IBOutlet weak var getCurrentSafetyButton: UIButton!
    
    @IBOutlet weak var hideSafetyStatusButton: UIButton!
    
    @IBAction func getCurrentSafetyButtonPressed(_ sender: UIButton) {
        if isLocationReady {
            mapView.showCurrentLocationSafety()
        }
    }
    
    @IBAction func hideSafetyStatusButtonPressed(_ sender: UIButton) {
        mapView.hideSafetyStrip()
    }
        
    var isLocationReady = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView.delegate = self
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }

}

extension CovidSafetyStatusExample_Swift: MapmyIndiaMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didUpdate userLocation: MGLUserLocation?) {
        if let userLocation = userLocation, let location = userLocation.location, CLLocationCoordinate2DIsValid(location.coordinate) {
            isLocationReady = true
        }
    }
}
