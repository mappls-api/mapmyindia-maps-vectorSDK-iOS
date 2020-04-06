//
//  GeodesicPolylineExample.swift
//  MapDemo
//
//  Created by apple on 14/08/19.
//  Copyright © 2019 MMI. All rights reserved.
//

import MapmyIndiaMaps
import MapKit

@objc(GeodesicPolylineExample_Swift)
class GeodesicPolylineExample_Swift: UIViewController {
    
    var mapView: MGLMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .darkGray
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 28.543253, longitude: 77.261647), zoomLevel: 11, animated: false)
        
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        let greateCircle = GreatCircle()
        let delhiCoordinate = CLLocationCoordinate2DMake(28.555278, 77.085725)
        let mumbaiCoordinate = CLLocationCoordinate2DMake(19.089443, 72.865053)
        let kolkataCoordinate = CLLocationCoordinate2DMake(22.650290, 88.446447)
        
        let delhiToMumbaiCoordinates = greateCircle.discretizePoints(fromCoordinate: delhiCoordinate, toCoordinate: mumbaiCoordinate)
        let delhiToKolkataCoordinates = greateCircle.discretizePoints(fromCoordinate: delhiCoordinate, toCoordinate: kolkataCoordinate)
        
        let delhiToMumbaiPolyline = MGLPolyline(coordinates: delhiToMumbaiCoordinates, count: UInt(delhiToMumbaiCoordinates.count))
        let delhiToKolkataPolyline = MGLPolyline(coordinates: delhiToKolkataCoordinates, count: UInt(delhiToKolkataCoordinates.count))
        
        mapView.addAnnotations([delhiToMumbaiPolyline, delhiToKolkataPolyline])
        
        let allCoordinates = delhiToMumbaiCoordinates + delhiToKolkataCoordinates
        let polygon = MGLPolygon(coordinates: allCoordinates, count: UInt(allCoordinates.count))
        
        let shapeCam = mapView.cameraThatFitsShape(polygon, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        mapView.setCamera(shapeCam, animated: false)
    }
    
    /*
    func showCurvedPolyline(fromCoordinate: CLLocationCoordinate2D, toCoordinate: CLLocationCoordinate2D, k: Double = 0.2) -> [CLLocationCoordinate2D] {
        //Calculate distance and heading between two points
        let d = SphericalUtil.computeDistanceBetween(from: fromCoordinate,to: toCoordinate);
        let h = SphericalUtil.computeHeading(from: fromCoordinate, to: toCoordinate);
        
        //Midpoint position
        let p = SphericalUtil.computeOffset(from: fromCoordinate, distance: d*0.5, heading: h);
        
        //Apply some mathematics to calculate position of the circle center
        let x = (1-k*k)*d*0.5/(2*k);
        let r = (1+k*k)*d*0.5/(2*k);
        
        let c = SphericalUtil.computeOffset(from: p, distance: x, heading: h + 90.0);
        
        //Polyline options
        var coordinates = [CLLocationCoordinate2D]()
        
        //Calculate heading between circle center and two points
        let h1 = SphericalUtil.computeHeading(from: c, to: fromCoordinate);
        let h2 = SphericalUtil.computeHeading(from: c, to: toCoordinate);
        
        //Calculate positions of points on circle border and add them to polyline options
        let numpoints = 100;
        let step = (h2 - h1) / Double(numpoints)
        
        for i in 0...numpoints {
            let pi = SphericalUtil.computeOffset(from: c, distance: r, heading: h1 + Double(i) * step);
            coordinates.append(pi)
        }
        
        return coordinates
    }
    */
}

extension GeodesicPolylineExample_Swift: MapmyIndiaMapViewDelegate {
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

public extension MGLPolyline {
    class func geodesicPolyline(fromCoordinate: CLLocationCoordinate2D, toCoordinate: CLLocationCoordinate2D) -> MGLPolyline {
        var coordinates = [fromCoordinate, toCoordinate]
        let geodesicPolyline = MKGeodesicPolyline(coordinates: &coordinates, count: 2)
        
        var normalizedCoordinates: [CLLocationCoordinate2D] = []
        var previousCoordinate: CLLocationCoordinate2D?
        for coordinate in geodesicPolyline.coordinates {
            var normalizedCoordinate = coordinate
            if let previousCoordinate = previousCoordinate, abs(previousCoordinate.longitude - coordinate.longitude) > 180 {
                if (previousCoordinate.longitude > coordinate.longitude) {
                    normalizedCoordinate.longitude += 360
                } else {
                    normalizedCoordinate.longitude -= 360
                }
            }
            normalizedCoordinates.append(normalizedCoordinate)
            previousCoordinate = normalizedCoordinate
        }
        
        return MGLPolyline(coordinates: normalizedCoordinates, count: UInt(geodesicPolyline.pointCount))
    }
}

public extension MKPolyline {
    var coordinates: [CLLocationCoordinate2D] {
        var coords = [CLLocationCoordinate2D](repeating: kCLLocationCoordinate2DInvalid, count: self.pointCount)
        self.getCoordinates(&coords, range: NSRange(location: 0, length: self.pointCount))
        return coords
    }
}
