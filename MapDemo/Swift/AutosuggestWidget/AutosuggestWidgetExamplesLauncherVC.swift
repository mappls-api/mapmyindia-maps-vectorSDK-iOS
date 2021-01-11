import UIKit
import MapmyIndiaUIWidgets

protocol AutosuggestWidgetDelegate: class {
    
    func autocompleteDidSelect(viewController: UIViewController, place: MapmyIndiaAtlasSuggestion)
    
    func autocompleteDidFail(viewController: UIViewController, error: NSError)
    
    func autocompleteDidCancel(viewController: UIViewController)
}

class AutosuggestWidgetExamplesLauncherVC: UIViewController {

    var tableView: UITableView!
    let autosuggestWidgetSampleTypes = AutosuggestWidgetSampleType.allCases
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds)
        tableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        tableView.dataSource = self
        tableView.delegate = self
        view.addSubview(tableView)
        let settingsBarButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(settingsButtonTapped))
        self.navigationItem.rightBarButtonItems = [settingsBarButton]
    }
    
    @objc func settingsButtonTapped(sender: UIBarButtonItem) {
        let vc =  MapDemoSettingsVC(nibName: nil, bundle: nil)
        vc.demoSettings = [.autocomplete]
        navigationController?.pushViewController(vc, animated: true)
    }
}

extension AutosuggestWidgetExamplesLauncherVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return autosuggestWidgetSampleTypes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let currentType = autosuggestWidgetSampleTypes[indexPath.row]
        let cellIdentifier = "switchCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            cell.textLabel?.text = AutosuggestWidgetSampleTypeConverter.titleFor(sampleType: currentType)
            return cell
        } else {
            let newCell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            newCell.textLabel?.text = AutosuggestWidgetSampleTypeConverter.titleFor(sampleType: currentType)
            return newCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentType = autosuggestWidgetSampleTypes[indexPath.row]
        switch currentType {
        case .defaultController:
            presentAlertConrollerForDefaultController()
        case .customTheme:
            presentAlertConrollerForCustomThemeController()
        case .customUISearchController:
            let autosuggestCustomUISearchControllerVC = AutosuggestCustomUISearchControllerVC(nibName: nil, bundle: nil)
            autosuggestCustomUISearchControllerVC.delegate = self
            navigationController?.pushViewController(autosuggestCustomUISearchControllerVC, animated: true)
            break
        case .textFieldSearch:
            let autosuggestWidgetTextFieldSearchVC = AutosuggestWidgetTextFieldSearchVC(nibName: nil, bundle: nil)
            autosuggestWidgetTextFieldSearchVC.delegate = self
            navigationController?.pushViewController(autosuggestWidgetTextFieldSearchVC, animated: true)
            break
        default:
            break
        }
    }
    
    func presentAlertConrollerForDefaultController() {
        let alertController = UIAlertController(title: "Choose Launch Type?", message: "Select type of launch of Controller", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Push", style: .default, handler: { (alertAction) in
            self.pushDefaultConroller()
        }))
        alertController.addAction(UIAlertAction(title: "Present", style: .default, handler: { (alertAction) in
            self.presentDefaultConroller()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        print(self.presentedViewController?.parent)
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func pushDefaultConroller() {
        navigationController?.pushViewController(getAutocompleteViewControllerInstance(), animated: true)
    }
    
    @objc func presentDefaultConroller() {
        print(self.presentedViewController)
        present(getAutocompleteViewControllerInstance(), animated: true, completion: nil)
    }
    
    func getAutocompleteViewControllerInstance() -> MapmyIndiaAutocompleteViewController {
        let autocompleteViewController = MapmyIndiaAutocompleteViewController()
        let attributionSetting = MapmyIndiaAttributionsSettings()
        attributionSetting.attributionSize = MapmyIndiaContentSize(rawValue: UserDefaultsManager.attributionSize) ?? .medium
        attributionSetting.attributionHorizontalContentAlignment = MapmyIndiaHorizontalContentAlignment(rawValue: Int(UserDefaultsManager.attributionHorizontalAlignment)) ?? .center
        attributionSetting.attributionVerticalPlacement = MapmyIndiaVerticalPlacement(rawValue: UserDefaultsManager.attributionVerticalPlacement) ?? .before
        autocompleteViewController.delegate = self
        autocompleteViewController.attributionSettings = attributionSetting
        autocompleteViewController.autocompleteFilter = getAutocompleteFilter()
        return autocompleteViewController
    }
    
    func presentAlertConrollerForCustomThemeController() {
        let alertController = UIAlertController(title: "Choose Theme?", message: "Select a theme for Controller", preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Yellow And Brown", style: .default, handler: { (alertAction) in
            self.openBrownTheme()
        }))
        alertController.addAction(UIAlertAction(title: "White On Black", style: .default, handler: { (alertAction) in
            self.openBlackTheme()
        }))
        alertController.addAction(UIAlertAction(title: "Blue Colors", style: .default, handler: { (alertAction) in
            self.openBlueTheme()
        }))
        alertController.addAction(UIAlertAction(title: "Hot Dog Stand", style: .default, handler: { (alertAction) in
            self.openHotDogTheme()
        }))
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        present(alertController, animated: true, completion: nil)
    }
    
    @objc func openBrownTheme() {
        let backgroundColor = UIColor(red: 215.0 / 255.0, green: 204.0 / 255.0, blue: 200.0 / 255.0, alpha: 1.0)
        let selectedTableCellBackgroundColor = UIColor(red: 236.0 / 255.0, green: 225.0 / 255.0, blue: 220.0 / 255.0, alpha: 1.0)
        let darkBackgroundColor = UIColor(red: 93.0 / 255.0, green: 64.0 / 255.0, blue: 55.0 / 255.0, alpha: 1.0)
        let primaryTextColor = UIColor(white: 0.33, alpha: 1.0)
        
        let highlightColor = UIColor(red: 255.0 / 255.0, green: 235.0 / 255.0, blue: 0.0 / 255.0, alpha: 1.0)
        let secondaryColor = UIColor(white: 114.0 / 255.0, alpha: 1.0)
        let tintColor = UIColor(red: 219 / 255.0, green: 207 / 255.0, blue: 28 / 255.0, alpha: 1.0)
        let searchBarTintColor = UIColor.yellow
        let separatorColor = UIColor(white: 182.0 / 255.0, alpha: 1.0)
        
        presentAutocompleteController(withBackgroundColor: backgroundColor, selectedTableCellBackgroundColor: selectedTableCellBackgroundColor, darkBackgroundColor: darkBackgroundColor, primaryTextColor: primaryTextColor, highlightColor: highlightColor, secondaryColor: secondaryColor, tintColor: tintColor, searchBarTintColor: searchBarTintColor, separatorColor: separatorColor)
    }
    
    @objc func openBlackTheme() {
        let backgroundColor = UIColor(white: 0.25, alpha: 1.0)
        let selectedTableCellBackgroundColor = UIColor(white: 0.35, alpha: 1.0)
        let darkBackgroundColor = UIColor(white: 0.2, alpha: 1.0)
        let primaryTextColor = UIColor.white
        let highlightColor = UIColor(red: 0.75, green: 1.0, blue: 0.75, alpha: 1.0)
        let secondaryColor = UIColor(white: 1.0, alpha: 0.5)
        let tintColor = UIColor.white
        let searchBarTintColor = tintColor
        let separatorColor = UIColor(red: 0.5, green: 0.75, blue: 0.5, alpha: 0.30)
        
        presentAutocompleteController(withBackgroundColor: backgroundColor, selectedTableCellBackgroundColor: selectedTableCellBackgroundColor, darkBackgroundColor: darkBackgroundColor, primaryTextColor: primaryTextColor, highlightColor: highlightColor, secondaryColor: secondaryColor, tintColor: tintColor, searchBarTintColor: searchBarTintColor, separatorColor: separatorColor)
    }
    
    @objc func openBlueTheme() {
        let backgroundColor = UIColor(red: 225.0 / 255.0, green: 241.0 / 255.0, blue: 252.0 / 255.0, alpha: 1.0)
        let selectedTableCellBackgroundColor = UIColor(red: 213.0 / 255.0, green: 219.0 / 255.0, blue: 230.0 / 255.0, alpha: 1.0)
        let darkBackgroundColor = UIColor(red: 187.0 / 255.0, green: 222.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
        let primaryTextColor = UIColor(white: 0.5, alpha: 1.0)
        let highlightColor = UIColor(red: 76.0 / 255.0, green: 175.0 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
        let secondaryColor = UIColor(white: 0.5, alpha: 0.65)
        let tintColor = UIColor(red: 0 / 255.0, green: 142 / 255.0, blue: 248.0 / 255.0, alpha: 1.0)
        let searchBarTintColor = tintColor
        let separatorColor = UIColor(white: 0.5, alpha: 0.65)
        
        presentAutocompleteController(withBackgroundColor: backgroundColor, selectedTableCellBackgroundColor: selectedTableCellBackgroundColor, darkBackgroundColor: darkBackgroundColor, primaryTextColor: primaryTextColor, highlightColor: highlightColor, secondaryColor: secondaryColor, tintColor: tintColor, searchBarTintColor: searchBarTintColor, separatorColor: separatorColor)
    }
    
    @objc func openHotDogTheme() {
        let backgroundColor = UIColor.yellow
        let selectedTableCellBackgroundColor = UIColor.white
        let darkBackgroundColor = UIColor.red
        let primaryTextColor = UIColor.black
        let highlightColor = UIColor.red
        let secondaryColor = UIColor(white: 0.0, alpha: 0.6)
        let tintColor = UIColor.red
        let searchBarTintColor = UIColor.white
        let separatorColor = UIColor.red

        presentAutocompleteController(withBackgroundColor: backgroundColor, selectedTableCellBackgroundColor: selectedTableCellBackgroundColor, darkBackgroundColor: darkBackgroundColor, primaryTextColor: primaryTextColor, highlightColor: highlightColor, secondaryColor: secondaryColor, tintColor: tintColor, searchBarTintColor: searchBarTintColor, separatorColor: separatorColor)
    }
    
    func presentAutocompleteController(withBackgroundColor backgroundColor: UIColor, selectedTableCellBackgroundColor: UIColor, darkBackgroundColor: UIColor, primaryTextColor: UIColor, highlightColor: UIColor, secondaryColor: UIColor, tintColor: UIColor, searchBarTintColor: UIColor, separatorColor: UIColor) {
        // Use UIAppearance proxies to change the appearance of UI controls in
        // MapmyIndiaAutocompleteViewController. Here we use appearanceWhenContainedInInstancesOfClasses to
        // localise changes to just this part of the Demo app. This will generally not be necessary in a
        // real application as you will probably want the same theme to apply to all elements in your app.
        let appearance = UIActivityIndicatorView.appearance(whenContainedInInstancesOf: [MapmyIndiaStyledAutocompleteViewController.self])
        appearance.color = primaryTextColor

        UINavigationBar.appearance(whenContainedInInstancesOf: [MapmyIndiaStyledAutocompleteViewController.self]).barTintColor = darkBackgroundColor
        UINavigationBar.appearance(whenContainedInInstancesOf: [MapmyIndiaStyledAutocompleteViewController.self]).tintColor = searchBarTintColor
        
        // Color of typed text in search bar.
        let searchBarTextAttributes = [
            NSAttributedString.Key.foregroundColor: searchBarTintColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)
        ]
        UITextField.appearance(whenContainedInInstancesOf: [MapmyIndiaStyledAutocompleteViewController.self]).defaultTextAttributes = searchBarTextAttributes

        // Color of the "Search" placeholder text in search bar. For this example, we'll make it the same
        // as the bar tint color but with added transparency.
        let increasedAlpha = searchBarTintColor.cgColor.alpha * 0.75
        let placeHolderColor = searchBarTintColor.withAlphaComponent(increasedAlpha)
        
        let placeholderAttributes = [
            NSAttributedString.Key.foregroundColor: placeHolderColor,
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: UIFont.systemFontSize)
        ]
        let attributedPlaceholder = NSAttributedString(string: "Search", attributes: placeholderAttributes)

        UITextField.appearance(whenContainedInInstancesOf: [MapmyIndiaStyledAutocompleteViewController.self]).attributedPlaceholder = attributedPlaceholder

        // Change the background color of selected table cells.
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = selectedTableCellBackgroundColor
        let tableCellAppearance = UITableViewCell.appearance(whenContainedInInstancesOf: [MapmyIndiaStyledAutocompleteViewController.self])
        tableCellAppearance.selectedBackgroundView = selectedBackgroundView
        
        // Depending on the navigation bar background color, it might also be necessary to customise the
        // icons displayed in the search bar to something other than the default. The
        // setupSearchBarCustomIcons method contains example code to do this.

        let acController = MapmyIndiaStyledAutocompleteViewController()
        acController.delegate = self
        acController.autocompleteFilter = getAutocompleteFilter()
        acController.tableCellBackgroundColor = backgroundColor
        acController.tableCellSeparatorColor = separatorColor
        acController.primaryTextColor = primaryTextColor
        acController.primaryTextHighlightColor = highlightColor
        acController.secondaryTextColor = secondaryColor
        acController.tintColor = tintColor

        let attributionSetting = MapmyIndiaAttributionsSettings()
        attributionSetting.attributionSize = MapmyIndiaContentSize(rawValue: UserDefaultsManager.attributionSize) ?? .medium
        attributionSetting.attributionHorizontalContentAlignment = MapmyIndiaHorizontalContentAlignment(rawValue: Int(UserDefaultsManager.attributionHorizontalAlignment)) ?? .center
        attributionSetting.attributionVerticalPlacement = MapmyIndiaVerticalPlacement(rawValue: UserDefaultsManager.attributionVerticalPlacement) ?? .before
        acController.attributionSettings = attributionSetting
        present(acController, animated: true)
    }
    
    func getAutocompleteFilter() -> MapmyIndiaAutocompleteFilter {
        let autocompleteFilter = MapmyIndiaAutocompleteFilter()
        return autocompleteFilter
    }
    
    func showPlaceDetail(place: MapmyIndiaAtlasSuggestion) {
        if let placeLatitude = place.latitude, let placeLongitude = place.longitude {
            let alertController = UIAlertController(title: "Location Chosen!", message: "\([place.placeName ?? "", place.placeAddress ?? "", "\(placeLatitude), \(placeLongitude)"].joined(separator: "\n"))", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func showErrorAlert(error: NSError) {
        let alertController = UIAlertController(title: "Failed!", message: "Error: \(error.localizedDescription)", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension AutosuggestWidgetExamplesLauncherVC: MapmyIndiaAutocompleteViewControllerDelegate {
    func didAutocomplete(viewController: MapmyIndiaAutocompleteViewController, withPlace place: MapmyIndiaAtlasSuggestion) {
        if viewController.parent is UINavigationController {
            viewController.navigationController?.popViewController(animated: true)
            self.showPlaceDetail(place: place)
        } else {
            viewController.dismiss(animated: true, completion: {
               self.showPlaceDetail(place: place)
            })
        }
    }
    
    func didFailAutocomplete(viewController: MapmyIndiaAutocompleteViewController, withError error: NSError) {
        if viewController.parent is UINavigationController {
            viewController.navigationController?.popViewController(animated: true)
            self.showErrorAlert(error: error)
        } else {
            viewController.dismiss(animated: true, completion: {
               self.showErrorAlert(error: error)
            })
        }
    }
        
    func wasCancelled(viewController: MapmyIndiaAutocompleteViewController) {
        
    }
}

extension AutosuggestWidgetExamplesLauncherVC: AutosuggestWidgetDelegate {
    func autocompleteDidCancel(viewController: UIViewController) {
        
    }
    
    func autocompleteDidSelect(viewController: UIViewController, place: MapmyIndiaAtlasSuggestion) {
        if viewController.parent is UINavigationController {
            viewController.navigationController?.popViewController(animated: true)
            self.showPlaceDetail(place: place)
        } else {
            viewController.dismiss(animated: true, completion: {
               self.showPlaceDetail(place: place)
            })
        }
    }

    func autocompleteDidFail(viewController: UIViewController, error: NSError) {
        if viewController.parent is UINavigationController {
            viewController.navigationController?.popViewController(animated: true)
            self.showErrorAlert(error: error)
        } else {
            viewController.dismiss(animated: true, completion: {
               self.showErrorAlert(error: error)
            })
        }
    }
}
