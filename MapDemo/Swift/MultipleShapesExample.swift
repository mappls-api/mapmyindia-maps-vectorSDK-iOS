//
//  MultipleShapesExample.swift
//  MapDemo
//
//  Created by apple on 14/09/18.
//  Copyright © 2018 MMI. All rights reserved.
//

import Mapbox

@objc(MultipleShapesExample_Swift)
class MultipleShapesExample_Swift: UIViewController, MGLMapViewDelegate {
    
    var mapView: MGLMapView!
     var strType:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = strType
        mapView = MapmyIndiaMapView(frame: view.bounds)        
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .darkGray
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 28.543253, longitude: 77.261647), zoomLevel: 11, animated: false)
        
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
        // Parse the GeoJSON data.
        DispatchQueue.global().async {
            guard let url = Bundle.main.url(forResource: "metro-line", withExtension: "geojson") else {
                preconditionFailure("Failed to load local GeoJSON file")
            }
            
            guard let data = try? Data(contentsOf: url) else {
                preconditionFailure("Failed to decode GeoJSON file")
            }
            
            DispatchQueue.main.async {
                try? self.drawShapeCollection(data: data)
            }
        }
    }
    
    func drawShapeCollection(data: Data) throws {
        guard let style = self.mapView.style else { return }
        
        // Use [MGLShape shapeWithData:encoding:error:] to create a MGLShapeCollectionFeature from GeoJSON data.
        guard let feature = try? MGLShape(data: data, encoding: String.Encoding.utf8.rawValue) as? MGLShapeCollectionFeature else {
            fatalError("Could not cast to specified MGLShapeCollectionFeature")
        }
        
        // Create source and add it to the map style.
        let source = MGLShapeSource(identifier: "transit", shape: feature, options: nil)
        style.addSource(source)
        
        // Create station style layer.
        let circleLayer = MGLCircleStyleLayer(identifier: "stations", source: source)
        
        // Use a predicate to filter out non-points.
        circleLayer.predicate = NSPredicate(format: "TYPE = 'Station'")
        circleLayer.circleColor = NSExpression(forConstantValue: UIColor.red)
        circleLayer.circleRadius = NSExpression(forConstantValue: 6)
        circleLayer.circleStrokeWidth = NSExpression(forConstantValue: 2)
        circleLayer.circleStrokeColor = NSExpression(forConstantValue: UIColor.black)
        
        // Create line style layer.
        let lineLayer = MGLLineStyleLayer(identifier: "rail-line", source: source)
        
        // Use a predicate to filter out the stations.
        lineLayer.predicate = NSPredicate(format: "TYPE = 'Rail line'")
        lineLayer.lineColor = NSExpression(forConstantValue: UIColor.red)
        lineLayer.lineWidth = NSExpression(forConstantValue: 5)
        
        
        
        let polygonLayer = MGLFillStyleLayer(identifier: "station-boundry", source: source)
        polygonLayer.predicate = NSPredicate(format: "TYPE = 'Rail Station'")
        polygonLayer.fillColor = NSExpression(forConstantValue: UIColor.red)
        polygonLayer.fillOpacity = NSExpression(forConstantValue: 0.5)
        polygonLayer.fillOutlineColor = NSExpression(forConstantValue: UIColor.black)
        
        // Add style layers to the map view's style.
        style.addLayer(circleLayer)
        style.insertLayer(lineLayer, below: circleLayer)
        style.insertLayer(polygonLayer, below: circleLayer)
    }
}
