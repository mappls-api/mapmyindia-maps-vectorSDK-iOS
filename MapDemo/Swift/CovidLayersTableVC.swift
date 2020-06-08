//
//  CovidLayersTableVC.swift
//  MapDemo
//
//  Created by apple on 04/06/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit
import MapmyIndiaMaps

protocol CovidLayersTableVCDelegate: class {
    func layersSelected(selectedInteractiveLayers: [MapmyIndiaInteractiveLayer])
}

class CovidLayersTableVC: UITableViewController {
    
    weak var delegate: CovidLayersTableVCDelegate?
    
    var interactiveLayers = [MapmyIndiaInteractiveLayer]()
    var selectedInteractiveLayers = [MapmyIndiaInteractiveLayer]()

    override func viewDidLoad() {
        super.viewDidLoad()

        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(donePressed(_:)))

        navigationItem.rightBarButtonItem = doneButton

        tableView.allowsMultipleSelection = true

        tableView.reloadData()
    }
    
    @IBAction func donePressed(_ sender: Any) {
        var newSelectedLayers = [MapmyIndiaInteractiveLayer]()

        for indexPath in tableView.indexPathsForSelectedRows ?? [] {
            newSelectedLayers.append(interactiveLayers[indexPath.row])
        }

        delegate?.layersSelected(selectedInteractiveLayers: newSelectedLayers)

        dismiss(animated: true)
    }
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return interactiveLayers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let identifier = "LayerCell"

        var cell = tableView.dequeueReusableCell(withIdentifier: identifier)
        if cell == nil {
            cell = UITableViewCell(style: .default, reuseIdentifier: identifier)
        }

        cell?.selectionStyle = .none

        let layer = interactiveLayers[indexPath.row]

        cell?.textLabel?.text = layer.layerName

        for selectedLayer in selectedInteractiveLayers {
            if selectedLayer.layerId == layer.layerId {
                cell?.accessoryType = .checkmark
                tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
                break
            }
        }
        
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .checkmark
    }
    
    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.cellForRow(at: indexPath)?.accessoryType = .none
    }
}
