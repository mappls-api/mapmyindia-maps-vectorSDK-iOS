//
//  AutoSuggestVC.swift
//  MapDemoFull_iOS
//
//  Created by apple on 19/11/18.
//  Copyright © 2018 MapmyIndia. All rights reserved.
//

import UIKit
import CoreLocation
import MapmyIndiaAPIKit

protocol AutoSuggestDelegates: class {
    func suggestionSelected(suggestion: MapmyIndiaAtlasSuggestion,placeName:String)
}

class AutoSuggestVC: UIViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    @IBOutlet weak var currentLocationView: UIView!
    @IBOutlet weak var tableViewAutoSuggestResult: UITableView!
    @IBOutlet weak var statusLabel: UILabel!
    
    @IBAction func currentLocationButtonPressed(_ sender: UIButton) {
        //delegate?.currentLocationSelected()
        dismiss(animated: true, completion: nil)
    }
    
    var centerCoordinate: CLLocationCoordinate2D?
    var mapZoomLevel: Double?
    var isCurrentLocationViewVisible = true
    var isTextSearch:Bool = false
    var searchResults = [MapmyIndiaAtlasSuggestion]()
    
    weak var delegate: AutoSuggestDelegates?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Choose City"
        searchController.searchResultsUpdater = self
        if #available(iOS 11.0, *) {
            searchController.obscuresBackgroundDuringPresentation = false
        } else {
            // Fallback on earlier versions
        }
        searchController.searchBar.placeholder = "Search City"
        if #available(iOS 11.0, *) {
            navigationItem.searchController = searchController
        } else {
            // Fallback on earlier versions
            //navigationItem.titleView = searchController.searchBar
            self.tableViewAutoSuggestResult.tableHeaderView = searchController.searchBar
        }
        
        definesPresentationContext = true
        
        searchController.searchBar.delegate = self
        
        
        self.statusLabel.isHidden = true
        self.tableViewAutoSuggestResult.isHidden = true
        self.tableViewAutoSuggestResult.rowHeight = UITableView.automaticDimension
        
        let cancelItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.cancel, target: self, action: #selector(btnCancelHandler))
        navigationItem.leftBarButtonItem = cancelItem
        
        if isCurrentLocationViewVisible {
            currentLocationView.isHidden = false
        } else {
            currentLocationView.isHidden = true
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //        if #available(iOS 11.0, *) {
        //            navigationController?.navigationBar.prefersLargeTitles = true
        //        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        //searchController.isActive = true
        //searchController.searchBar.becomeFirstResponder()
        //        dispatch_async(dispatch_get_main_queue(), {
        //            self.searchController?.active = true
        //            self.searchController!.searchBar.becomeFirstResponder()
        //        })
    }
    
    private func getAutoSuggestResult(searchText: String , isTextSearch:Bool = false) {
        if isTextSearch == true {
            let textSearchManager = MapmyIndiaAtlasTextSearchManager.shared
            let textSearchOptions = MapmyIndiaTextSearchAtlasOptions(query: searchText)
            textSearchOptions.refLocation = CLLocation(latitude: 26.901190, longitude: 75.790539)
            textSearchManager.getTextSearchResult(textSearchOptions) { (suggestions, error) in
                DispatchQueue.main.async {
                    if let error = error {
                        NSLog("%@", error)
                    } else if let suggestions = suggestions, !suggestions.isEmpty {
                        self.searchResults = suggestions
                        print("Text Suggest: \(suggestions[0].latitude ?? 0),\(suggestions[0].longitude ?? 0)")
                        self.statusLabel.isHidden = true
                        self.tableViewAutoSuggestResult.isHidden = false
                        self.tableViewAutoSuggestResult.reloadData()
                    } else {
                        print("No results")
                    }
                }
            }
        }
        else
        {
            if !searchText.isEmpty && searchText.count > 2 {
                let autoSearchOptions = MapmyIndiaAutoSearchAtlasOptions(query: searchText)
                if let coordinates = centerCoordinate {
                    autoSearchOptions.location = CLLocation(latitude: coordinates.latitude, longitude: coordinates.longitude)
                    if let zoom = mapZoomLevel {
                        autoSearchOptions.zoom = NSNumber(value: zoom)
                    }
                }
                MapmyIndiaAutoSuggestManager.shared.getAutoSuggestions(autoSearchOptions) { (suggestions, error) in
                    DispatchQueue.main.async {
                        if let error = error {
                            print("Somthing went wrong: \(error.localizedDescription), \(error.debugDescription)")
                        } else if let results = suggestions, results.count > 0 {
                            self.searchResults = results
                            print("Auto Suggest: \(results[0].latitude ?? 0),\(results[0].longitude ?? 0)")
                            self.statusLabel.isHidden = true
                            self.tableViewAutoSuggestResult.isHidden = false
                            self.tableViewAutoSuggestResult.reloadData()
                        } else {
                            self.statusLabel.text = "No Data Found"
                            self.statusLabel.isHidden = false
                            self.tableViewAutoSuggestResult.isHidden = true
                        }
                    }
                }
            }
        }
    }
    
    
    @objc fileprivate func btnCancelHandler(_ sender: UIBarButtonItem) {
        dismiss(animated: true, completion: nil)
    }
}

extension AutoSuggestVC: UISearchBarDelegate {
    // MARK: - UISearchBar Delegate
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        getAutoSuggestResult(searchText: searchBar.text ?? "")
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
       getAutoSuggestResult(searchText: searchBar.text ?? "" , isTextSearch: true)
    }
}

extension AutoSuggestVC: UISearchResultsUpdating {
    // MARK: - UISearchResultsUpdating Delegate
    func updateSearchResults(for searchController: UISearchController) {
        //let searchBar = searchController.searchBar
        //let scope = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        getAutoSuggestResult(searchText: searchController.searchBar.text ?? "")
    }
}

extension AutoSuggestVC: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = searchResults[indexPath.row]
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "autoSearchCell")
        cell.textLabel?.text = item.placeName
        cell.detailTextLabel?.text = item.placeAddress
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let delegate = self.delegate else {
            return
        }
        
        let item = searchResults[indexPath.row]
        let name = searchResults[indexPath.row].placeName
        searchController.isActive = false
        //dismiss(animated: false, completion: nil)
        dismiss(animated: false) {
            delegate.suggestionSelected(suggestion: item, placeName: name!)
        }
    }
}
