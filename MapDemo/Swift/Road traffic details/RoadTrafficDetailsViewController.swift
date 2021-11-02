//
//  RoadTrafficDetailsViewController.swift
//  MapDemo
//
//  Created by CE00120420 on 22/10/21.
//  Copyright © 2021 MMI. All rights reserved.
//

import UIKit
import MapmyIndiaAPIKit
import MapmyIndiaMaps
class RoadTrafficDetailsViewController: UIViewController {
    var bottomBannerStyleView = UIView()
    var tableView = UITableView()
    var isDown = true
    var mapView: MapmyIndiaMapView!
    var tableDict  : [[String : Any]] = [[String : Any]]()
    var storeAnnotation: MGLPointAnnotation?
    let progressHUD = ProgressHUD(text: "Loading..")
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        navigationController?.navigationBar.standardAppearance = appearance;
        navigationController?.navigationBar.scrollEdgeAppearance = navigationController?.navigationBar.standardAppearance
        mapView = MapmyIndiaMapView(frame: self.view.bounds)
        let coordiante = CLLocationCoordinate2D(latitude: 28.55106676597232, longitude: 77.26892899885115)
        mapView.setCenter(coordiante, animated: false)
        mapView.zoomLevel = 16
        self.view.addSubview(mapView)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show info", style: .plain, target: self, action: #selector(showStyle))
        let singleTap = UILongPressGestureRecognizer(target: self, action: #selector(didLongPress(tap:)))
        mapView.gestureRecognizers?.filter({ $0 is UILongPressGestureRecognizer }).forEach(singleTap.require(toFail:))
        mapView.addGestureRecognizer(singleTap)
        
        setupBottomBannerStyleView()
        setupTableView()
        setupInfoWindow()
        self.view.addSubview(progressHUD)
        progressHUD.hide()
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        mapView.setMapCenterAtEloc("mmi000", animated: true, completionHandler: nil)
//        mapView.zoomLevel = 16
    }
    func removeAllAnnotation() {
        guard let annotations = storeAnnotation else { return
            print("Annotations Error") }
        mapView.removeAnnotation(annotations)
    }
    func addAnnotation(at coordinate: CLLocationCoordinate2D) {

        let marker = MGLPointAnnotation()
        marker.coordinate = coordinate
        self.storeAnnotation = marker
        self.mapView.addAnnotation(marker)
    }
   
    
    @objc func showStyle () {
        if isDown {
            UIView.animate(withDuration: 1) {
                self.bottomBannerStyleView.transform = CGAffineTransform(translationX: 0, y: -450)
            }
            navigationItem.rightBarButtonItem?.title = "Hide info"
            isDown = false
        }  else {
            UIView.animate(withDuration: 1) {
                self.bottomBannerStyleView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            navigationItem.rightBarButtonItem?.title = "Show info"
            isDown = true
        }
    }
    
    @objc func didLongPress(tap: UILongPressGestureRecognizer) {
        guard let mapView = mapView, tap.state == .began else { return }
        let coordinates = mapView.convert(tap.location(in: mapView), toCoordinateFrom: mapView)
        getRoadTrafficDetailsAPI(lat: coordinates.latitude, long: coordinates.longitude)
        removeAllAnnotation()
        addAnnotation(at: coordinates)
        progressHUD.show()
    }
    
    var infoView = UIView()
    var infoLabel = UILabel()
    func setupInfoWindow() {
        self.view.addSubview(infoView)
        infoView.backgroundColor = .systemYellow
        
        infoView.translatesAutoresizingMaskIntoConstraints = false
        infoView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        infoView.topAnchor.constraint(equalTo: self.view.safeTopAnchor).isActive = true
        infoView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        infoView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        infoLabel = UILabel()
        self.infoView.addSubview(infoLabel)
        self.infoLabel.numberOfLines = 0
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        infoLabel.font = .systemFont(ofSize: 12)
        infoLabel.text = "Long press on road to get the information about road."
        infoLabel.leadingAnchor.constraint(equalTo: self.infoView.leadingAnchor, constant: 5).isActive = true
        infoLabel.trailingAnchor.constraint(equalTo: self.infoView.trailingAnchor).isActive = true
        infoLabel.topAnchor.constraint(equalTo: infoView.topAnchor,constant: 5).isActive = true
        infoLabel.bottomAnchor.constraint(equalTo: infoView.bottomAnchor,constant: 0).isActive = true
        infoLabel.textColor = .white
    }
    func setupBottomBannerStyleView() {
        self.view.addSubview(bottomBannerStyleView)
        bottomBannerStyleView.translatesAutoresizingMaskIntoConstraints = false
        bottomBannerStyleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomBannerStyleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomBannerStyleView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -20).isActive = true
        bottomBannerStyleView.heightAnchor.constraint(equalToConstant: 550).isActive = true
        bottomBannerStyleView.backgroundColor = .white
        let panGestureReconizor = UIPanGestureRecognizer(target: self, action: #selector(panGesture(recognizer:)))
        bottomBannerStyleView.addGestureRecognizer(panGestureReconizor)
        
    }
    
    func setupTableView() {
        self.bottomBannerStyleView.addSubview(tableView)
        bottomBannerStyleView.backgroundColor = .white
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.bottomBannerStyleView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.bottomBannerStyleView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.bottomBannerStyleView.topAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomBannerStyleView.bottomAnchor, constant: -100).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MapmyIndiaMapStyleTableViewCell.self, forCellReuseIdentifier: "cell")
        
    }
    
    @objc func panGesture(recognizer: UIPanGestureRecognizer) {

        if recognizer.state == .began {
            if isDown {
                UIView.animate(withDuration: 1) {
                    self.bottomBannerStyleView.transform = CGAffineTransform(translationX: 0, y: -450)
                }
                 navigationItem.rightBarButtonItem?.title = "Hide Styles Sheet"
                isDown = false
            } else {
                UIView.animate(withDuration: 1) {
                    self.bottomBannerStyleView.transform = CGAffineTransform(translationX: 0, y: 0)
                }
                 navigationItem.rightBarButtonItem?.title = "Show Styles Sheet"
                isDown = true
            }
        }
    }
    
    func getRoadTrafficDetailsAPI(lat: Double, long: Double){
        tableDict.removeAll()
        let options = MapmyIndiaRoadTrafficDetailsOptions(latitude: lat, longitude: long)
        let manager = MapmyIndiaRoadTrafficDetailsManager.shared
        manager.getTrafficRoadDetailsResults(options) { resposnse, error in
            if let error = error {
                self.isDown = false
                self.showStyle()
                print("Road traffic error: \(error.localizedDescription)")
                let alertController = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
                alertController.addAction(UIAlertAction(title: "Cancel", style: .default, handler: { (alertAction) in
                    self.dismiss(animated: false, completion: nil)
                }))
                self.present(alertController, animated: false, completion: nil)
                self.progressHUD.hide()
            } else {
                if let response  = resposnse {
                    let res: MapmyIndiaRoadTrafficDetailsResponse = response
                    if let result : MapmyIndiaRoadTrafficDetailsResult = res.result {
                        do {
                            let encoder = JSONEncoder()
                            let data = try encoder.encode(result)
                            let json = try JSONSerialization.jsonObject(with: data, options: [])
                            guard let dictionary = json as? [String : Any] else {
                                return
                            }
                            let _ = dictionary.keys.map({ key in
                                if let value = dictionary[key] {
                                    self.tableDict.append(["\(key)":"\(value)"])
                                }
                            })
                            self.isDown = true
                            self.showStyle()
                            self.progressHUD.hide()
                            self.tableView.reloadData()
                            
                        } catch {
                            print(error.localizedDescription)
                        }
                    }
                }
            }
        }
    }
}

extension RoadTrafficDetailsViewController : UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableDict.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellIdentifier = "Cell"
        var tableCell: UITableViewCell!
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier){
            tableCell = cell
        }else {
            tableCell = UITableViewCell(style: .value1, reuseIdentifier: cellIdentifier)
        }
        if let key = tableDict[indexPath.row].keys.first , let value =  tableDict[indexPath.row].values.first{
            tableCell.textLabel?.text = "\(key)"
            tableCell.detailTextLabel?.text = "\(value)"
        }
        return tableCell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}
