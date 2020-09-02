import UIKit
import MapmyIndiaMaps
import MapmyIndiaUIWidgets

protocol PlacePickerViewExampleVCDelegate: class {
    func didPickedLocation(viewController: PlacePickerViewExampleVC, placemark: MapmyIndiaGeocodedPlacemark)
    
    func didReverseGeocode(viewController: PlacePickerViewExampleVC, placemark: MapmyIndiaGeocodedPlacemark)
    
    func didCancelPlacePicker(pickerController: PlacePickerViewExampleVC)
}

class PlacePickerViewExampleVC: UIViewController {
    var mapView:MapmyIndiaMapView!
    public weak var delegate: PlacePickerViewExampleVCDelegate?
    
    var placePickerView: PlacePickerView!
    
    public var isForCustom: Bool = false
    
    
//    override class func demoTitle() -> String? {
//        return "Place Picker"
//    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView = MapmyIndiaMapView()
        // Do any additional setup after loading the view.
        placePickerView = PlacePickerView(frame: self.view.bounds, parentViewController: self, mapView: mapView)
        placePickerView.delegate = self
        self.view.addSubview(placePickerView)
        
        if isForCustom {
            let customView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 200))
            customView.backgroundColor = .red
            
            if UserDefaultsManager.isCustomMarkerView {
                placePickerView.markerView = customView
            }
            if UserDefaultsManager.isMarkerShadowViewHidden {
                placePickerView.isMarkerShadowViewHidden = true
            }
            
            //placePickerView.autocompleteFilter = MapmyIndiaAutocompleteFilter()
            
            if UserDefaultsManager.isCustomSearchButtonBackgroundColor {
                placePickerView.searchButtonBackgroundColor = .yellow
            }
            if UserDefaultsManager.isCustomSearchButtonImage {
                placePickerView.searchButtonImage = UIImage(named: "userSearch")!
            }
            if UserDefaultsManager.isSearchButtonHidden {
                placePickerView.isSearchButtonHidden = true
            }
            
            if UserDefaultsManager.isCustomPlaceNameTextColor {
                placePickerView.placeNameLabelTextColor = .blue
            }
            if UserDefaultsManager.isCustomAddressTextColor {
                placePickerView.addressLabelTextColor = .green
            }
            
            if UserDefaultsManager.isCustomPickerButtonTitleColor {
                placePickerView.pickerButtonTitleColor = .blue
            }
            if UserDefaultsManager.isCustomPickerButtonBackgroundColor {
                placePickerView.pickerButtonBackgroundColor = .yellow
            }
            if UserDefaultsManager.isCustomPickerButtonTitle {
                placePickerView.pickerButtonTitle = "Pick it"
            }
            
            if UserDefaultsManager.isCustomInfoLabelTextColor {
                placePickerView.infoLabelTextColor = .green
            }
            
            if UserDefaultsManager.isCustomInfoBottomViewBackgroundColor {
                placePickerView.infoBottomViewBackgroundColor = .gray
            }
            if UserDefaultsManager.isCustomPlaceDetailsViewBackgroundColor {
                placePickerView.placeDetailsViewBackgroundColor = .lightGray
            }
            if UserDefaultsManager.isInitializeWithCustomLocation {
                placePickerView.isInitializeWithCustomLocation = true
                placePickerView.mapView.setCenter(CLLocationCoordinate2DMake(28.612936, 77.229546), zoomLevel: 15, animated: false)
            }
            
            if UserDefaultsManager.isBottomInfoViewHidden {
                placePickerView.isBottomInfoViewHidden = true
            }
            if UserDefaultsManager.isBottomPlaceDetailViewHidden {
                placePickerView.isBottomPlaceDetailViewHidden = true
            }
        }
    }
}

extension PlacePickerViewExampleVC: PlacePickerViewDelegate {
    func didFailedReverseGeocode(error: NSError?) {
        if let error = error {
            // failed for error
        } else {
            // No results found
        }
    }
    
    func didPickedLocation(placemark: MapmyIndiaGeocodedPlacemark) {
        self.delegate?.didPickedLocation(viewController: self, placemark: placemark)
    }
    
    func didReverseGeocode(placemark: MapmyIndiaGeocodedPlacemark) {
        self.delegate?.didReverseGeocode(viewController: self, placemark: placemark)
    }
        
    func didCancelPlacePicker() {
        self.delegate?.didCancelPlacePicker(pickerController: self)
    }
}
