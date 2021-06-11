import UIKit
import MapmyIndiaMaps
import CoreFoundation
import MapmyIndiaGeofenceUI

struct geofenceShapeData {
    static var currentShapeArr = [MapmyIndiaGeofenceShape]()
    static var backClicked : Bool = false
    static var geofenceNameArray = [String]()
}

protocol shapeSendDataDelegate: class {
    func shapeSend(_ shapeArr: [MapmyIndiaGeofenceShape], geofenView: MapmyIndiaGeofenceView, nameString: [String])
}

class CustomGeofenceVC: UIViewController,UITextFieldDelegate,MapmyIndiaGeofenceViewDelegate,MapmyIndiaMapViewDelegate {
    func didDragGeofence(isdragged: Bool) {
        print("Dragged==")
    }
    
    @IBAction func btnZoomIn(_ sender: Any) {
        geofenceView.mapView.setZoomLevel(geofenceView.mapView.zoomLevel+1, animated: true)
    }
    
    @IBAction func btnZoomOut(_ sender: Any) {
        geofenceView.mapView.setZoomLevel(geofenceView.mapView.zoomLevel-1, animated: true)
    }
    
    @IBOutlet weak var backgroundMapZoomView: UIView!
    @IBOutlet weak var btnDrawing: UIButton!
    @IBAction func btnDrawingClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        geofenceView.isPolygonDrawingEnabled = sender.isSelected
        sender.isSelected = geofenceView.isPolygonDrawingEnabled
    }
    
    @IBOutlet weak var btnPolygonCreationMode: UIButton!
    @IBAction func btnPolygonCreationModeClicked(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        updatePolygonCreationMode()
    }
    
    func updatePolygonCreationMode() {
        if btnPolygonCreationMode.isSelected {
            geofenceView.polygonCreationMode = .tap
        } else {
            geofenceView.polygonCreationMode = .draw
        }
        btnDrawing.isSelected = geofenceView.isPolygonDrawingEnabled
    }
    
    func hasIntersectPoints(_ shape: MapmyIndiaGeofenceShape) {
        print(shape)
        dataGeofence1 = shape as MapmyIndiaGeofenceShape?
    }
    
    func circleRadiusChanged(radius: Double) {
        if(radius > 1000) {
            let new  = String(format: "%.1f", (radius/1000))
            lblSlidarValue.text = "\(new) kms"
        }
        else if(radius > 0) {
            lblSlidarValue.text = "\(Int(radius)) mts"
        }
    }
    
    func didPolygonReachedMaximumPoints() {
        let alertVC = UIAlertController(title: "Limit Reached!", message: "Limit of plotting maximum number of points is reached.", preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func geofenceShapeDidChanged(_ shape: MapmyIndiaGeofenceShape) {
        dataGeofence1 = shape as MapmyIndiaGeofenceShape?
        if shape.polygonCoords?.count ?? 0 > 0 {
            print(shape.polygonCoords as Any)
            polygonPints.removeAll()
            polygonPints = shape.polygonCoords ?? []
            self.toGetPolygonCenterCoordinate()
        }
        self.btnDrawing.isSelected = geofenceView.isPolygonDrawingEnabled
    }
    func geofenceModeChanged(mode: MapmyIndiaOverlayShapeGeometryType) {
        
    }
    
    public weak var delegateShape: shapeSendDataDelegate?
    var polygonPints = [CLLocationCoordinate2D]()
    @IBOutlet weak var bottomBackView: UIView!
    @IBOutlet weak var txtGeofenceName: UITextField!
    public var geofenceName: String?
    public var data: MapmyIndiaGeofenceShape?
    public var dataGeofence1: MapmyIndiaGeofenceShape?
    public var shapeEdit: Bool?
    public var editShapeIndex: Int?
    public var editGeofence: MapmyIndiaGeofenceShape?
    @IBOutlet weak var slider: UISlider!
    
    @IBAction func btnSliderValueChanged(_ sender: UISlider, forEvent event: UIEvent) {
        
        if let touchEvent = event.allTouches?.first {
            switch touchEvent.phase {
            case .began:
                print(sender.value)
                print("Slider Began")
                break
            case .moved:
                print(sender.value)
                print("Slider Moved")
                geofenceView.circleProposedRadius = Double(sender.value)
                break
            case .ended:
                print(sender.value)
                print("Slider Ended")
                geofenceView.mapView.setCenter(CLLocationCoordinate2D(latitude: 28.4971, longitude: 77.0616), animated: false)
                geofenceView.circleRadius = Double(sender.value)
                break
            default:
                break
            }
        }
    }
    
    // Added Annotation
    func addCustomMarkerAnnotation() {
        let annotation = CustomGeofenceAnnotation()
        annotation.title = "new"
        annotation.coordinate = CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025)
        if let image = UIImage(named: "ic_delete_forever.png") {
            annotation.geofenceAnnotationImage = image
        }
        geofenceView.mapView.addAnnotation(annotation)
        geofenceView.mapView.setCenter(CLLocationCoordinate2D(latitude: 28.7041, longitude: 77.1025), animated: false)
    }
    
    func toGetPolygonCenterCoordinate() {
        let center = geofenceView.polygonCenterCoordinate
        print(center ?? CLLocationCoordinate2D())
        let location = MapmyIndiaGeofenceView.centerCoordinateOf(coordinates: polygonPints, mapView: geofenceView.mapView)
        print(location)
    }
    
    @IBAction func btnSlider(_ sender: Any) {
    }
    @IBAction func btnApply(_ sender: Any) {
        print(dataGeofence1 as Any)
        print(geofenceShapeData.currentShapeArr as Any)
        print(dataGeofence1?.circleRadius ?? 0.0)
        let geofenceName = txtGeofenceName.text ?? ""
        if shapeEdit != true {
            geofenceShapeData.currentShapeArr.append(dataGeofence1!)
            geofenceShapeData.geofenceNameArray.append(geofenceName )
            delegateShape?.shapeSend(geofenceShapeData.currentShapeArr,geofenView: geofenceView, nameString: geofenceShapeData.geofenceNameArray)
        }
        else {
            geofenceShapeData.geofenceNameArray[self.editShapeIndex!] = geofenceName ?? ""
            geofenceShapeData.currentShapeArr[self.editShapeIndex!] = dataGeofence1!
            delegateShape?.shapeSend(geofenceShapeData.currentShapeArr,geofenView: geofenceView, nameString: geofenceShapeData.geofenceNameArray)
        }
        if geofenceShapeData.currentShapeArr.count > 5 {
            let alert = UIAlertController(title: "Message", message: "Max Limit is 5 to Draw shape.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
        else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    @IBAction func btnCircle(_ sender: UIButton) {
        slider.isHidden = false
        lblSlidarValue.isHidden  = false
        geofenceView.setMode(mode: .circle)
        self.btnDrawing.isSelected = geofenceView.isPolygonDrawingEnabled
    }
    
    @IBAction func btnPolygon(_ sender: UIButton) {
        slider.isHidden = true
        lblSlidarValue.isHidden  = true
        geofenceView.setMode(mode: .polygon)
        self.btnPolygonCreationMode.isSelected = (geofenceView.polygonCreationMode == .tap)
        self.btnDrawing.isSelected = geofenceView.isPolygonDrawingEnabled
    }
    
    @IBOutlet weak var lblSlidarValue: UILabel!
    var mapView: MapmyIndiaMapView!
    var geofenceView: MapmyIndiaGeofenceView!
    
    @IBOutlet weak var geofenceContainerView: UIView!
    var style1 = MGLStyle()
    
    @objc func btnBack() {
        geofenceShapeData.backClicked = true
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func markerImg(sender: UIBarButtonItem) {
        self.setMarkerInGeofenceView()
    }
    
    @objc func rotate(sender: UIBarButtonItem) {
        let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MapComponantsVC") as? MapComponantsVC
        self.navigationController?.pushViewController(vctrl!, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let leftButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "backArrow"), style: .plain, target: self, action: #selector(btnBack))
        self.navigationItem.leftBarButtonItem = leftButtonItem
        
        self.title = "Custom Geofence"
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        self.geofenceInitiaze()
        if shapeEdit != true {
            
        } else {
            txtGeofenceName.text = geofenceShapeData.geofenceNameArray[editShapeIndex!]
        }
    }
    
    func editShape() {
        if shapeEdit == true {
            if editGeofence?.type?.rawValue == "polygon" {
                slider.isHidden = true
                lblSlidarValue.isHidden  = true
                self.geofenceView.setMode(mode: .polygon)
                DispatchQueue.main.asyncAfter(deadline: .now()+1.0) {
                    self.geofenceView.setGeofenceShape(shape: self.editGeofence!)
                }
            }
            else {
                slider.isHidden = false
                lblSlidarValue.isHidden  = false
                slider.value =  Float(editGeofence?.circleRadius ?? 0.0)
                geofenceView.setMode(mode: .circle)
                geofenceView.setGeofenceShape(shape: editGeofence!)
            }
        }
    }
    
    @objc func submitFeedbackClicked(sender: UIBarButtonItem) {
        self.view.endEditing(true)
        if polygonPints.count > 0 {
            let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PolygonPointsVC") as? PolygonPointsVC
            vctrl?.polygonDirectionPoints = polygonPints
            self.navigationController?.pushViewController(vctrl!, animated: true)
        }
        else {
            let alert = UIAlertController(title: "Message", message: "Please draw polygon shape", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "ok", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }

    func setMarkerInGeofenceView() {
        let currentShape = geofenceView.getGeofenceShape()
        if currentShape.type == .polygon {
            if let coordinate = currentShape.polygonCoords?.first {
                let annotation = CustomGeofenceAnnotation()
                annotation.title = "new"
                annotation.coordinate = coordinate
                if let image = UIImage(named: "ic_delete_forever.png") {
                    annotation.geofenceAnnotationImage = image
                }
                geofenceView.mapView.addAnnotation(annotation)
            }}
    }
    
    func geofenceInitiaze() {
        let view: MapmyIndiaGeofenceView =  {
            geofenceView = MapmyIndiaGeofenceView.init(geofenceframe: geofenceContainerView.bounds)
            return geofenceView
        }()
        view.frame = geofenceContainerView.bounds
        view.delegate = self
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
        
        geofenceView.setCircleCenterCoordinate(coordinate: CLLocationCoordinate2D(latitude: 28.4971, longitude: 77.0616))
        geofenceView.midMarkerViewImage =  UIImage(named: "pinMid")
        geofenceView.deleteControlDefaultIcon = UIImage(named: "ic_delete")
        geofenceView.setGeofenceAnchorPoint = CGPoint(x: 0.5, y: 1.0)
        geofenceView.circleCenterMarker = UIImage(named: "ic_delete")
        geofenceView.geofenceCircleStrokeWidth = CGFloat(UserDefaultsManager.geofenceCircleStrokeWidth)
        geofenceView.geofencePolygonStrokeWidth = CGFloat(UserDefaultsManager.geofencePolygonStrokeWidth)
        
        geofenceView.polygonStrokeColor = UserDefaultsManager.polygonStrokeColor
        geofenceView.polygonFillColor = UserDefaultsManager.polygonFillColor
        geofenceView.toolTipBackgroundColor = .blue
        
        geofenceView.sliderMinTrackColor = UIColor.red
        geofenceView.sliderMaxTrackColor = UIColor.lightGray
        geofenceView.sliderThumbTintColor = UIColor.black
        
        slider.minimumValue = 1000
        slider.maximumValue = 50000
        slider.value = 50000
        geofenceView.circleMinRadius = Double(slider.minimumValue)
        geofenceView.circleMaxRadius = Double(slider.maximumValue)
        geofenceView.circleRadius = Double(slider.value)
        
        geofenceView.markerFillColor = UserDefaultsManager.markerFillColor
        geofenceView.markerStrokeColor = UserDefaultsManager.markerStrokeColor
        
        self.view.addSubview(view)
        
        geofenceView.isPolygonDrawingEnabled = true
        self.btnDrawing.isSelected = geofenceView.isPolygonDrawingEnabled
        view.addSubview(backgroundMapZoomView)
        self.editShape()
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

