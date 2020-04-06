//
//  DashedPolylineExample.swift
//  MapDemo
//
//  Created by apple on 14/08/19.
//  Copyright © 2019 MMI. All rights reserved.
//

import MapmyIndiaMaps

@objc(DashedPolylineExample_Swift)
class DashedPolylineExample_Swift: UIViewController {
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
    }
    
    func drawShapeCollection() {
        guard let style = self.mapView.style else { return }
        
        let sourceFeatures = getSourceFeatures()
        // Create source and add it to the map style.
        let source = MGLShapeSource(identifier: sourceIdentifier, shape: sourceFeatures, options: nil)
        style.addSource(source)
        
        let polylineLayer = MGLLineStyleLayer(identifier: layerIdentifier, source: source)
        polylineLayer.lineColor = NSExpression(forConstantValue: UIColor.red)
        polylineLayer.lineOpacity = NSExpression(forConstantValue: 0.5)
        polylineLayer.lineWidth = NSExpression(forConstantValue: 8)
        polylineLayer.lineDashPattern = NSExpression(forConstantValue: [2, 2])
        
        // Add style layers to the map view's style.
        style.addLayer(polylineLayer)
        
        let shapeCam = mapView.cameraThatFitsShape(sourceFeatures, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        mapView.setCamera(shapeCam, animated: false)
    }
    
    func getSourceFeatures() -> MGLPolylineFeature {
        var coordinates = [
            CLLocationCoordinate2D(latitude: 28.550834, longitude: 77.268918),
            CLLocationCoordinate2D(latitude: 28.551059, longitude: 77.268890),
            CLLocationCoordinate2D(latitude: 28.550938, longitude: 77.267641),
            CLLocationCoordinate2D(latitude: 28.551764, longitude: 77.267575),
            CLLocationCoordinate2D(latitude: 28.552068, longitude: 77.267599),
            CLLocationCoordinate2D(latitude: 28.553836, longitude: 77.267450),
        ]
        let polyline = MGLPolylineFeature(coordinates: &coordinates, count: UInt(coordinates.count))
        return polyline
    }
}

extension DashedPolylineExample_Swift: MapmyIndiaMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        self.drawShapeCollection()
    }
}
