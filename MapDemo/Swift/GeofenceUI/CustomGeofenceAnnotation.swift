import UIKit
import MapmyIndiaMaps
import MapmyIndiaGeofenceUI

class CustomGeofenceAnnotation: MGLPointAnnotation,GeofenceAnnotation {
   
    var reuseIdenfier: String? = "GeofenceMarker"
    var geofenceAnnotationImage: UIImage? = UIImage(named: "")

}
