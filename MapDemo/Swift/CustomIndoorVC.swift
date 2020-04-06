//
//  CustomIndoorVC.swift
//  POCMapStyles
//
//  Created by apple on 04/12/19.
//  Copyright © 2019 apple. All rights reserved.
//

import UIKit
import MapmyIndiaMaps
import MapmyIndiaAPIKit

class CustomIndoorVC: UIViewController {

    var mapView: MapmyIndiaMapView!
    var strType:String?
    let vasantKunjLocation = CLLocationCoordinate2DMake(28.542568, 77.155914)
    let bangaloreExpoLocation = CLLocationCoordinate2DMake(13.062946, 77.474959)
    
    var indoorPlugin:MapmyIndiaMapViewIndoorPlugin?
    var indoorSelecorView: MapmyIndiaIndoorSelectorView?
    @IBOutlet weak var indoorButton: UIButton!
    
    @IBAction func indoorButtonTapped(_ sender: UIButton) {
        indoorButton.isSelected = !indoorButton.isSelected
        MapmyIndiaAccountManager.setIndoorEnabled(indoorButton.isSelected)
    }
    
    @IBOutlet weak var vasantKunjLocationButton: UIButton!
    
    @IBAction func vasantKunjLocationButtonTapped(_ sender: UIButton) {
        setVasantKunjLocation()
    }
    
    @IBOutlet weak var bangaloreExpoLocationButton: UIButton!
    
    @IBAction func bangaloreExpoLocationButtonTapped(_ sender: UIButton) {
        setBangaloreExpoLocation()
    }
    
    func setVasantKunjLocation() {
        mapView.setCenter(vasantKunjLocation, zoomLevel: 18, animated: false)
    }
    
    func setBangaloreExpoLocation() {
        mapView.setCenter(bangaloreExpoLocation, zoomLevel: 18, animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = strType
        MapmyIndiaAccountManager.setIndoorDefaultUIEnabled(false)
        
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.showsUserLocation = true
        mapView.minimumZoomLevel = 3
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.delegate = self
        view.addSubview(mapView)

        view.bringSubviewToFront(indoorButton)
        view.bringSubviewToFront(vasantKunjLocationButton)
        view.bringSubviewToFront(bangaloreExpoLocationButton)
        
        indoorButton.isSelected = MapmyIndiaAccountManager.indoorEnabled()
        
        mapView.indoorSelecorViewBottomConstraintConstant = 100
        mapView.indoorSelecorViewLeftConstraintConstant = 100
        indoorPlugin = MapmyIndiaMapViewIndoorPlugin()
        indoorPlugin?.delegate = self
        indoorSelecorView = MapmyIndiaIndoorSelectorView(superview: self.view)
        indoorSelecorView?.delegate = self
    }
}

extension CustomIndoorVC: MapmyIndiaMapViewDelegate {
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        setVasantKunjLocation()
    }
    
    func mapView(_ mapView: MGLMapView, regionDidChangeAnimated animated: Bool) {
        indoorPlugin?.regionDidChange(for: mapView)
    }
}

//MARK: MapmyIndiaMapViewIndoorPluginDelegate
extension CustomIndoorVC: MapmyIndiaMapViewIndoorPluginDelegate {
    func updateFloorSelector(_ floors: Int, initialFloor: Int) {
        print("IndoorPlugin Floors:\(floors) initial: \(initialFloor)")
        indoorSelecorView?.isHidden = false
        indoorSelecorView?.setFloors(floors, initialFloor: initialFloor)
    }
    
    func showFloorSelector() {
        print("IndoorPlugin showFloorSelector")
        indoorSelecorView?.isHidden = false
    }
    
    func hideFloorSelector() {
        print("IndoorPlugin hideFloorSelector")
        indoorSelecorView?.isHidden = true
    }
}

//MARK: MapmyIndiaIndoorSelectorViewDelegate
extension CustomIndoorVC: MapmyIndiaIndoorSelectorViewDelegate {
    func tappedButton(_ tag: Int) {
        indoorPlugin?.mapView(self.mapView, switchToFloor: tag)
    }
}
