//
//  ClusterMarlersExample.swift
//  MapDemo
//
//  Created by apple on 14/08/19.
//  Copyright © 2019 MMI. All rights reserved.
//

import MapmyIndiaMaps

class CustomPointFeature: MGLPointFeature {
    init(coordinate: CLLocationCoordinate2D) {
        super.init()
        self.coordinate = coordinate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

@objc(ClusterMarkersExample_Swift)
class ClusterMarkersExample_Swift: UIViewController {
    let sourceIdentifier = "clusteredSourceIdentifier"
    let unclusterLayerIdentifier = "unclusterLayerIdentifier"
    let clusterLayerIdentifier = "clusterLayerIdentifier"
    let clusterLayerCountIdentifier = "clusterLayerCountIdentifier"
    
    var mapView: MapmyIndiaMapView!
    var icon: UIImage!
    var popup: UIView?
     var strType:String?
    enum CustomError: Error {
        case castingError(String)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = strType
        mapView = MapmyIndiaMapView(frame: view.bounds)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.tintColor = .darkGray
        mapView.delegate = self
        view.addSubview(mapView)
        
        // Add a double tap gesture recognizer. This gesture is used for double
        // tapping on clusters and then zooming in so the cluster expands to its
        // children.
        let doubleTap = UITapGestureRecognizer(target: self, action: #selector(handleDoubleTapCluster(sender:)))
        doubleTap.numberOfTapsRequired = 2
        doubleTap.delegate = self
        
        // It's important that this new double tap fails before the map view's
        // built-in gesture can be recognized. This is to prevent the map's gesture from
        // overriding this new gesture (and then not detecting a cluster that had been
        // tapped on).
        for recognizer in mapView.gestureRecognizers!
            where (recognizer as? UITapGestureRecognizer)?.numberOfTapsRequired == 2 {
                recognizer.require(toFail: doubleTap)
        }
        mapView.addGestureRecognizer(doubleTap)
        
        // Add a single tap gesture recognizer. This gesture requires the built-in
        // MGLMapView tap gestures (such as those for zoom and annotation selection)
        // to fail (this order differs from the double tap above).
        let singleTap = UITapGestureRecognizer(target: self, action: #selector(handleMapTap(sender:)))
        for recognizer in mapView.gestureRecognizers! where recognizer is UITapGestureRecognizer {
            singleTap.require(toFail: recognizer)
        }
        mapView.addGestureRecognizer(singleTap)
        
        icon = UIImage(named: "Vehicle")
    }
    
    func drawLayerOnMap(style: MGLStyle) {
        let pointFeatures = [
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.551635, 77.268805)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.551041, 77.267979)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.552115, 77.265833)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.559786, 77.238859)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.561535, 77.233345)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.562469, 77.235072)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.435931, 77.304689)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.436214, 77.304936)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.438827, 77.308337)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.489028, 77.091252)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.486831, 77.094492)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.486491, 77.094374)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.491510, 77.082149)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.474800, 77.065233)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.471245, 77.072722)),
            CustomPointFeature(coordinate: CLLocationCoordinate2DMake(28.458440, 77.073179)),
            //CustomPointFeature(coordinate: CLLocationCoordinate2DMake()),
        ]
        
        let shape = MGLShapeCollectionFeature(shapes: pointFeatures)
        
        let source = MGLShapeSource(identifier: sourceIdentifier, shape: shape, options: [.clustered: true, .clusterRadius: icon.size.width])
        style.addSource(source)
        
        // Use a template image so that we can tint it with the `iconColor` runtime styling property.
        style.setImage(icon.withRenderingMode(.alwaysTemplate), forName: "icon")
        
        // Show unclustered features as icons. The `cluster` attribute is built into clustering-enabled
        // source features.
        let ports = MGLSymbolStyleLayer(identifier: unclusterLayerIdentifier, source: source)
        ports.iconImageName = NSExpression(forConstantValue: "icon")
        ports.iconColor = NSExpression(forConstantValue: UIColor.darkGray.withAlphaComponent(0.9))
        ports.predicate = NSPredicate(format: "cluster != YES")
        ports.iconAllowsOverlap = NSExpression(forConstantValue: true)
        style.addLayer(ports)
        
        // Color clustered features based on clustered point counts.
        let stops = [
            20: UIColor.lightGray,
            50: UIColor.orange,
            100: UIColor.red,
            200: UIColor.purple
        ]
        
        // Show clustered features as circles. The `point_count` attribute is built into
        // clustering-enabled source features.
        let circlesLayer = MGLCircleStyleLayer(identifier: clusterLayerIdentifier, source: source)
        circlesLayer.circleRadius = NSExpression(forConstantValue: NSNumber(value: Double(icon.size.width) / 2))
        circlesLayer.circleOpacity = NSExpression(forConstantValue: 0.75)
        circlesLayer.circleStrokeColor = NSExpression(forConstantValue: UIColor.white.withAlphaComponent(0.75))
        circlesLayer.circleStrokeWidth = NSExpression(forConstantValue: 2)
        circlesLayer.circleColor = NSExpression(format: "mgl_step:from:stops:(point_count, %@, %@)", UIColor.lightGray, stops)
        circlesLayer.predicate = NSPredicate(format: "cluster == YES")
        style.addLayer(circlesLayer)
        
        // Label cluster circles with a layer of text indicating feature count. The value for
        // `point_count` is an integer. In order to use that value for the
        // `MGLSymbolStyleLayer.text` property, cast it as a string.
        
        let numbersLayer = MGLSymbolStyleLayer(identifier: clusterLayerCountIdentifier, source: source)
        numbersLayer.textColor = NSExpression(forConstantValue: UIColor.black)
        numbersLayer.textFontSize = NSExpression(forConstantValue: NSNumber(value: Double(icon.size.width) / 2))
        numbersLayer.iconAllowsOverlap = NSExpression(forConstantValue: true)
        numbersLayer.text = NSExpression(format: "CAST(point_count, 'NSString')")
        numbersLayer.textFontNames = NSExpression(forConstantValue: ["Open Sans Bold"])
        
        numbersLayer.predicate = NSPredicate(format: "cluster == YES")
        style.addLayer(numbersLayer)
 
        
        let shapeCam = mapView.cameraThatFitsShape(shape, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        mapView.setCamera(shapeCam, animated: false)
    }
    
    private func firstCluster(with gestureRecognizer: UIGestureRecognizer) -> MGLPointFeatureCluster? {
        let point = gestureRecognizer.location(in: gestureRecognizer.view)
        let width = icon.size.width
        let rect = CGRect(x: point.x - width / 2, y: point.y - width / 2, width: width, height: width)
        
        // This example shows how to check if a feature is a cluster by
        // checking for that the feature is a `MGLPointFeatureCluster`. Alternatively, you could
        // also check for conformance with `MGLCluster` instead.
        let features = mapView.visibleFeatures(in: rect, styleLayerIdentifiers: [clusterLayerIdentifier, unclusterLayerIdentifier])
        let clusters = features.compactMap { $0 as? MGLPointFeatureCluster }
        
        // Pick the first cluster, ideally selecting the one nearest nearest one to
        // the touch point.
        return clusters.first
    }
    
    @objc func handleDoubleTapCluster(sender: UITapGestureRecognizer) {
        
        guard let source = mapView.style?.source(withIdentifier: sourceIdentifier) as? MGLShapeSource else {
            return
        }
        
        guard sender.state == .ended else {
            return
        }
        
        showPopup(false, animated: false)
        
        guard let cluster = firstCluster(with: sender) else {
            return
        }
        
        let zoom = source.zoomLevel(forExpanding: cluster)
        
        if zoom > 0 {
            mapView.setCenter(cluster.coordinate, zoomLevel: zoom, animated: true)
        }
    }
    
    @objc func handleMapTap(sender: UITapGestureRecognizer) {
        
        guard let source = mapView.style?.source(withIdentifier: sourceIdentifier) as? MGLShapeSource else {
            return
        }
        
        guard sender.state == .ended else {
            return
        }
        
        showPopup(false, animated: false)
        
        let point = sender.location(in: sender.view)
        let width = icon.size.width
        let rect = CGRect(x: point.x - width / 2, y: point.y - width / 2, width: width, height: width)
        
        let features = mapView.visibleFeatures(in: rect, styleLayerIdentifiers: [clusterLayerIdentifier, unclusterLayerIdentifier])
        
        // Pick the first feature (which may be a port or a cluster), ideally selecting
        // the one nearest nearest one to the touch point.
        guard let feature = features.first else {
            return
        }
        
        let description: String
        let color: UIColor
        
        if let cluster = feature as? MGLPointFeatureCluster {
            // Tapped on a cluster.
            let children = source.children(of: cluster)
            description = "Cluster #\(cluster.clusterIdentifier)\n\(children.count) children"
            color = .blue
        } else if let featureName = feature.attribute(forKey: "name") as? String?,
            // Tapped on a port.
            let portName = featureName {
            description = portName
            color = .black
        } else {
            // Tapped on a port that is missing a name.
            description = "No port name"
            color = .red
        }
        
        popup = popup(at: feature.coordinate, with: description, textColor: color)
        
        showPopup(true, animated: true)
    }
    
    // Convenience method to create a reusable popup view.
    private func popup(at coordinate: CLLocationCoordinate2D, with description: String, textColor: UIColor) -> UIView {
        let popup = UILabel()
        
        popup.backgroundColor     = UIColor.white.withAlphaComponent(0.9)
        popup.layer.cornerRadius  = 4
        popup.layer.masksToBounds = true
        popup.textAlignment       = .center
        popup.lineBreakMode       = .byTruncatingTail
        popup.numberOfLines       = 0
        popup.font                = .systemFont(ofSize: 16)
        popup.textColor           = textColor
        popup.alpha               = 0
        popup.text                = description
        
        popup.sizeToFit()
        
        // Expand the popup.
        popup.bounds = popup.bounds.insetBy(dx: -10, dy: -10)
        let point = mapView.convert(coordinate, toPointTo: mapView)
        popup.center = CGPoint(x: point.x, y: point.y - 50)
        
        return popup
    }
    
    func showPopup(_ shouldShow: Bool, animated: Bool) {
        guard let popup = self.popup else {
            return
        }
        
        if shouldShow {
            view.addSubview(popup)
        }
        
        let alpha: CGFloat = (shouldShow ? 1 : 0)
        
        let animation = {
            popup.alpha = alpha
        }
        
        let completion = { (_: Bool) in
            if !shouldShow {
                popup.removeFromSuperview()
            }
        }
        
        if animated {
            UIView.animate(withDuration: 0.25, animations: animation, completion: completion)
        } else {
            animation()
            completion(true)
        }
    }
}

extension ClusterMarkersExample_Swift: UIGestureRecognizerDelegate {
    
    public func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // This will only get called for the custom double tap gesture,
        // that should always be recognized simultaneously.
        return true
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        // This will only get called for the custom double tap gesture.
        return firstCluster(with: gestureRecognizer) != nil
    }
}

extension ClusterMarkersExample_Swift: MapmyIndiaMapViewDelegate {
    func mapViewRegionIsChanging(_ mapView: MGLMapView) {
        showPopup(false, animated: false)
    }

    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        drawLayerOnMap(style: style)
    }
}
