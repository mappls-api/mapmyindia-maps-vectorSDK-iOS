import UIKit
import MapmyIndiaAPIKit
import MapmyIndiaMaps
import MapmyIndiaDirections

class DistanceMatrixViewController: UIViewController {
    var tableView: UITableView!
    var locationsChooserButton: UIButton!
    var indicatorView: UIActivityIndicatorView!
    
    var distanceMatrixResults = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        self.title = "Distance Matrix"
        
        self.setupViews()
        self.setupConstraints()
        self.openLocationChooser()
    }
    
    @objc func openLocationChooser() {
        let locationsChooserVC = LocationsChooserTableViewController()
        locationsChooserVC.mode = .distance
        locationsChooserVC.delegate = self
        self.navigationController?.pushViewController(locationsChooserVC, animated: true)
    }
  
    func setupViews() {
        locationsChooserButton = UIButton()
        locationsChooserButton.backgroundColor = .systemBlue
        locationsChooserButton.contentEdgeInsets = UIEdgeInsets(top: 6, left: 10, bottom: 6, right: 10)
        locationsChooserButton.setTitle("Choose Locations", for: .normal)
        locationsChooserButton.addTarget(self, action: #selector(openLocationChooser), for: .touchUpInside)
        locationsChooserButton.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(locationsChooserButton)
                
        tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        self.view.addSubview(tableView)
        
        indicatorView = UIActivityIndicatorView(style: .gray)
        indicatorView.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        self.view.addSubview(indicatorView)
    }
    
    func setupConstraints() {
        locationsChooserButton.trailingAnchor.constraint(equalTo: self.view.safeTrailingAnchor, constant: -10).isActive = true
        locationsChooserButton.topAnchor.constraint(equalTo: self.view.safeTopAnchor, constant: 10).isActive = true

        tableView.topAnchor.constraint(equalTo: locationsChooserButton.bottomAnchor, constant: 20).isActive = true
        tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        
        indicatorView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        indicatorView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    func callDistanceMatrix(sourceLocations: [String], destinationLocations: [String], resource: MapmyIndiaDistanceMatrixResourceIdentifier, profile: MapmyIndiaDirectionsProfileIdentifier) {
        self.distanceMatrixResults = []
        let allLocations = sourceLocations + destinationLocations
        var sourceIndexes = [Int]()
        var i : Int = 0
        while i < sourceLocations.count {
            sourceIndexes.append(i)
            i = i + 1
        }
        var destinationIndexes = [Int]()
        while i < allLocations.count {
            destinationIndexes.append(i)
            i = i + 1
        }
        
        print("sourceIndex \(sourceIndexes) destinationIndex \(destinationIndexes)")
        
        let distanceMatrixManager = MapmyIndiaDrivingDistanceMatrixManager.shared
        
        let distanceMatrixOptions = MapmyIndiaDrivingDistanceMatrixOptions(locations: allLocations)
        distanceMatrixOptions.sourceIndexes = sourceIndexes
        distanceMatrixOptions.destinationIndexes = destinationIndexes
        distanceMatrixOptions.profileIdentifier = profile
        distanceMatrixOptions.resourceIdentifier = resource
                    
        self.tableView.isHidden = true
        self.indicatorView.isHidden = false
        self.indicatorView.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        distanceMatrixManager.getResult(distanceMatrixOptions) { (result, error) in
            if let error = error {
                NSLog("%@", error)
                let alert = UIAlertController(title: "Error!", message: error.localizedDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            } else if let result = result, let results = result.results {
                for i in 0..<sourceLocations.count {
                    for j in 0..<destinationLocations.count {
                        if let durationNumber = results.durationsAPI?[i][j],
                           let distanceNumber = results.distancesAPI?[i][j] {
                            let duration = durationNumber.intValue
                            let distance = distanceNumber.intValue
                            let result = "S\(i + 1)(\(sourceLocations[i])) To D\(j + 1)(\(destinationLocations[j])):\nDuration - \(duration) seconds\nDistnace - \(distance) meters"
                            self.distanceMatrixResults.append(result)
                        }
                    }
                }
            } else {
                let alert = UIAlertController(title: "Error!", message: "No results", preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
            self.tableView.reloadData()
            self.tableView.isHidden = false
            self.indicatorView.isHidden = true
            self.indicatorView.stopAnimating()
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        }
    }
}

extension DistanceMatrixViewController: LocationsChooserTableViewControllerDelegate {
    func locationsPikcedForDistances(sourceLocations: [String], destinationLocations: [String], resource: MapmyIndiaDistanceMatrixResourceIdentifier, profile: MapmyIndiaDirectionsProfileIdentifier) {
        self.callDistanceMatrix(sourceLocations: sourceLocations, destinationLocations: destinationLocations, resource: resource, profile: profile)
    }
    
    func locationsPikcedForDirections(sourceLocation: String, destinationLocation: String, viaLocations: [String], resource: MBDirectionsResourceIdentifier, profile: MBDirectionsProfileIdentifier) {
        
    }
}

extension DistanceMatrixViewController: UITableViewDataSource, UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return distanceMatrixResults.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LocationCell
        var tableCell: UITableViewCell!
        let cellIdentifier = "cell"
        if let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier) {
            tableCell = cell
        } else {
            tableCell = UITableViewCell(style: .default, reuseIdentifier: cellIdentifier)
        }
        
        tableCell.textLabel?.numberOfLines = 0
        tableCell.textLabel?.text = distanceMatrixResults[indexPath.row]
        return tableCell
    }
}
