//
//  InstructionTable.swift
//  MapDemo
//
//  Created by Ayush Dayal on 22/01/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit
import MapmyIndiaDirections

class InstructionTableVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    let instructionFormatter = TextInstructions(version: "v5")
    
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
            let step = routeStepArray[indexPath.row]
            
            let instructionStep = instructionFormatter.string(for: step)!
            let visualInstructionComponent = VisualInstructionComponent.init(type: .text, text: instructionStep, imageURL: nil, abbreviation: nil, abbreviationPriority: NSNotFound)
            var primaryInstruction = VisualInstruction.init(text: instructionStep, maneuverType: step.maneuverType, maneuverDirection: step.maneuverDirection, components: [visualInstructionComponent])
            
            if indexPath.row < routeStepArray.count - 1 {
                let nextStep = routeStepArray[indexPath.row + 1]
                let angle = getRoundAngle(step: step, nextStep: nextStep)
                
                if let angle = angle {
                    primaryInstruction = VisualInstruction(text: instructionStep, maneuverType: step.maneuverType, maneuverDirection: step.maneuverDirection, components: [visualInstructionComponent], degrees: angle)
                }
            }
            
            
            cell.lbl_Distance?.text = String(format: "Distance: %@ meters", step.distance.description)
            cell.lbl_Instruction?.text = ""
            
            cell.directionIndicationContainerView.subviews.forEach({ $0.removeFromSuperview() })
            let directionIndicationView = DirectionIndicationView()
            directionIndicationView.frame = cell.directionIndicationContainerView.bounds
            directionIndicationView.backgroundColor = .white
            cell.directionIndicationContainerView.backgroundColor = .white
            directionIndicationView.primaryColor = .black
            directionIndicationView.secondaryColor = .lightGray
            cell.directionIndicationContainerView.addSubview(directionIndicationView)
          
//            if (indexPath.row == routeStepArray.count - 1) {
//                directionIndicationView.isEnd = true
//                cell.lbl_Instruction?.text = "Destination Arrived"
//            } else {
//                cell.lbl_Instruction?.text = primaryInstruction.text
//                directionIndicationView.visualInstruction = primaryInstruction
//                directionIndicationView.drivingSide = step.drivingSide
//            }
            cell.lbl_Instruction?.text = primaryInstruction.text
            directionIndicationView.visualInstruction = primaryInstruction
            directionIndicationView.drivingSide = step.drivingSide
            return cell
        }
        return UITableViewCell()
    }
    
    func getRoundAngle(step: RouteStep, nextStep: RouteStep) -> CLLocationDegrees? {
        var angle: CLLocationDegrees?
        if step.maneuverType == .takeRoundabout || step.maneuverType == .turnAtRoundabout ||
            step.maneuverType == .takeRotary {
            if var initialHeading: CLLocationDirection = step.initialHeading,
                let finalHeading: CLLocationDirection = nextStep.finalHeading {
                if initialHeading < 180.0 {
                    initialHeading += 180
                } else {
                    initialHeading -= 180
                }
                
                var newAngle = finalHeading - initialHeading
                if newAngle < 0.0 {
                    newAngle += 360
                }
                
                angle = newAngle
            }
        }
        if let angle = angle {
            if (angle <= 45) {
                return 45
            } else if (angle <= 90) {
                return 90
            } else if (angle <= 135) {
                return 135
            } else if (angle <= 180) {
                return 180
            } else if (angle <= 225) {
                return 225
            } else if (angle <= 270) {
                return 270
            } else {
                return 315
            }
        }
        
        return nil
    }
    
}
