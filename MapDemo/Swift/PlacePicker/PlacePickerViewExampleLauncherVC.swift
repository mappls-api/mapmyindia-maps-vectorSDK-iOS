import UIKit
import MapmyIndiaAPIKit

class PlacePickerViewExampleLauncherVC: UIViewController {
    
    var textView: UITextView!
    var placePickerDefaultLauncherButton: UIButton?
    var placePickerCustomLauncherButton: UIButton?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        
        // Create a text view.
        textView = UITextView()
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        addResultTextView()

        // Reset the various views to their initial states.
        resetViews()
        
        placePickerDefaultLauncherButton = createButton(#selector(showPlacePickerExampleButtonTapped), title: "Open Default Place Picker")
        
        placePickerCustomLauncherButton = createButton(#selector(showPlacePickerCustomExampleButtonTapped), title: "Open Custom Place Picker", isForCustom: true)
        
        let settingsBarButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped))
        self.navigationItem.rightBarButtonItems = [settingsBarButton]
    }
        
    @IBAction func showPlacePickerExampleButtonTapped() {
        let placePickerViewExampleVC = PlacePickerViewExampleVC()
        placePickerViewExampleVC.delegate = self
        navigationController?.pushViewController(placePickerViewExampleVC, animated: true)
    }
    
    @IBAction func showPlacePickerCustomExampleButtonTapped() {
        let placePickerViewExampleVC = PlacePickerViewExampleVC()
        placePickerViewExampleVC.isForCustom = true
        placePickerViewExampleVC.delegate = self
        navigationController?.pushViewController(placePickerViewExampleVC, animated: true)
    }
    
    @objc func settingsButtonTapped(sender: UIBarButtonItem) {
        let vc =  MapDemoSettingsVC(nibName: nil, bundle: nil)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func createButton(_ selector: Selector, title: String?, isForCustom: Bool = false) -> UIButton? {
        // Create a button to show the autocomplete widget.
        let button = UIButton(type: .system)
        button.setTitle(title, for: .normal)
        button.addTarget(self, action: selector, for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        // Position the button from the top of the view.
        if isForCustom {
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 100).isActive = true
        } else {
            NSLayoutConstraint(item: button, attribute: .top, relatedBy: .equal, toItem: topLayoutGuide, attribute: .bottom, multiplier: 1, constant: 8).isActive = true
        }
        // Centre it horizontally.
        NSLayoutConstraint(item: button, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1, constant: 0).isActive = true

        return button
    }
    
    func addResultTextView() {
        assert(textView.superview == nil, "\(sel_getName(#function)) should not be called twice")
        view.addSubview(textView)
        
        textView.translatesAutoresizingMaskIntoConstraints = false
        
        textView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
        textView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
        textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
        textView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true
        //textView.heightAnchor.constraint(equalToConstant: 200).isActive = true
    }
    
    func resetViews() {
        textView.text = ""
        textView.isAccessibilityElement = false
        textView.isHidden = false
    }
}

extension PlacePickerViewExampleLauncherVC: PlacePickerViewExampleVCDelegate {
    func didReverseGeocode(viewController: PlacePickerViewExampleVC, placemark: MapmyIndiaGeocodedPlacemark) {
        // did ReverseGeocode
    }
    
    func didPickedLocation(viewController: PlacePickerViewExampleVC, placemark: MapmyIndiaGeocodedPlacemark) {
        navigationController?.popToViewController(self, animated: true)
        self.textView?.isHidden = false
        let values = [placemark.poi, placemark.formattedAddress].compactMap { $0 }
        self.textView.text = values.joined(separator: "\n")
        self.placePickerDefaultLauncherButton?.isHidden = true
        self.placePickerCustomLauncherButton?.isHidden = true
    }
    
    func didCancelPlacePicker(pickerController: PlacePickerViewExampleVC) {
        navigationController?.popToViewController(self, animated: true)
        self.textView?.isHidden = false
        self.textView.text = "Place Picker is canceled"
        self.placePickerDefaultLauncherButton?.isHidden = true
        self.placePickerCustomLauncherButton?.isHidden = true
    }
}
