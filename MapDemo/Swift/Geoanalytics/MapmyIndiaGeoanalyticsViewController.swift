//
//  MapmyIndiaGeoanalyticsViewController.swift
//  MapDemo
//
//  Created by CE00120420 on 13/10/21.
//  Copyright © 2021 MMI. All rights reserved.
//
import UIKit
import MapmyIndiaMaps
import MapmyIndiaGeoanalytics
class MapmyIndiaGeoanalyticsViewController: UIViewController , MapmyIndiaGeoanalyticsPluginDelegate{
    func didGetFeatureInfoResponse(_ featureInfoResponse: GeoanalyticsGetFeatureInfoResponse) {
        print(featureInfoResponse.features)
    }
    
    func view(forGeoanalyticsInfo response: GeoanalyticsGetFeatureInfoResponse) -> UIView? {
        return nil
    }
    
    var mapView: MapmyIndiaMapView!
    var bottomBannerStyleView = UIView()
    var newStylesArray = [MapmyIndiaMapStyle]()
    var layerArray = [MapmyIndiaGeoanalyticsLayerRequest]()
    var listingAPIRequestArray = [GeoanalyticsListingAPIRequest]()
    var styleImage:[UIImage] = [UIImage]()
    var tableView = UITableView()
    var isDown = true
    var switchHolder = UIView()
    var swit = UISwitch()
    var switchLable = UILabel()
    var geoanalyticsPlugin : MapmyIndiaGeoanalyticsPlugin!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        mapView = MapmyIndiaMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(mapView)
        mapView.zoomLevel = 5
        createGeoanalyticsLayerArray()
        let coordinate = CLLocationCoordinate2D(latitude: 28.5354, longitude: 77.2639)
        addAnnotation(at: coordinate)
        
        mapView.setCenter(coordinate, animated: false)
        setupBottomBannerStyleView()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Show Styles", style: .plain, target: self, action: #selector(showStyle))
        let coordinates = [
            CLLocationCoordinate2D(latitude: 28.551438, longitude: 77.265119),
            CLLocationCoordinate2D(latitude: 28.511438, longitude: 77.265119),
            CLLocationCoordinate2D(latitude: 28.521438, longitude: 77.265119),
            CLLocationCoordinate2D(latitude: 28.571438, longitude: 77.265119),
            CLLocationCoordinate2D(latitude: 28.551438, longitude: 77.265119),
            CLLocationCoordinate2D(latitude: 28.598438, longitude: 77.265119),
            CLLocationCoordinate2D(latitude: 28.518438, longitude: 77.265119),
            CLLocationCoordinate2D(latitude: 28.507438, longitude: 77.265119),
            CLLocationCoordinate2D(latitude: 28.547438, longitude: 77.262119),
        ]
        geoanalyticsPlugin = MapmyIndiaGeoanalyticsPlugin(mapView: mapView)
        geoanalyticsPlugin.delegate = self
        geoanalyticsPlugin.shouldShowPopupForGeoanalyticsLayer = true
        addPolyline(coordinates: coordinates)
        setupTableView()
        ShowPopUp()
    }
    
    func ShowPopUp() {
        switchHolder.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4647239264)
        self.view.addSubview(switchHolder)
        
        switchHolder.translatesAutoresizingMaskIntoConstraints = false
        switchHolder.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20).isActive = true
        switchHolder.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        switchHolder.heightAnchor.constraint(equalToConstant: 60).isActive = true
        switchHolder.widthAnchor.constraint(equalToConstant: 220).isActive = true
        
        switchHolder.addSubview(swit)
        swit.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        swit.isOn = true
        swit.setOn(true, animated: false)
        
        swit.backgroundColor = .green
        swit.translatesAutoresizingMaskIntoConstraints = false
        swit.trailingAnchor.constraint(equalTo: switchHolder.trailingAnchor,constant: -10).isActive = true
        swit.centerYAnchor.constraint(equalTo: switchHolder.centerYAnchor).isActive = true
        
        switchLable.text = "Show Info Window"
        switchLable.textColor = .white
        self.view.addSubview(switchLable)
        switchLable.translatesAutoresizingMaskIntoConstraints = false
        switchLable.leadingAnchor.constraint(equalTo: self.switchHolder.leadingAnchor).isActive = true
        switchLable.trailingAnchor.constraint(equalTo: swit.leadingAnchor).isActive = true
        switchLable.centerYAnchor.constraint(equalTo: swit.centerYAnchor).isActive = true
    }
    
    @objc func switchValueDidChange(_ sender: UISwitch!) {
        if (sender.isOn) {
            print("on")
            geoanalyticsPlugin.shouldShowPopupForGeoanalyticsLayer = true
        }
        else {
            print("off")
            geoanalyticsPlugin.shouldShowPopupForGeoanalyticsLayer = false
        }
    }
    
    @objc func showStyle () {
        
        
        if isDown {
            UIView.animate(withDuration: 1) {
                self.bottomBannerStyleView.transform = CGAffineTransform(translationX: 0, y: -450)
            }
            navigationItem.rightBarButtonItem?.title = "Hide Styles Sheet"
            isDown = false
        }  else {
            UIView.animate(withDuration: 1) {
                self.bottomBannerStyleView.transform = CGAffineTransform(translationX: 0, y: 0)
            }
            navigationItem.rightBarButtonItem?.title = "Show Styles Sheet"
            isDown = true
        }
    }
    
    func setupBottomBannerStyleView() {
        self.view.addSubview(bottomBannerStyleView)
        bottomBannerStyleView.translatesAutoresizingMaskIntoConstraints = false
        bottomBannerStyleView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        bottomBannerStyleView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        bottomBannerStyleView.topAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40).isActive = true
        bottomBannerStyleView.heightAnchor.constraint(equalToConstant: 550).isActive = true
        bottomBannerStyleView.backgroundColor = .white
        let panGestureReconizor = UIPanGestureRecognizer(target: self, action: #selector(panGesture(recognizer:)))
        bottomBannerStyleView.addGestureRecognizer(panGestureReconizor)
    }
    
    func createGeoanalyticsLayerArray() {
        
       // MARK:- State
        let requeststate = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["HARYANA","UTTAR PRADESH","ANDHRA PRADESH","KERALA"], attribute: "b_box", api: .state)
        listingAPIRequestArray.append(requeststate);
        
        let apperenceState = GeoanalyticsLayerAppearance()
        apperenceState.fillColor = "42a5f4"
        apperenceState.fillOpacity = "0.5"
        apperenceState.labelColor = "000000"
        apperenceState.labelSize = "10"
        apperenceState.strokeColor = "000000"
        apperenceState.strokeWidth = "0"
        
        let geoboundArray1 = [MapmyIndiaGeoanalyticsGeobound(geobound: "HARYANA", appearance: apperenceState), MapmyIndiaGeoanalyticsGeobound(geobound: "UTTAR PRADESH", appearance: apperenceState),MapmyIndiaGeoanalyticsGeobound(geobound: "KERALA", appearance: apperenceState)]
        
        let layerRequestState = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray1, propertyName: ["stt_nme","stt_id","t_p"], layerType: .state)
        layerRequestState.attribute = "t_p";
        layerRequestState.query = ">0";
        layerRequestState.transparent = true;
//        layerRequestState.styles = "anydesk"
        layerArray.append(layerRequestState)
        
        
        
        
        // MARK:- District
        let requestdistrict = GeoanalyticsListingAPIRequest(geoboundType: "stt_nme", geobound: ["BIHAR","UTTARAKHAND"], attribute: "b_box", api: .district)
        listingAPIRequestArray.append(requestdistrict);
        
        let apperenceDistrict = GeoanalyticsLayerAppearance()
        apperenceDistrict.fillColor = "8bc34a"
        apperenceDistrict.fillOpacity = "0.5"
        apperenceDistrict.labelColor = "000000"
        apperenceDistrict.labelSize = "10"
        apperenceDistrict.strokeColor = "000000"
        apperenceDistrict.strokeWidth = "0"
        
         let geoboundArray2 = [MapmyIndiaGeoanalyticsGeobound(geobound: "BIHAR", appearance: apperenceDistrict), MapmyIndiaGeoanalyticsGeobound(geobound: "UTTARAKHAND",appearance: apperenceDistrict),MapmyIndiaGeoanalyticsGeobound(geobound: "KERALA",appearance: apperenceDistrict)]
        
        let layerRequestDistrict = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray2, propertyName: ["dst_nme","dst_id","t_p"], layerType: .district)
        
        layerRequestDistrict.attribute = "t_p";
        layerRequestDistrict.query = ">0";
        layerRequestDistrict.transparent = true;
        
        layerArray.append(layerRequestDistrict)
        
        
        //  MARK:- SUB_DISTRICT
        let requestsubDistrict = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["HIMACHAL PRADESH","TRIPURA"], attribute: "b_box", api: .subDistrict)
        listingAPIRequestArray.append(requestsubDistrict);

        let apperenceSubDistrict = GeoanalyticsLayerAppearance()
        apperenceSubDistrict.fillColor = "ffa000"
        apperenceSubDistrict.fillOpacity = "0.5"
        apperenceSubDistrict.labelColor = "000000"
        apperenceSubDistrict.labelSize = "10"
        apperenceSubDistrict.strokeColor = "000000"
        apperenceSubDistrict.strokeWidth = "0"
        
        let geoboundArray3 = [MapmyIndiaGeoanalyticsGeobound(geobound: "HIMACHAL PRADESH", appearance: apperenceSubDistrict), MapmyIndiaGeoanalyticsGeobound(geobound: "TRIPURA",appearance:apperenceSubDistrict )]
        
        let layerRequestSubDistrict = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray3, propertyName: ["sdb_nme","sdb_id","t_p"], layerType: .subDistrict)
        
        layerRequestSubDistrict.attribute = "t_p";
        layerRequestSubDistrict.query = ">0";
        layerRequestSubDistrict.transparent = true;
        
        layerArray.append(layerRequestSubDistrict)
        
        //  MARK:- WARD
        let requestward = GeoanalyticsListingAPIRequest.init(geoboundType: "ward_no", geobound: ["0001"], attribute: "b_box", api: .ward)
        listingAPIRequestArray.append(requestward);
        
        let apperenceWard = GeoanalyticsLayerAppearance()
        apperenceWard.fillColor = "ff5722"
        apperenceWard.fillOpacity = "0.5"
        apperenceWard.labelColor = "000000"
        apperenceWard.labelSize = "10"
        apperenceWard.strokeColor = "000000"
        apperenceWard.strokeWidth = "0"
        
        let geoboundArray4 = [MapmyIndiaGeoanalyticsGeobound(geobound: "0001", appearance: apperenceWard)]
        
        let layerRequestWard = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "ward_no", geobound: geoboundArray4,  propertyName: ["ward_no","t_p"], layerType: .ward)
        
        layerRequestWard.attribute = "t_p";
        layerRequestWard.query = ">0";
        layerRequestWard.transparent = true;
        
        layerArray.append(layerRequestWard)
        
        
        //  MARK:- LOCALITY
        let requestlocality = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["DELHI"], attribute: "b_box", api: .locality)
        listingAPIRequestArray.append(requestlocality);
        
        let apperenceLocality = GeoanalyticsLayerAppearance()
        apperenceLocality.fillColor = "00695c"
        apperenceLocality.fillOpacity = "0.5"
        apperenceLocality.labelColor = "000000"
        apperenceLocality.labelSize = "10"
        apperenceLocality.strokeColor = "000000"
        apperenceLocality.strokeWidth = "0"
        
        let geoboundArray5 = [MapmyIndiaGeoanalyticsGeobound(geobound: "DELHI", appearance: apperenceWard)]
        let layerRequestLocality = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray5, propertyName: ["loc_nme","loc_id","t_p"], layerType: .locality)
        
        layerRequestLocality.attribute = "t_p";
        layerRequestLocality.query = ">0";
        layerRequestLocality.transparent = true;
        
        layerArray.append(layerRequestLocality)
        
        
        //        MARK:- PANCHAYAT
        let requestpanchayat = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["ASSAM"], attribute: "b_box", api: .panchayat)
        listingAPIRequestArray.append(requestpanchayat);
        
        let apperencePanchayat = GeoanalyticsLayerAppearance()
        apperencePanchayat.fillColor = "b71c1c"
        apperencePanchayat.fillOpacity = "0.5"
        apperencePanchayat.labelColor = "000000"
        apperencePanchayat.labelSize = "10"
        apperencePanchayat.strokeColor = "000000"
        apperencePanchayat.strokeWidth = "0"
        
        let geoboundArray12 = [MapmyIndiaGeoanalyticsGeobound(geobound: "ASSAM", appearance: apperencePanchayat)]
        
        let layerRequestPanchayat = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray12,  propertyName: ["pnc_nme","pnc_id","t_p"], layerType: .panchayat)
        
        layerRequestPanchayat.attribute = "t_p";
        layerRequestPanchayat.query = ">0";
        layerRequestPanchayat.transparent = true;
        
        layerArray.append(layerRequestPanchayat)
        
        //        MARK:- Block
        let requestblock = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["DELHI"], attribute: "b_box", api: .block)
        listingAPIRequestArray.append(requestblock);
        
        let apperenceBlock = GeoanalyticsLayerAppearance()
        apperenceBlock.fillColor = "3f51b5"
        apperenceBlock.fillOpacity = "0.5"
        apperenceBlock.labelColor = "000000"
        apperenceBlock.labelSize = "10"
        apperenceBlock.strokeColor = "000000"
        apperenceBlock.strokeWidth = "0"
        
        let geoboundArray11 = [MapmyIndiaGeoanalyticsGeobound(geobound: "DELHI", appearance: apperenceWard)]
        let layerRequestBlock = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray11, propertyName: ["blk_nme","blk_id","t_p"], layerType: .block)
        
        layerRequestBlock.attribute = "t_p";
        layerRequestBlock.query = ">0";
        layerRequestBlock.transparent = true;
        
        layerArray.append(layerRequestBlock)
        
        //        MARK:- PINCODE
        let requestpincode = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["KARNATAKA"], attribute: "b_box", api: .pincode)
        listingAPIRequestArray.append(requestpincode);
        
        let apperencePincode = GeoanalyticsLayerAppearance()
        apperencePincode.fillColor = "00bcd4"
        apperencePincode.fillOpacity = "0.5"
        apperencePincode.labelColor = "000000"
        apperencePincode.labelSize = "10"
        apperencePincode.strokeColor = "000000"
        apperencePincode.strokeWidth = "0"
        
        let geoboundArray13 = [MapmyIndiaGeoanalyticsGeobound(geobound: "KARNATAKA", appearance: apperencePincode)]
        let layerRequestPincode = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray13, propertyName: ["pincode"], layerType: .pincode)
        layerRequestPincode.attribute = "t_p";
        layerRequestPincode.query = ">0";
        layerRequestPincode.transparent = true
        layerArray.append(layerRequestPincode)
        
        //        MARK:- town
        let requesttown = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["PUNJAB"], attribute: "b_box", api: .town)
        listingAPIRequestArray.append(requesttown);
        
        let apperenceTown = GeoanalyticsLayerAppearance()
        apperenceTown.fillColor = "9ccc65"
        apperenceTown.fillOpacity = "0.5"
        apperenceTown.labelColor = "000000"
        apperenceTown.labelSize = "10"
        apperenceWard.strokeColor = "000000"
        apperenceWard.strokeWidth = "0"
        
        let geoboundArray6 = [MapmyIndiaGeoanalyticsGeobound(geobound: "PUNJAB", appearance: apperenceWard)]
        
        let layerRequestTown = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray6,  propertyName: ["twn_nme","twn_id","t_p"], layerType: .town)
        
        layerRequestTown.attribute = "t_p";
        layerRequestTown.query = ">0";
        layerRequestTown.transparent = true
        layerArray.append(layerRequestTown)
        
        //        MARK:- city
        let requestcity = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["TAMIL NADU"], attribute: "b_box", api: .city)
        listingAPIRequestArray.append(requestcity);
        
        let apperenceCity = GeoanalyticsLayerAppearance()
        apperenceCity.fillColor = "78909c"
        apperenceCity.fillOpacity = "0.5"
        apperenceCity.labelColor = "000000"
        apperenceCity.labelSize = "10"
        apperenceCity.strokeColor = "000000"
        apperenceCity.strokeWidth = "0"
        
        let geoboundArray7 = [MapmyIndiaGeoanalyticsGeobound(geobound: "TAMIL NADU'", appearance: apperenceCity)]
        
        let layerRequestCity = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray7, propertyName: ["city_nme","city_id","t_p"], layerType: .city)
        
        layerRequestCity.attribute = "t_p";
        layerRequestCity.query = ">0";
        layerRequestCity.transparent = true
        
        layerArray.append(layerRequestCity)
        
        //        MARK:- village
        let requestvillage = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["GOA"], attribute: "b_box", api: .village)
        listingAPIRequestArray.append(requestvillage);
        
        let apperencevillage = GeoanalyticsLayerAppearance()
        apperencevillage.fillColor = "f06292"
        apperencevillage.fillOpacity = "0.5"
        apperencevillage.labelColor = "000000"
        apperencevillage.labelSize = "10"
        apperencevillage.strokeColor = "000000"
        apperencevillage.strokeWidth = "0"
        
        let geoboundArray8 = [MapmyIndiaGeoanalyticsGeobound(geobound: "GOA", appearance: apperencevillage)]
        
        let layerRequestVillage = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray8,  propertyName: ["vil_nme","id","t_p"], layerType: .village)
        
        layerRequestVillage.attribute = "t_p";
        layerRequestVillage.query = ">0";
        layerRequestVillage.transparent = true
        
        layerArray.append(layerRequestVillage)
        
        
        //        MARK:- subLocality
        let requestsubLocality = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["UTTAR PRADESH","BIHAR"], attribute: "b_box", api: .subLocality)
        listingAPIRequestArray.append(requestsubLocality);
        
        let apperenceSubLocality = GeoanalyticsLayerAppearance()
        apperenceSubLocality.fillColor = "f06292"
        apperenceSubLocality.fillOpacity = "0.5"
        apperenceSubLocality.labelColor = "000000"
        apperenceSubLocality.labelSize = "10"
        apperenceSubLocality.strokeColor = "000000"
        apperenceSubLocality.strokeWidth = "0"
        
        let geoboundArray9 = [MapmyIndiaGeoanalyticsGeobound(geobound: "UTTAR PRADESH", appearance: apperenceSubLocality), MapmyIndiaGeoanalyticsGeobound(geobound: "BIHAR",appearance: apperenceSubLocality)]
        
        let layerRequestSubLocality = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray9, propertyName: ["subl_nme","subl_id"], layerType: .subLocality)
        
        layerRequestSubLocality.attribute = "t_p";
        layerRequestSubLocality.query = ">0";
        layerRequestSubLocality.transparent = true
        
        
        layerArray.append(layerRequestSubLocality)
        
        //        MARK:- subSubLocality
        let requestsubSubLocality = GeoanalyticsListingAPIRequest.init(geoboundType: "stt_nme", geobound: ["UTTAR PRADESH","BIHAR"], attribute: "b_box", api: .subSubLocality)
        listingAPIRequestArray.append(requestsubSubLocality);
        
        let apperenceSubSubLocality = GeoanalyticsLayerAppearance()
        apperenceSubSubLocality.fillColor = "f06292"
        apperenceSubSubLocality.fillOpacity = "0.5"
        apperenceSubSubLocality.labelColor = "000000"
        apperenceSubSubLocality.labelSize = "10"
        apperenceSubSubLocality.strokeColor = "000000"
        apperenceSubSubLocality.strokeWidth = "0"
        
        let geoboundArray10 = [MapmyIndiaGeoanalyticsGeobound(geobound: "UTTAR PRADESH", appearance: apperenceSubSubLocality), MapmyIndiaGeoanalyticsGeobound(geobound: "BIHAR",appearance: apperenceSubSubLocality)]
        
        let layerRequestsubSubLocality = MapmyIndiaGeoanalyticsLayerRequest(geoboundType: "stt_nme", geobound: geoboundArray10, propertyName: ["subl_nme","subl_id"], layerType: .subSubLocality)
        
        layerRequestsubSubLocality.attribute = "t_p";
        layerRequestsubSubLocality.query = ">0";
        layerRequestsubSubLocality.transparent = true
        layerArray.append(layerRequestsubSubLocality)
    }
    
    func setupTableView() {
        self.bottomBannerStyleView.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.bottomBannerStyleView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.bottomBannerStyleView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.bottomBannerStyleView.topAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomBannerStyleView.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(GeoanalyticsTableViewCell.self, forCellReuseIdentifier: "cell")
    }

    func getStyleImage(imageUrl: String, completionHandler: @escaping (UIImage?, _ error: String?) -> ()) {
        guard let url = URL(string: "https://apis.mapmyindia.com\(imageUrl)") else {
            return completionHandler(nil, "Image path not valid.")
        }
        let task = URLSession(configuration: .default).dataTask(with: url) { (data, response, error) in
            if let error = error {
                completionHandler(nil, error.localizedDescription)
            } else {
                if let response = response as? HTTPURLResponse,
                    response.statusCode == 200,
                    let data = data,
                    let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        completionHandler(image, nil)
                    }
                } else {
                    completionHandler(nil, "UNKONW ERROR - 101")
                }
            }
        }
        task.resume()
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
    var storeAnnotation: MGLPointAnnotation?
    
    func addPolyline(coordinates: [CLLocationCoordinate2D]) {
        var coordinates = coordinates
        
        let mmiPolyline = MGLPolyline(coordinates: &coordinates, count: UInt(coordinates.count))
        mapView.addAnnotation(mmiPolyline)
    }
    
    func addAnnotation(at coordinate: CLLocationCoordinate2D) {
        
        let marker = MGLPointAnnotation()
        marker.coordinate = coordinate
        storeAnnotation = marker
        mapView.addAnnotation(marker)
    }
    func converToCoordinate(location: String) -> CLLocationCoordinate2D? {
        let locationString = location.split(separator: ",")
        if locationString.count < 2 {
            return nil
        } else if locationString.count == 2 {
            let latitude: Double = Double(locationString.last!) ?? 0.0
            let longitue: Double = Double(locationString.first!) ?? 0.0
            let coordinate = CLLocationCoordinate2D(latitude: CLLocationDegrees(latitude), longitude: CLLocationDegrees(longitue))
            print("coordinate: \(latitude), \(longitue)")
            return coordinate
        } else {
            return nil
        }
    }
    var arrayOfCoordinate = [CLLocationCoordinate2D]()
    @objc func switchChanged(_ sender : UISwitch) {
        arrayOfCoordinate.removeAll()
        let indexPath = IndexPath(row: sender.tag, section: 0)
        let request = layerArray[indexPath.row]
        let listingRequest = listingAPIRequestArray[indexPath.row]
        if sender.isOn {
            let res = MapmyIndiaGeoanalyticsListingManager.shared()
            res.getListingInfo(listingRequest) { (response, error) in
                if (error != nil) {
                    
                } else {
                    if let response = response?.results?.getAttrValues {
                        for i in response {
                            let attrValues : GeoanalyticsAttributedValues = i as! GeoanalyticsAttributedValues
                            if  let innerAttrValue = attrValues.attributedValues {
                                let arrayOfAttrValue = innerAttrValue as NSArray
                                for attr in arrayOfAttrValue {
                                    if let dict = attr as? [String: String] {
                                        let bbox: String = dict["b_box"] ?? ""
                                        let bbox_withoutExtraString = bbox.replacingOccurrences(of: "[BOX()]", with: "",options: .regularExpression)
                                        let bboxCoordinates = bbox_withoutExtraString.split(separator: ",")
                                        for coor in bboxCoordinates {
                                            let aa = "\(coor.replacingOccurrences(of: " ", with: ",",options: .regularExpression))"
                                            if let coordinate = self.converToCoordinate(location: aa) {
                                                self.arrayOfCoordinate.append(coordinate)
                                                print(coordinate)
                                            }
                                        }
                                    }
                                }
                            }
                            
                            
                            
                        }
                    }
                    self.geoanalyticsPlugin.showGeoanalyticsLayer(request)
                    
                    if self.arrayOfCoordinate.count > 0 {
                        self.mapView.setVisibleCoordinateBounds(self.generateCoordinatesBounds(forCoordinates: self.arrayOfCoordinate), animated: false)
                    }
                    
                }
            }
            
        } else if !sender.isOn {
            geoanalyticsPlugin.removeGeoanalyticsLayer(request)
        }
        
    }
    func generateCoordinatesBounds(forCoordinates coordinates: [CLLocationCoordinate2D]) -> MGLCoordinateBounds {

        var maxN = CLLocationDegrees(), maxS = CLLocationDegrees() , maxE = CLLocationDegrees() , maxW = CLLocationDegrees()
        for coordinates in  coordinates {
            if coordinates.latitude >= maxN || maxN == 0 { maxN = coordinates.latitude }
            if coordinates.latitude <= maxS || maxS == 0 { maxS = coordinates.latitude }
            if coordinates.longitude >= maxE || maxE == 0 { maxE = coordinates.longitude }
            if coordinates.longitude <= maxW || maxW == 0{ maxW = coordinates.longitude }
        }

        let offset = 0.001
        let maxNE = CLLocationCoordinate2D(latitude: maxN + offset, longitude: maxE + offset)
        let maxSW =  CLLocationCoordinate2D(latitude: maxS - offset, longitude: maxW - offset)
        return MGLCoordinateBounds(sw: maxSW, ne: maxNE)
    }
}
extension MapmyIndiaGeoanalyticsViewController: MapmyIndiaMapViewDelegate {
    func mapView(_ mapView: MGLMapView, didFinishLoading style: MGLStyle) {
        
    }
}

extension MapmyIndiaGeoanalyticsViewController : UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return layerArray.count - 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! StyleTableViewCell
        //        cell.styleName.text = newStylesArray[indexPath.row].displayName ?? ""
        //        cell.styleDetails.text = newStylesArray[indexPath.row].style_Description ?? ""
        //        cell.styleImage.image = styleImage[indexPath.row]
        
        //            let currentType = placePickerSettings[indexPath.row]
        let cellIdentifier = "switchCell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            if let accessoryView = cell.accessoryView, accessoryView.isKind(of: UISwitch.self) {
                let switchView = accessoryView as! UISwitch
                //                    switchView.isOn = getValueForPlacePickerSetting(currentType)
                switchView.tag = indexPath.row
            }
            return cell
        } else {
            let newCell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
            newCell.textLabel?.text = "\(layerArray[indexPath.row].layerType.rawValue)"
            let switchView = UISwitch(frame: .zero)
            switchView.tag = indexPath.row // for detect which row switch Changed
            switchView.addTarget(self, action: #selector(self.switchChanged(_:)), for: .valueChanged)
            newCell.accessoryView = switchView
            return newCell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        self.mapView.setMapmyIndiaMapsStyle(newStylesArray[indexPath.row].name ?? "")
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
}

