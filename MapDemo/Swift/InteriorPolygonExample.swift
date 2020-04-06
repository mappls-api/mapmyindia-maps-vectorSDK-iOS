//
//  InteriorPolygonExample.swift
//  MapDemo
//
//  Created by apple on 02/08/19.
//  Copyright © 2019 MMI. All rights reserved.
//

import MapmyIndiaMaps


class CustomPolygon: MGLPolygon {
    var polygonColor = UIColor.red
    var opacity:CGFloat = 1.0
}

@objc(InteriorPolygonExample_Swift)
class InteriorPolygonExample_Swift: UIViewController {
    
    var mapView: MGLMapView!
    
    var overlay: CustomPolygon?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .darkGray
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 28.543253, longitude: 77.261647), zoomLevel: 11, animated: false)
        
        mapView.delegate = self
        view.addSubview(mapView)
        
        
        let myUIStepper = UIStepper()
        
        // If tap and hold the button, UIStepper value will continuously increment
        myUIStepper.minimumValue = 100
        myUIStepper.stepValue = 100
        myUIStepper.maximumValue = 10000
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: myUIStepper)
        
        // Add a function handler to be called when UIStepper value changes
        myUIStepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
    }
    
    @objc func stepperValueChanged(_ sender:UIStepper!)
    {
        print("UIStepper is now \(Int(sender.value))")
        if let _ = self.overlay {
            let circleCoordinates = InteriorPolygonExample_Swift.polygonCircleForCoordinate(coordinate: CLLocationCoordinate2D(latitude: 28.550834, longitude:
                77.268918), withMeterRadius: sender.value)
            let holePolygon = CustomPolygon(coordinates: circleCoordinates, count: UInt(circleCoordinates.count))
            let visibleQuadCoordinates = MGLCoordinateQuadFromCoordinateBounds(self.mapView.visibleCoordinateBounds)
            let visibleCoordinates = [visibleQuadCoordinates.topLeft, visibleQuadCoordinates.topRight, visibleQuadCoordinates.bottomRight, visibleQuadCoordinates.bottomLeft]
            self.overlay = CustomPolygon(coordinates: visibleCoordinates, count: UInt(visibleCoordinates.count), interiorPolygons: [holePolygon])
        }
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        let circleCoordinates = InteriorPolygonExample_Swift.polygonCircleForCoordinate(coordinate: CLLocationCoordinate2D(latitude: 28.550834, longitude:
            77.268918), withMeterRadius: 100)
        let holePolygon = CustomPolygon(coordinates: circleCoordinates, count: UInt(circleCoordinates.count))
        let visibleQuadCoordinates = MGLCoordinateQuadFromCoordinateBounds(self.mapView.visibleCoordinateBounds)
        let visibleCoordinates = [visibleQuadCoordinates.topLeft, visibleQuadCoordinates.topRight, visibleQuadCoordinates.bottomRight, visibleQuadCoordinates.bottomLeft]
        overlay = CustomPolygon(coordinates: visibleCoordinates, count: UInt(visibleCoordinates.count), interiorPolygons: [holePolygon])
        overlay!.polygonColor = UIColor.red
        overlay!.opacity = 0.6
        mapView.addAnnotation(overlay!)
        let shapeCam = mapView.cameraThatFitsShape(holePolygon, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        mapView.setCamera(shapeCam, animated: false)
    }
    
    class func polygonCircleForCoordinate(coordinate: CLLocationCoordinate2D, withMeterRadius: Double) -> [CLLocationCoordinate2D] {
        let degreesBetweenPoints = 8.0
        //45 sides
        let numberOfPoints = floor(360.0 / degreesBetweenPoints)
        let distRadians: Double = withMeterRadius / 6371000.0
        // earth radius in meters
        let centerLatRadians: Double = coordinate.latitude * Double.pi / 180
        let centerLonRadians: Double = coordinate.longitude * Double.pi / 180
        var coordinates = [CLLocationCoordinate2D]()
        //array to hold all the points
        for index in 0 ..< Int(numberOfPoints) {
            let degrees: Double = Double(index) * Double(degreesBetweenPoints)
            let degreeRadians: Double = degrees * Double.pi / 180
            let pointLatRadians: Double = asin(sin(centerLatRadians) * cos(distRadians) + cos(centerLatRadians) * sin(distRadians) * cos(degreeRadians))
            let pointLonRadians: Double = centerLonRadians + atan2(sin(degreeRadians) * sin(distRadians) * cos(centerLatRadians), cos(distRadians) - sin(centerLatRadians) * sin(pointLatRadians))
            let pointLat: Double = pointLatRadians * 180 / Double.pi
            let pointLon: Double = pointLonRadians * 180 / Double.pi
            let point: CLLocationCoordinate2D = CLLocationCoordinate2DMake(pointLat, pointLon)
            coordinates.append(point)
        }
        return coordinates
    }
}

extension InteriorPolygonExample_Swift: MapmyIndiaMapViewDelegate {
//    func mapView(_ mapView: MGLMapView, regionIsChangingWith reason: MGLCameraChangeReason) {
//        DispatchQueue.main.async {
//            if let overlay = self.overlay {
//                let visibleQuadCoordinates = MGLCoordinateQuadFromCoordinateBounds(self.mapView.visibleCoordinateBounds)
//                var visibleCoordinates = [visibleQuadCoordinates.topLeft, visibleQuadCoordinates.topRight, visibleQuadCoordinates.bottomRight, visibleQuadCoordinates.bottomLeft]
//                overlay.setCoordinates(&visibleCoordinates, count: UInt(visibleCoordinates.count))
//            }
//        }
//    }
    
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        if let polygon = annotation as? CustomPolygon {
            return polygon.polygonColor
        }
        return self.mapView.tintColor
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        if let polygon = annotation as? CustomPolygon {
            return polygon.opacity
        }
        return 1.0
    }
}
