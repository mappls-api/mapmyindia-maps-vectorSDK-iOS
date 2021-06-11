import UIKit
import MapmyIndiaMaps

class PolygonPointsVC: UIViewController,MapmyIndiaMapViewDelegate {

    @IBOutlet weak var mapView: MapmyIndiaMapView!
    
    var directionOfPoints: String = ""
    var polygonDirectionPoints = [CLLocationCoordinate2D]()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Polygon Points Direction"
        self.mapView.delegate = self
        self.mapView.minimumZoomLevel = 8
         self.mapView.maximumZoomLevel = 18

        let polyline = MGLPolygon(coordinates: polygonDirectionPoints, count: UInt(polygonDirectionPoints.count))
                self.mapView.addAnnotation(polyline)
                let shapeCam = self.mapView.cameraThatFitsShape(polyline, direction: CLLocationDirection(0), edgePadding: UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20))
                self.mapView.setCamera(shapeCam, animated: true)
                DispatchQueue.main.async(execute: {
                    [unowned self] in
                     self.newPolygon()
                    self.mapView.showAnnotations(self.mapView.annotations ?? [], animated: true)
                })
        
        
        // Do any additional setup after loading the view.
    }
    func newPolygon()
    {
           var annotations = [MGLPointAnnotation]()
          var number : Int = 0
          for coordinate in polygonDirectionPoints {
                           let annotation = MGLPointAnnotation()
                           annotation.coordinate = coordinate
                           annotation.title = "StartPoint"
                           //annotation.index = 1
                           annotation.subtitle = String(format: "%d",number)
                           annotations.append(annotation)
                            number += 1
                          }
                          
        self.mapView.addAnnotations(annotations)
        self.mapView.showAnnotations(annotations, animated: true)
               
    }

    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
           self.mapView.showsUserLocation = false
      
       }
       
       func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
           // Always allow callouts to popup when annotations are tapped.
           return true
       }
    func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
           // Give our polyline a unique color by checking
           if annotation is MGLPolyline {
               return .red
           }
           return mapView.tintColor
       }
       
       func mapView(_ mapView: MGLMapView, fillColorForPolygonAnnotation annotation: MGLPolygon) -> UIColor {
           return UIColor.red
       }
       
       func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
           // Set the line width for polyline annotations
           return 10.0
       }
       
       func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
           // Set the alpha for all shape annotations to 1 (full opacity)
           return 0.5
       }
    func textToImage(drawText text: String, inImage image: UIImage, atPoint point: CGPoint) -> UIImage {
           UIGraphicsBeginImageContext(image.size)
           image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))
           
           //text attributes
           let font=UIFont(name: "Helvetica-Bold", size: 12)!
           let textStyle=NSMutableParagraphStyle()
           textStyle.alignment=NSTextAlignment.center
           let textColor=UIColor.white
        let textColor1=UIColor.blue
           let attributes=[NSAttributedString.Key.font: font, NSAttributedString.Key.paragraphStyle: textStyle, NSAttributedString.Key.foregroundColor: textColor,NSAttributedString.Key.backgroundColor: textColor1]
           
           //vertically center (depending on font)
           let texth=font.lineHeight
           let texty=(image.size.height-texth)/2
           let textrect=CGRect(x: 0, y: texty, width: image.size.width, height: texth)
           text.draw(in: textrect.integral, withAttributes: attributes)
           let result=UIGraphicsGetImageFromCurrentImageContext()
           UIGraphicsEndImageContext()
           return result!
       }
       
       func mapView(_ mapView: MGLMapView, viewFor annotation: MGLAnnotation) -> MGLAnnotationView? {
          
        guard annotation is MGLPointAnnotation else {
                   return nil
               }
        let castAnnotation = annotation as? MGLPointAnnotation
        if castAnnotation?.title  == "StartPoint" {
            
        let reuseIdentifier = "StartPoint"
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseIdentifier)
            
        var image1 = UIImage()
        image1 = UIImage(named: "IconPin.png") ?? UIImage()
            image1 = self.textToImage(drawText: String(format: "%@", castAnnotation?.subtitle ?? ""), inImage: image1, atPoint: CGPoint.zero)
                                             
         annotationView = CustomImageAnnotationView(reuseIdentifier: reuseIdentifier, image: image1)
              return annotationView
        }
            print("ABC")
            return nil
       }

}
class CustomImageAnnotationView1: MGLAnnotationView {
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
    

