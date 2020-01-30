//
//  InstructionTable.swift
//  MapDemo
//
//  Created by Ayush Dayal on 22/01/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit
import MapboxDirections

class InstructionTable: UIViewController ,UITableViewDelegate , UITableViewDataSource{
   
    let directionUtility = MapmyIndiaDirectionsUtility()
    var requiredRoute:Route?
    var routeStepArray = [RouteStep]()
    
    @IBOutlet weak var myTable: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Direction List"
        for routeLegs in requiredRoute!.legs{
                   for routeSteps in routeLegs.steps{
                       self.routeStepArray.append(routeSteps)
                   }
               }
        myTable.reloadData()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if routeStepArray.count > 0{
            return routeStepArray.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? InstructionTableViewCell {
            cell.lbl_Distance?.text = String(format: "Distance: %@ meters", routeStepArray[indexPath.row].distance.description)
            cell.lbl_Instruction?.text = ""
            
            cell.directionIndicationContainerView.subviews.forEach({ $0.removeFromSuperview() })
            let directionIndicationView = DirectionIndicationView()
            directionIndicationView.frame = cell.directionIndicationContainerView.bounds
            directionIndicationView.backgroundColor = .white
            cell.directionIndicationContainerView.backgroundColor = .white
            directionIndicationView.primaryColor = .black
            directionIndicationView.secondaryColor = .lightGray
            cell.directionIndicationContainerView.addSubview(directionIndicationView)
          
            if (indexPath.row == routeStepArray.count - 1) {
                directionIndicationView.isEnd = true
                cell.lbl_Instruction?.text = "Destination Arrived"
            } else {
                if let displayInstruction = routeStepArray[indexPath.row].instructionsDisplayedAlongStep?.first {
                    cell.lbl_Instruction?.text = displayInstruction.primaryInstruction.text
                    directionIndicationView.visualInstruction = displayInstruction.primaryInstruction
                    directionIndicationView.drivingSide = displayInstruction.drivingSide
                }
            }
            return cell
        }
        return UITableViewCell()
    }
    
}
