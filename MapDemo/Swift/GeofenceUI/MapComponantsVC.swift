//
//  MapComponantsVC.swift
//  GeofenceUISample
//
//  Created by Abhinav on 17/07/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import UIKit
import MapmyIndiaMaps
import MapmyIndiaAPIKit

class MyCustomPointAnnotation: MGLPointAnnotation {

    // Change The Value for Rotating Car Image Position
    var heading: CGFloat!
}

class MapComponantsVC: UIViewController,MapmyIndiaMapViewDelegate {

    @IBOutlet weak var rotateMapview: MapmyIndiaMapView!
   
  //  func degreesToRadians(degrees: Double) -> Double { return degrees * .pi / 180.0 }
  //  func radiansToDegrees(radians: Double) -> Double { return radians * 180.0 / .pi }
       
    var busPoint = MyCustomPointAnnotation()

    var headingArr = [120, 130, 140 ,180,90,60,89,80]
    var count: Int = 0
    
    var timerForHeading: Timer?
    var currentLocationAnnotation = MGLPointAnnotation()
    var annotationArray = [MGLPointAnnotation]()

    @IBAction func btnLocationChanged(_ sender: Any) {
        
         currentLocationAnnotation = MGLPointAnnotation()
         currentLocationAnnotation.coordinate = CLLocationCoordinate2D(latitude: 26.9124, longitude: 75.7873)
         rotateMapview.setCenter(CLLocationCoordinate2D(latitude: 26.9124, longitude: 75.7873), zoomLevel: 14, animated: false)
         rotateMapview.addAnnotation(currentLocationAnnotation)
             
         self.annotationArray.append(currentLocationAnnotation)
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        rotateMapview.delegate = self
        rotateMapview.zoomLevel = 18
        
       // timerForHeading = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(headingChanged), userInfo: nil, repeats: true)

        // Do any additional setup after loading the view.
    }
    
    @IBAction func btnTapped(_ sender: Any) {
        
        self.markerFlicker()
    }
    
    func markerFlicker()
    {
        //rotateMapview.removeAnnotation(currentLocationAnnotation)
       currentLocationAnnotation = MGLPointAnnotation()
        currentLocationAnnotation.coordinate = CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025)
        rotateMapview.setCenter(CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025), zoomLevel: 14, animated: false)
        rotateMapview.addAnnotation(currentLocationAnnotation)
            
        self.annotationArray.append(currentLocationAnnotation)
        
    }
    
   @objc func headingChanged()
    {
        self.changeHeading()
    }
    
    func setBusLocation(heading: CGFloat)
    {
        rotateMapview.removeAnnotation(busPoint)
        busPoint = MyCustomPointAnnotation()
        busPoint.coordinate = CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025)
        busPoint.title = "car"
        busPoint.heading = heading
        rotateMapview.addAnnotation(busPoint)
        rotateMapview.setCenter(busPoint.coordinate, zoomLevel: 18, animated: true)
        count += 1
    }
    
    func changeHeading()
    {
        if count == headingArr.count
               {
                timerForHeading?.invalidate()
                   return
               }
               
         let headingValue = headingArr[count]
        self.setBusLocation(heading: CGFloat(headingValue))
    }
    

    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        //rotateMapview.setCenter(CLLocationCoordinate2DMake(28.7041, 77.1025), animated: true)
          self.setBusLocation(heading: 120)
    }
   
    
      func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
            guard annotation is MGLPointAnnotation else {
                return nil
            }
            let castAnnotation = annotation as? MyCustomPointAnnotation
      
                let reuseIdentifier = "car"
                // For better performance, always try to reuse existing annotations.
                var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
                // If there’s no reusable annotation view available, initialize a new one.
                if annotationView == nil {
                    annotationView = CustomImageAnnotationViewNew(reuseIdentifier: reuseIdentifier, image: UIImage(named: "rotateImg")!)
                }
        annotationView = self.getAnnotationAngle(withView: annotationView!,heading: castAnnotation?.heading ?? 0.0)
                
                return annotationView
     
        }
        
    func getAnnotationAngle(withView: MGLAnnotationView, heading: CGFloat) -> MGLAnnotationView {

            var course = CGFloat()
             course  = heading
          //  course = CGFloat((200).floatValue ?? 90)
            let rotation: CGFloat = -MGLRadiansFromDegrees(rotateMapview.direction - Double(course))
            // If the difference would be perceptible, rotate the arrow.
            if abs(rotation) > 0.01 {
                // Disable implicit animations of this rotation, which reduces lag between changes.
                CATransaction.begin()
                CATransaction.setDisableActions(true)
                withView.layer.setAffineTransform(CGAffineTransform.identity.rotated(by: rotation))
                CATransaction.commit()
            }
            return withView
        }
    

    class CustomImageAnnotationViewNew: MGLAnnotationView {
        var imageView: UIImageView!
        
        required init(reuseIdentifier: String?, image: UIImage) {
            super.init(reuseIdentifier: reuseIdentifier)
            
            self.imageView = UIImageView(image: image)
            self.addSubview(self.imageView)
            self.frame = self.imageView.frame
        }
        
        required init?(coder aDecoder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
        
        override init(frame: CGRect) {
            super.init(frame: frame)
        }
    }

    
    
}
