
import UIKit
//import MapmyIndiaAPIKit
import MapmyIndiaMaps
import MapmyIndiaGeofenceUI

class DefaultGeofenceVC: UIViewController,MapmyIndiaGeofenceViewDelegate {
    func didDragGeofence(isdragged: Bool) {
        
    }
    
    func hasIntersectPoints(_ shape: MapmyIndiaGeofenceShape) {
        
    }
    
    func circleRadiusChanged(radius: Double) {
        print(radius)
    }
    
    func didPolygonReachedMaximumPoints() {
        
    }
    func geofenceModeChanged(mode: MapmyIndiaOverlayShapeGeometryType) {
        if mode == .circle {
            
        }
        else if mode == .polygon {
        
        }
    }
    
    func geofenceShapeDidChanged(_ shape: MapmyIndiaGeofenceShape) {
        print(shape)
        print(shape.circleCenterCoordinate as Any)
        print(shape.polygonCoords as Any)
        print(shape.type?.rawValue ?? "")
        print(shape.circleRadius as Any)
        
    }
    
    var mapView: MapmyIndiaMapView!
    var geofenceView: MapmyIndiaGeofenceView!
    public var shapeEdit1: Bool?
    public var editShapeIndex1: Int?
    public var editGeofence1: MapmyIndiaGeofenceShape?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Geofence View"
        self.view.backgroundColor = .white
        self.setupGeofenceView()
        self.setupGeofenceConfiguration()
    }
    
    func setupGeofenceView() {
        geofenceView = MapmyIndiaGeofenceView.init(geofenceframe: view.bounds)
        geofenceView?.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        geofenceView.delegate = self
        self.view.addSubview(geofenceView)
    }
    func setupGeofenceConfiguration() {
        
        geofenceView.setMode(mode: .circle)
        geofenceView.draggingEdgesLineColor = UserDefaultsManager.draggingEdgesLineColor
        geofenceView.isShowDeleteControl = true
        geofenceView.isShowDrawingOverlayComponents = true
        geofenceView.polygonDrawingOverlayColor = UserDefaultsManager.polygonDrawingOverlayColor
        geofenceView.convertPointsToClockWise(pointsType: .antiClockWise)
        
        geofenceView.isShowDefaultModePanel = false
        geofenceView.isShowDefaultSliderForCircle = false
        
        geofenceView.circleFillColor = UserDefaultsManager.circleFillColor
        geofenceView.circleStrokeColor = UserDefaultsManager.circleStrokeColor
    }
    
}
