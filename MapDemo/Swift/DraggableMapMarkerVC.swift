//
//  DraggableMapMarkerVC.swift
//  MapDemo
//
//  Created by apple on 20/05/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit
import MapmyIndiaMaps

@objc(DraggableMapMarkerVC_Swift)
class DraggableMapMarkerVC_Swift: UIViewController, MapmyIndiaMapViewDelegate {
    
    var mapView: MapmyIndiaMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .darkGray
        
        mapView.setCenter(CLLocationCoordinate2D(latitude: 28.543253, longitude: 77.261647), zoomLevel: 10, animated: false)
        
        mapView.delegate = self
        view.addSubview(mapView)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: view.bounds.size.width, height: 30))
        label.text = "Tap and hold marker to start dragging."
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 12)
        label.backgroundColor = .white
        label.textColor = .black
        view.addSubview(label)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11.0, *) {
            label.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        } else {
            label.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        }
        if #available(iOS 11.0, *) {
            label.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        } else {
            label.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        }
        if #available(iOS 11.0, *) {
            label.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        } else {
            label.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        }
        label.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        // Specify coordinates for our annotations.
        let coordinates = [
            CLLocationCoordinate2DMake(28.615119, 77.355378),
            CLLocationCoordinate2DMake(28.598820, 77.244549),
            CLLocationCoordinate2DMake(28.583224, 77.214681)
        ]
        
        // Fill an array with point annotations and add it to the map.
        var pointAnnotations = [MGLPointAnnotation]()
        for coordinate in coordinates {
            let point = MGLPointAnnotation()
            point.coordinate = coordinate
            point.title = "To drag this annotation, first tap and hold."
            pointAnnotations.append(point)
        }
        
        mapView.addAnnotations(pointAnnotations)
    }
}

//MARK: MapmyIndiaMapViewDelegate Implementation
extension DraggableMapMarkerVC_Swift {
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        // This example is only concerned with point annotations.
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        
        // For better performance, always try to reuse existing annotations. To use multiple different annotation views, change the reuse identifier for each.
        if let annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "draggableMapMarkerView") {
            return annotationView
        } else {
            return DraggableMapMarkerView(reuseIdentifier: "draggableMapMarkerView", size: 50)
        }
    }
    
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
}


// Custom MGLAnnotationView class
class DraggableMapMarkerView: MGLAnnotationView {
    init(reuseIdentifier: String, size: CGFloat) {
        super.init(reuseIdentifier: reuseIdentifier)
        
        // `isDraggable` is a property of MGLAnnotationView, disabled by default.
        isDraggable = true
        
        // This property prevents the annotation from changing size when the map is tilted.
        scalesWithViewingDistance = false
        
        // Begin setting up the view.
        frame = CGRect(x: 0, y: 0, width: size, height: size)
        
        backgroundColor = .darkGray
        
        // Use CALayer’s corner radius to turn this view into a circle.
        layer.cornerRadius = size / 2
        layer.borderWidth = 1
        layer.borderColor = UIColor.white.cgColor
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
    }
    
    // These two initializers are forced upon us by Swift.
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Custom handler for changes in the annotation’s drag state.
    override func setDragState(_ dragState: MGLAnnotationViewDragState, animated: Bool) {
        super.setDragState(dragState, animated: animated)
        
        switch dragState {
        case .starting:
            print("Starting", terminator: "")
            startDragging()
        case .dragging:
            print(".", terminator: "")
        case .ending, .canceling:
            print("Ending")
            endDragging()
        case .none:
            break
        @unknown default:
            fatalError("Unknown drag state")
        }
    }
    
    // When the user interacts with an annotation, animate opacity and scale changes.
    func startDragging() {
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.layer.opacity = 0.8
            self.transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        }, completion: nil)
        
        // Initialize haptic feedback generator and give the user a light thud.
        if #available(iOS 10.0, *) {
            let hapticFeedback = UIImpactFeedbackGenerator(style: .light)
            hapticFeedback.impactOccurred()
        }
    }
    
    func endDragging() {
        transform = CGAffineTransform.identity.scaledBy(x: 1.5, y: 1.5)
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0, options: [], animations: {
            self.layer.opacity = 1
            self.transform = CGAffineTransform.identity.scaledBy(x: 1, y: 1)
        }, completion: nil)
        
        // Give the user more haptic feedback when they drop the annotation.
        if #available(iOS 10.0, *) {
            let hapticFeedback = UIImpactFeedbackGenerator(style: .light)
            hapticFeedback.impactOccurred()
        }
    }
}
