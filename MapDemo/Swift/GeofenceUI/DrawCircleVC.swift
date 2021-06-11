import UIKit
import MapmyIndiaMaps
import MapmyIndiaGeofenceUI

class DrawCircleVC: UIViewController,MapmyIndiaMapViewDelegate,shapeSendDataDelegate {
    
    func shapeSend(_ shapeArr: [MapmyIndiaGeofenceShape], geofenView: MapmyIndiaGeofenceView, nameString: [String] ) {
        geofenceShape.removeAll()
        print(shapeArr.first?.polygonCoords as Any)
        geofenceShape = shapeArr
        shapeGeofenceView = geofenView
        name = nameString
        tblShape.reloadData()
    }
    
    @IBOutlet weak var mapview: MapmyIndiaMapView!
    @IBOutlet weak var tblShape: UITableView!
    @IBOutlet weak var btnAddGeofence: UIButton!

    var geofenceShape = [MapmyIndiaGeofenceShape]()
    var name: [String] = [String]()
    var flagSwitchOffOnLunch: Bool = false
    var switchIndex : [Int] = []
    
    @IBAction func btnGeofence(_ sender: Any) {
        let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomGeofenceVC") as? CustomGeofenceVC
        vctrl?.delegateShape = self
        self.navigationController?.pushViewController(vctrl!, animated: true)
    }
    
    var shapeGeofenceView: MapmyIndiaGeofenceView?
    override func viewWillAppear(_ animated: Bool) {
        if geofenceShapeData.backClicked != true {
            geofenceShapeData.backClicked = false
            if let annotation1 = mapview.annotations {
                mapview.removeAnnotations(annotation1)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.setHidesBackButton(false, animated: true);
        self.tblShape.register(UINib(nibName: "ShapeCell", bundle: nil), forCellReuseIdentifier: "ShapeCell")
        mapview.delegate = self
        mapview.zoomLevel = 4
        print(geofenceShape.first?.type?.rawValue ?? "")
        mapview.setCenter(CLLocationCoordinate2D(latitude: 28.550845, longitude: 77.268955), zoomLevel: 4, animated: false)
    }
    
    func polygon(polygonCoordinate: [CLLocationCoordinate2D]) {
        let polygon1 = MGLPolygon(coordinates: polygonCoordinate, count: UInt(polygonCoordinate.count))
        mapview.addAnnotation(polygon1)
        let shapeCam1 = mapview.cameraThatFitsShape(polygon1, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
        mapview.setCamera(shapeCam1, animated: false)
        DispatchQueue.main.async(execute: {
            [unowned self] in
            self.mapview.showAnnotations(self.mapview.annotations ?? [], animated: true)
        })
        var annotations = [MGLPointAnnotation]()
        var number : Int = 0
        for coordinate in polygonCoordinate {
            let annotation = MGLPointAnnotation()
            annotation.coordinate = coordinate
            annotation.title = "polygon"
            annotation.subtitle = String(format: "%d",number)
            annotations.append(annotation)
            number += 1
        }
        self.mapview.addAnnotations(annotations)
    }
    
    func drawCircle(circleCoordinate: CLLocationCoordinate2D, radius: Double) {
        let circleCoordinates1 = MapmyIndiaGeofenceView.getCircleCoordinate(centerCoordinate: circleCoordinate, radius: radius)
        if circleCoordinates1?.count ?? 0 > 0 {
            let polygon1 = MGLPolygon(coordinates: circleCoordinates1!, count: UInt(circleCoordinates1!.count))
            mapview.addAnnotation(polygon1)
            DispatchQueue.main.async(execute: {
                [unowned self] in
                self.mapview.showAnnotations(self.mapview.annotations ?? [], animated: true)
            })
            let annotation = MGLPointAnnotation()
            annotation.coordinate = circleCoordinate
            annotation.title = "circle"
            annotation.subtitle = String(format: "%d",1)
            self.mapview.addAnnotation(annotation)
        }
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
    }
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
        return UIColor.blue
    }
    func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
        return UIColor.red
    }
    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
        return 20.0
    }
    
    func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
        return 8.0
    }
    
    func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
        
        guard annotation is MGLPointAnnotation else {
            return nil
        }
        let castAnnotation = annotation as? MGLPointAnnotation
        if castAnnotation?.title  == "circle" {
            
            let reuseIdentifier = "StartPoint"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            
            var image1 = UIImage()
            image1 = UIImage(named: "IconPin.png") ?? UIImage()
            annotationView = CustomImageAnnotationView(reuseIdentifier: reuseIdentifier, image: image1)
            return annotationView
        }
        
        else  if castAnnotation?.title  == "polygon" {
            let reuseIdentifier = "StartPoint"
            var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            var image1 = UIImage()
            image1 = UIImage(named: "IconPin.png") ?? UIImage()
            annotationView = CustomImageAnnotationView(reuseIdentifier: reuseIdentifier, image: image1)
            return annotationView
        }
        return nil
    }
}

class CustomImageAnnotationView: MGLAnnotationView {
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

extension DrawCircleVC: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return geofenceShape.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "ShapeCell", for: indexPath) as? ShapeCell else {
            return UITableViewCell()
        }
        let list = geofenceShape[indexPath.row]
        cell.lblGeofenceName.text = name[indexPath.row]
        cell.ShapeSwitch.tag = indexPath.row
        cell.ShapeSwitch.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
        cell.btnEdit.addTarget(self, action: #selector(self.editClicked), for: .touchUpInside)
        cell.btnEdit.tag = indexPath.row
        
        cell.btnDelete.addTarget(self, action: #selector(self.deleteClicked), for: .touchUpInside)
        cell.btnDelete.tag = indexPath.row
        
        if switchIndex.contains(indexPath.row) {
            cell.ShapeSwitch.setOn(true, animated: true)
        } else {
            cell.ShapeSwitch.setOn(false, animated: true)
        }
        
        if list.type?.rawValue == "polygon" {
            self.polygon(polygonCoordinate: list.polygonCoords!)
        }
        else {
            self.drawCircle(circleCoordinate: list.circleCenterCoordinate!, radius: list.circleRadius ?? 0.0)
        }
        return cell
    }
    
    @objc func deleteClicked(_ sender : UIButton!) {
        geofenceShapeData.currentShapeArr.remove(at: sender.tag)
        geofenceShape.remove(at: sender.tag)
        for index in switchIndex {
            if index == sender.tag {
                switchIndex.remove(at: sender.tag)
            }
        }
        
        if let annotation1 = mapview.annotations {
            mapview.removeAnnotations(annotation1)
        }
        tblShape.reloadData()
    }
    
    @objc func editClicked(_ sender : UIButton!) {
        print(sender.tag as Any)
        let shapelist = geofenceShape[sender.tag]
        print(shapelist.type?.rawValue ?? "")
        let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CustomGeofenceVC") as? CustomGeofenceVC
        vctrl?.shapeEdit = true
        vctrl?.editGeofence = shapelist
        vctrl?.editShapeIndex = sender.tag
        vctrl?.delegateShape = self
        self.navigationController?.pushViewController(vctrl!, animated: true)
    }
    
    @objc func switchChanged(_ sender : UISwitch!){
        
        print("table row switch Changed \(sender.tag)")
        print("The switch is \(sender.isOn ? "ON" : "OFF")")
        _ = geofenceShape[sender.tag]
        print(switchIndex)
        flagSwitchOffOnLunch = true
        if let cell1: ShapeCell = tblShape.cellForRow(at: IndexPath(row: sender.tag, section: 0)) as? ShapeCell {
            print(cell1)
            if cell1.ShapeSwitch.isOn {
                switchIndex.append(sender.tag)
            } else {
                print(sender.tag)
            }}
        
        var selectedShapes = [MapmyIndiaGeofenceShape]()
        var selectedShapesCoordinates = [CLLocationCoordinate2D]()
        for index in 0...geofenceShape.count {
            if let cell: ShapeCell = tblShape.cellForRow(at: IndexPath(row: index, section: 0)) as? ShapeCell {
                print(cell)
                if cell.ShapeSwitch.isOn {
                    let shape = geofenceShape[index]
                    selectedShapes.append(shape)
                    if shape.type?.rawValue == "polygon" {
                        selectedShapesCoordinates.append(contentsOf: shape.polygonCoords ?? [])
                    }
                    else {
                        let circleCoordinates1 = MapmyIndiaGeofenceView.getCircleCoordinate(centerCoordinate: shape.circleCenterCoordinate!, radius: shape.circleRadius ?? 0.0)
                        selectedShapesCoordinates.append(contentsOf: circleCoordinates1 ?? [])
                    }
                }
            }
        }
        
        if selectedShapesCoordinates.count > 0 {
            let circle = MGLPolygon(coordinates: selectedShapesCoordinates , count: UInt(selectedShapesCoordinates.count))
            let shapeCam1 = mapview.cameraThatFitsShape(circle, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
            mapview.setCamera(shapeCam1, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
