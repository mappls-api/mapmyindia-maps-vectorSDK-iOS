//
//  ViewController.swift
//  MapDemo
//
//  Created by CE Info on 24/07/18.
//  Copyright © 2018 MMI. All rights reserved.
//

import UIKit
import MapmyIndiaMaps

class ViewController: UIViewController {

    @IBOutlet weak var mapView: MapmyIndiaMapView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.mapView.showsUserLocation = true
        self.mapView.delegate = self
        mapView.userTrackingMode = .followWithCourse
        
        var point = MGLPointAnnotation()
        point.coordinate = CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918)
        point.title = "Annotation"
        mapView.addAnnotation(point)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ViewController: MapmyIndiaMapViewDelegate {
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        print("did finish load")
    }
}
