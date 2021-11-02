import UIKit
import MapmyIndiaMaps

class MapmyIndiaMapStyleViewController: UIViewController {
    var mapView: MapmyIndiaMapView!
    var bottomBannerStyleView = UIView()
    var newStylesArray = [MapmyIndiaMapStyle]()
    var styleImage:[UIImage] = [UIImage]()
    var tableView = UITableView()
    var isDown = true
    var switchHolder = UIView()
    var swit = UISwitch()
    var switchLable = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()

        mapView = MapmyIndiaMapView(frame: self.view.bounds)
        mapView.delegate = self
        mapView.layer.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.view.addSubview(mapView)
        mapView.zoomLevel = 5
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
        addPolyline(coordinates: coordinates)
        setupTableView()
        setupSWitchLayout()
    }

    func setupSWitchLayout() {
        switchHolder.backgroundColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4647239264)
        self.view.addSubview(switchHolder)

        switchHolder.translatesAutoresizingMaskIntoConstraints = false
        switchHolder.leadingAnchor.constraint(equalTo: self.view.leadingAnchor,constant: 20).isActive = true
        switchHolder.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 30).isActive = true
        switchHolder.heightAnchor.constraint(equalToConstant: 60).isActive = true
        switchHolder.widthAnchor.constraint(equalToConstant: 170).isActive = true

        switchHolder.addSubview(swit)
        swit.addTarget(self, action: #selector(switchValueDidChange(_:)), for: .valueChanged)
        swit.isOn = true
        swit.setOn(true, animated: false)

        swit.backgroundColor = .green
        swit.translatesAutoresizingMaskIntoConstraints = false
        swit.trailingAnchor.constraint(equalTo: switchHolder.trailingAnchor,constant: -10).isActive = true
        swit.centerYAnchor.constraint(equalTo: switchHolder.centerYAnchor).isActive = true

        switchLable.text = "Save last style"
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
            MapmyIndiaMapConfiguration.setIsShowPreferedMapStyle(true)
        }
        else {
            print("off")
            MapmyIndiaMapConfiguration.setIsShowPreferedMapStyle(false)
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

    func setupTableView() {
        self.bottomBannerStyleView.addSubview(tableView)
        tableView.backgroundColor = .white
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.leadingAnchor.constraint(equalTo: self.bottomBannerStyleView.leadingAnchor).isActive = true
        tableView.trailingAnchor.constraint(equalTo: self.bottomBannerStyleView.trailingAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: self.bottomBannerStyleView.topAnchor, constant: 10).isActive = true
        tableView.bottomAnchor.constraint(equalTo: self.bottomBannerStyleView.bottomAnchor).isActive = true
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MapmyIndiaMapStyleTableViewCell.self, forCellReuseIdentifier: "cell")

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
}
extension MapmyIndiaMapStyleViewController : UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newStylesArray.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MapmyIndiaMapStyleTableViewCell
        cell.styleName.text = newStylesArray[indexPath.row].displayName ?? ""
        cell.styleDetails.text = newStylesArray[indexPath.row].style_Description ?? ""
        cell.styleImage.image = styleImage[indexPath.row]
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.mapView.setMapmyIndiaMapsStyle(newStylesArray[indexPath.row].name ?? "")
          print(mapView.styleURL)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 180
    }
}
extension MapmyIndiaMapStyleViewController : MapmyIndiaMapViewDelegate {

    func didSetMapmyIndiaMapsStyle(_ mapView: MapmyIndiaMapView, isSuccess: Bool, withError error: Error?) {
        print(isSuccess)
    }


    func didLoadedMapmyIndiaMapsStyles(_ mapView: MapmyIndiaMapView, styles: [MapmyIndiaMapStyle], withError error: Error?) {
        newStylesArray.removeAll()
        for i in styles {
            getStyleImage(imageUrl: i.imageUrl!) { (image, errorMessage) in
                self.styleImage.append(image ?? UIImage())
                self.newStylesArray.append(i)
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                
            }
        }
    }

    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
    }
     func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
         return true
     }

    func mapView(_ mapView: MGLMapView, lineWidthForPolylineAnnotation annotation: MGLPolyline) -> CGFloat {
           return 1
       }

       func mapView(_ mapView: MGLMapView, strokeColorForShapeAnnotation annotation: MGLShape) -> UIColor {
           return .black
       }

       func mapView(_ mapView: MGLMapView, alphaForShapeAnnotation annotation: MGLShape) -> CGFloat {
           return 1
       }

}
