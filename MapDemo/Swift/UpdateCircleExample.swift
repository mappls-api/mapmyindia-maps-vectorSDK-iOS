//
//  UpdateCircleExample.swift
//  MapDemo
//
//  Created by apple on 20/05/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit
import MapmyIndiaMaps

@objc(UpdateCircleExample_Swift)
class UpdateCircleExample_Swift: UIViewController, MapmyIndiaMapViewDelegate {
    let sourceIdentifier = "mySource"
    let layerIdentifier = "myLayer"
    
    let initialRadius: Float = 100.0
    
    var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .darkGray
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918), zoomLevel: 15, animated: false)
        
        mapView.delegate = self
        view.addSubview(mapView)
        
        let slider = UISlider()
        slider.backgroundColor = .white
        slider.minimumValue = 100
        slider.maximumValue = 1000
        slider.value = initialRadius
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        slider.isContinuous = true
        view.addSubview(slider)
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            slider.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            slider.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        if #available(iOS 11.0, *) {
            slider.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        } else {
            slider.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        }
        if #available(iOS 11.0, *) {
            slider.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        } else {
            slider.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }
        slider.heightAnchor.constraint(equalToConstant: 60).isActive = true
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider!)
    {
        print("UIStepper is now \(Int(sender.value))")
        if let mapStyle = self.mapView.style {
            if let source = mapStyle.source(withIdentifier: self.sourceIdentifier) as? MGLShapeSource {
                let sourceFeatures = getSourceFeatures(coordinate:CLLocationCoordinate2DMake(28.550834, 77.268918), radius: Double(sender!.value))
                source.shape = sourceFeatures
                
                let shapeCam = mapView.cameraThatFitsShape(sourceFeatures, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                mapView.setCamera(shapeCam, animated: false)
            }
        }
    }
        
    func drawShapeCollection() {
        guard let style = self.mapView.style else { return }
       
        let sourceFeatures = getSourceFeatures(coordinate: CLLocationCoordinate2DMake(28.550834, 77.268918), radius: Double(initialRadius))
        // Create source and add it to the map style.
        let source = MGLShapeSource(identifier: sourceIdentifier, shape: sourceFeatures, options: nil)
        style.addSource(source)
        
        let polygonLayer = MGLFillStyleLayer(identifier: layerIdentifier, source: source)
        polygonLayer.fillColor = NSExpression(forConstantValue: UIColor.red)
        polygonLayer.fillOpacity = NSExpression(forConstantValue: 0.5)
        polygonLayer.fillOutlineColor = NSExpression(forConstantValue: UIColor.black)
        
        // Add style layers to the map view's style.
        style.addLayer(polygonLayer)
        
        let shapeCam = mapView.cameraThatFitsShape(sourceFeatures, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        mapView.setCamera(shapeCam, animated: false)
    }
    
    func getSourceFeatures(coordinate: CLLocationCoordinate2D, radius: Double) -> MGLPolygonFeature {
        let circleCoordinates = InteriorPolygonExample_Swift.polygonCircleForCoordinate(coordinate: coordinate, withMeterRadius: radius)
        let circlePolygon = MGLPolygonFeature(coordinates: circleCoordinates, count: UInt(circleCoordinates.count))
        return circlePolygon
    }
}

//MARK: MapmyIndiaMapViewDelegate Implementation
extension UpdateCircleExample_Swift {
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        self.drawShapeCollection()
    }
}
