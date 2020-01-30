//
//
//  Created by Ayush Dayal on 21/01/20.
//  Copyright © 2020 MapmyIndia. All rights reserved.
//

import UIKit
import Mapbox
import MapmyIndiaAPIKit

class InteractiveMarkerVC: UIViewController {
    var mapView:MapmyIndiaMapView!
    var strType:String?
    var polylineSource: MGLShapeSource?
    let annotation = MGLPointAnnotation()
    let destinationCoordinate = CLLocationCoordinate2D(latitude: 28.551438, longitude: 77.26319)
    var isForCustomAnnotationView = false
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
         self.title = strType
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.showsUserLocation = true
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(destinationCoordinate, zoomLevel: 11, animated: false)
        mapView.delegate = self
        view.addSubview(mapView)
    }
    
    func customMarker(){
        let coordinates = [
            CLLocationCoordinate2D(latitude: 28.550643, longitude: 77.268954),
            CLLocationCoordinate2D(latitude: 28.521438, longitude: 77.265179),
            CLLocationCoordinate2D(latitude: 28.571438, longitude: 77.26509),
            CLLocationCoordinate2D(latitude: 28.551438, longitude: 77.26319),
            CLLocationCoordinate2D(latitude: 28.511438, longitude: 77.261119),
            CLLocationCoordinate2D(latitude: 28.552438, longitude: 77.262119),
        ]
        var pointAnnotations = [CustomPointAnnotation]()
        for coordinate in coordinates {
            let count = pointAnnotations.count + 1
            let point = CustomPointAnnotation(coordinate: coordinate,title: "Custom Point Annotation \(count)",subtitle: nil)
            point.reuseIdentifier = "customAnnotation\(count)"
            point.image = UIImage(named:"marker\(count)")
            // Append each annotation to the array, which will be added to the map all at once.
            pointAnnotations.append(point)
        }
        mapView.addAnnotations(pointAnnotations)
        if let annotations = mapView.annotations {
            mapView.showAnnotations(annotations, animated: true)
        }
    }
    
    
    func imageWithImage(image:UIImage, scaledToSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0)
        image.draw(in: CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }
    
  
}

extension InteractiveMarkerVC: MapmyIndiaMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        DispatchQueue.main.async {
             self.customMarker()
        }
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
         // Always allow callouts to popup when annotations are tapped.
         return true
     }
     
     func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
         return 0.5
     }
     
     func mapView(_ mapView: MGLMapView, imageFor annotation: MGLAnnotation) -> MGLAnnotationImage? {
           if let point = annotation as? CustomPointAnnotation,
               let image = point.image,
               let reuseIdentifier = point.reuseIdentifier {
               
               if let annotationImage = mapView.dequeueReusableAnnotationImage(withIdentifier: reuseIdentifier) {
                   // The annotatation image has already been cached, just reuse it.
                   return annotationImage
               } else {
                   // Create a new annotation image.
                   return MGLAnnotationImage(image: image, reuseIdentifier: reuseIdentifier)
               }
           }
           // Fallback to the default marker image.
           return nil
       }
     
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
            if isForCustomAnnotationView {
                let annotationView = MGLAnnotationView()
                annotationView.bounds = CGRect(x: 0, y: 0, width: 20, height: 20)
                annotationView.backgroundColor = UIColor.blue
                return annotationView
            } else {
                guard annotation is CustomPointAnnotation, let customPointAnnotation = annotation as? CustomPointAnnotation else {
                    return nil
                }
                // Use the point annotation’s longitude value (as a string) as the reuse identifier for its view.
                let reuseIdentifier = "\(customPointAnnotation.coordinate.longitude)"
                 
                // For better performance, always try to reuse existing annotations.
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
                 
                // If there’s no reusable annotation view available, initialize a new one.
                if annotationView == nil {
                     
                  //  let img = UIImage()
                    annotationView = CustomAnnotationView(reuseIdentifier: reuseIdentifier, image: customPointAnnotation.image!)
                    
                }
                return annotationView
            }
        }

     
     func mapView(_ mapView: MGLMapView, didSelect annotation: MGLAnnotation) {
         
         if let point = annotation as? CustomPointAnnotation
         {
             //point.image = self.imageWithImage(image: UIImage(named: "icon1.png")!, scaledToSize: CGSize(width: 3.0, height: 3.0))
         }
            //mapView.addAnnotation(point!)
     }
}


class CustomAnnotationView: MGLAnnotationView {
    var imageView = UIImageView()
  
    init(reuseIdentifier: String?, image: UIImage) {
        super.init(reuseIdentifier: reuseIdentifier)
        self.imageView.image = image
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layer.cornerRadius = bounds.width
        layer.borderWidth = 2
        layer.borderColor = UIColor.clear.cgColor
      //  centerOffset = CGVector(dx: 0.0, dy: layer.bounds.height)
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected == true
        {
            let animation = CABasicAnimation(keyPath: "borderWidth")
            animation.duration = 0.1
            layer.add(animation, forKey: "borderWidth")
            let selectedImg = self.imageView.image
            let myImage = selectedImg?.cgImage
            layer.bounds = CGRect(x: 0, y: 0, width: 80, height: 80)
            layer.contents = myImage
            layer.anchorPoint = CGPoint(x: 0.5, y: 0.5)
            layer.setNeedsLayout()
        }
        else
        {
             let nonSelectedImg = self.imageView.image
             let myImage =   nonSelectedImg?.cgImage
             layer.bounds = CGRect(x: 0, y: 0, width: 40, height: 40)
             layer.contents = myImage
             layer.setNeedsLayout()
        }
    }
}


