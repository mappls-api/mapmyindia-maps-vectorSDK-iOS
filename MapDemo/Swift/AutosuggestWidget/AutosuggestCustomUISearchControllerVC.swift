import UIKit
import MapmyIndiaUIWidgets

class AutosuggestCustomUISearchControllerVC: UIViewController {

    weak var delegate: AutosuggestWidgetDelegate?
    var searchController: UISearchController?
    var resultsViewController: MapmyIndiaAutocompleteResultsViewController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        view.backgroundColor = .white
        
        resultsViewController = MapmyIndiaAutocompleteResultsViewController()
        resultsViewController?.autocompleteFilter = getAutocompleteFilter()
        resultsViewController?.delegate = self
        let attributionSetting = MapmyIndiaAttributionsSettings()
        attributionSetting.attributionSize = MapmyIndiaContentSize(rawValue: UserDefaultsManager.attributionSize) ?? .medium
        attributionSetting.attributionHorizontalContentAlignment = MapmyIndiaHorizontalContentAlignment(rawValue: Int(UserDefaultsManager.attributionHorizontalAlignment)) ?? .center
        attributionSetting.attributionVerticalPlacement = MapmyIndiaVerticalPlacement(rawValue: UserDefaultsManager.attributionVerticalPlacement) ?? .before
        resultsViewController?.attributionSettings = attributionSetting
        searchController = UISearchController(searchResultsController: resultsViewController)
        searchController?.hidesNavigationBarDuringPresentation = false
        searchController?.dimsBackgroundDuringPresentation = true

        searchController?.searchBar.autoresizingMask = .flexibleWidth
        searchController?.searchBar.searchBarStyle = .minimal
        searchController?.searchBar.delegate = self
        searchController?.searchBar.accessibilityIdentifier = "searchBarAccessibilityIdentifier"
        searchController?.searchBar.sizeToFit()
        
        navigationItem.titleView = searchController?.searchBar
        definesPresentationContext = true

        // Work around a UISearchController bug that doesn't reposition the table view correctly when
        // rotating to landscape.
        edgesForExtendedLayout = .all
        extendedLayoutIncludesOpaqueBars = true

        searchController?.searchResultsUpdater = resultsViewController
        if UI_USER_INTERFACE_IDIOM() == .pad {
            searchController?.modalPresentationStyle = .popover
        } else {
            searchController?.modalPresentationStyle = .fullScreen
        }
        
        searchController?.isActive = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        DispatchQueue.main.async {
            self.searchController?.searchBar.becomeFirstResponder()
        }
    }
    
    func getAutocompleteFilter() -> MapmyIndiaAutocompleteFilter {
        let autocompleteFilter = MapmyIndiaAutocompleteFilter()
        return autocompleteFilter
    }
}

extension AutosuggestCustomUISearchControllerVC: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchController?.isActive = false
        searchController?.searchBar.isHidden = true
        if self.parent is UINavigationController {
            self.navigationController?.popViewController(animated: true)
        } else {
            self.dismiss(animated: true, completion: nil)
        }
        delegate?.autocompleteDidCancel(viewController: self)
    }
}

extension AutosuggestCustomUISearchControllerVC: MapmyIndiaAutocompleteResultsViewControllerDelegate {
    func didAutocomplete(resultsController: MapmyIndiaAutocompleteResultsViewController, withPlace place: MapmyIndiaAtlasSuggestion) {
        // Display the results and dismiss the search controller.
        searchController?.isActive = false
        searchController?.searchBar.resignFirstResponder()
        searchController?.dismiss(animated: true, completion: {
            self.delegate?.autocompleteDidSelect(viewController: self, place: place)
        })
    }
    
    func didFailAutocomplete(resultsController: MapmyIndiaAutocompleteResultsViewController, withError error: NSError) {
        searchController?.isActive = false
        searchController?.searchBar.resignFirstResponder()
        searchController?.dismiss(animated: true, completion: {
            self.delegate?.autocompleteDidFail(viewController: self, error: error)
        })
    }
    
    func didRequestAutocompletePredictionsForResultsController(resultsController: MapmyIndiaAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func didUpdateAutocompletePredictionsFor(resultsController: MapmyIndiaAutocompleteResultsViewController) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
}


