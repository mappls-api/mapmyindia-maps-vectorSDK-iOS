//
//  HighlightPointExample.swift
//  MapDemo
//
//  Created by apple on 07/08/19.
//  Copyright © 2019 MMI. All rights reserved.
//

import Mapbox

@objc(HighlightPointExample_Swift)
class HighlightPointExample_Swift: UIViewController {
    let sourceIdentifier = "mySource"
    let layerIdentifier = "myLayer"
    
    var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .darkGray
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918), zoomLevel: 15, animated: false)
        
        mapView.delegate = self
        view.addSubview(mapView)
        
        let myUIStepper = UIStepper()
        myUIStepper.value = 100
        myUIStepper.minimumValue = 10
        myUIStepper.stepValue = 2
        myUIStepper.maximumValue = 200
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: myUIStepper)
        
        // Add a function handler to be called when UIStepper value changes
        myUIStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func stepperValueChanged(_ sender:UIStepper!)
    {
        print("UIStepper is now \(Int(sender.value))")
        if let mapStyle = self.mapView.style {
            if let source = mapStyle.source(withIdentifier: self.sourceIdentifier) as? MGLShapeSource {
                let sourceFeatures = getSourceFeatures(coordinate:CLLocationCoordinate2DMake(28.550834, 77.268918), radius: sender.value)
                source.shape = sourceFeatures
                if let shape = sourceFeatures.interiorPolygons?.first {
                    let shapeCam = mapView.cameraThatFitsShape(shape, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                    mapView.setCamera(shapeCam, animated: false)
                }
            }
        }
        
        /*
        // To move logo view left position
        for constraint in (mapView.constraints) where (constraint.firstItem as? NSObject)! == mapView?.logoView {
            constraint.constant = 90
        }
        
        // To move logo view bottom position
        for constraint in (mapView.constraints) where (constraint.secondItem as? NSObject)! == mapView?.logoView {
            constraint.constant = 120
        }
        */
    }
    
    func drawShapeCollection() {
        guard let style = self.mapView.style else { return }
       
        let sourceFeatures = getSourceFeatures(coordinate:CLLocationCoordinate2DMake(28.550834, 77.268918), radius: 100)
        // Create source and add it to the map style.
        let source = MGLShapeSource(identifier: sourceIdentifier, shape: sourceFeatures, options: nil)
        style.addSource(source)
        
        let polygonLayer = MGLFillStyleLayer(identifier: layerIdentifier, source: source)
        polygonLayer.fillColor = NSExpression(forConstantValue: UIColor.red)
        polygonLayer.fillOpacity = NSExpression(forConstantValue: 0.5)
        polygonLayer.fillOutlineColor = NSExpression(forConstantValue: UIColor.black)
        
        // Add style layers to the map view's style.
        style.addLayer(polygonLayer)
        
        if let shape = sourceFeatures.interiorPolygons?.first {
            let shapeCam = mapView.cameraThatFitsShape(shape, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            mapView.setCamera(shapeCam, animated: false)
        }
    }
    
    func getSourceFeatures(coordinate: CLLocationCoordinate2D, radius: Double) -> MGLPolygonFeature {
        let circleCoordinates = InteriorPolygonExample_Swift.polygonCircleForCoordinate(coordinate: coordinate, withMeterRadius: radius)
        let holePolygon = MGLPolygonFeature(coordinates: circleCoordinates, count: UInt(circleCoordinates.count))
        let visibleQuadCoordinates = MGLCoordinateQuadFromCoordinateBounds(MGLCoordinateBounds(sw: CLLocationCoordinate2DMake(6, 60), ne: CLLocationCoordinate2DMake(35,100)))
        let visibleCoordinates = [visibleQuadCoordinates.topLeft, visibleQuadCoordinates.topRight, visibleQuadCoordinates.bottomRight, visibleQuadCoordinates.bottomLeft]
        let polygonFeature = MGLPolygonFeature(coordinates: visibleCoordinates, count: UInt(visibleCoordinates.count), interiorPolygons: [holePolygon])
        return polygonFeature
    }
}

extension HighlightPointExample_Swift: MapmyIndiaMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        self.drawShapeCollection()
    }
}
