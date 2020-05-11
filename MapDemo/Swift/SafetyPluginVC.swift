//
//  SafetyPluginVC.swift
//  MapDemo
//
//  Created by CE00078515 on 11/05/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit
import MapmyIndiaSafetyPlugin
class SafetyPluginVC: UIViewController {
    
    var isSafetyPluginInitialezed: Bool = false

      @IBOutlet weak var lblDistrictName: UILabel!
      @IBOutlet weak var lblZoneName: UILabel!
      @IBOutlet weak var containmentZoneDistance: UILabel!
      @IBOutlet weak var containmentZoneName: UILabel!
      
      @IBOutlet weak var btnCheckNow: UIButton!
      
      @IBOutlet weak var lblPlsWait: UILabel!
      
      @IBOutlet weak var btnStopTrack: UIButton!
    
      @IBOutlet weak var btnInitilize: UIButton!
      var isLoading: Bool = false

     @IBAction func InitilizeBtn(_ sender: Any) {
          
         // keys.publisherKey = ""
          
          MapmyIndiaSafetyPlugin.shared.initilize() { (success, onfailError) in
                     if success
                      {
                           print("INITILIZATION =========%@",success)
                        self.isSafetyPluginInitialezed = true
                          self.btnInitilize.isEnabled = false
                          self.btnInitilize.backgroundColor = UIColor.gray
                          self.btnCheckNow.isEnabled = true
                          self.btnTrackNow.isEnabled = true
                          self.btnStopTrack.isEnabled = false
                          self.btnStopTrack.backgroundColor = UIColor.gray
                          
                          self.resetViews()
                      }
                     else{
                        print(onfailError)
                      }
                    
                }
      }
      
      @IBAction func btnStopTrackClicked(_ sender: UIButton) {
          let isEnabled = sender.isEnabled
                               if isEnabled {
                                   MapmyIndiaSafetyPlugin.shared.stopSafetyPlugin()
                                    resetViews()
                               }
        }
      @IBAction func btnCheckNowClicked(_ sender: UIButton) {
         
           print(sender.isSelected)
          let isEnabled = sender.isEnabled
          if isEnabled {
              self.lblPlsWait.isHidden = false
              self.containmentZoneConatinerView.isHidden = true
              
              btnCheckNow.isEnabled = false
              btnCheckNow.backgroundColor = UIColor.gray
              MapmyIndiaSafetyPlugin.shared.getContainmentZone()
          }
      }
      
      @IBOutlet weak var btnTrackNow: UIButton!
      @IBAction func btnTrackNowClicked(_ sender: UIButton) {

                  print(sender.isSelected)
                 sender.isSelected = !sender.isSelected
                 let isEnabled = sender.isEnabled
                        if isEnabled {
                          self.lblPlsWait.isHidden = false
                          self.containmentZoneConatinerView.isHidden = true
                          
                            btnTrackNow.isEnabled = false
                            btnTrackNow.backgroundColor = UIColor.gray
                            MapmyIndiaSafetyPlugin.shared.startSafetyPlugin()
                          
                          btnStopTrack.isEnabled = true
                          btnStopTrack.backgroundColor = UIColor.blue
                        }
                      
      }
      
      @IBOutlet weak var containmentZoneConatinerView: UIView!
    
      func resetViews() {
          containmentZoneConatinerView.isHidden = true
          lblPlsWait.isHidden = true
          
           btnStopTrack.isEnabled = false
           btnStopTrack.backgroundColor = UIColor.gray
          btnTrackNow.isEnabled = true
          btnTrackNow.backgroundColor = UIColor.blue
          
          btnCheckNow.backgroundColor = UIColor.blue
          
          btnStopTrack.isEnabled = false
      }

    override func viewDidLoad() {
        super.viewDidLoad()

         resetViews()
              let savedValue = isSafetyPluginInitialezed
                  if !savedValue
                    {
                      btnInitilize.isEnabled = true
                      btnInitilize.backgroundColor = UIColor.blue
                      
                              btnCheckNow.isEnabled = false
                              btnTrackNow.isEnabled = false
                              btnStopTrack.isEnabled = false
                              btnStopTrack.backgroundColor = UIColor.gray
                              btnCheckNow.backgroundColor = UIColor.gray
                              btnTrackNow.backgroundColor = UIColor.gray
                    }
                  else{
                      self.btnInitilize.isEnabled = false
                      self.btnInitilize.backgroundColor = UIColor.gray
                      
                      
                         }
              
               isLoading = true
              MapmyIndiaSafetyPlugin.shared.delegate = self
              MapmyIndiaSafetyPlugin.shared.enableLocalNotification(notificationEnabled: true)

        // Do any additional setup after loading the view.
    }
    


}
extension SafetyPluginVC: MapmyIndiaSafetyPluginDelegate {
    
    func didFail(_ error: NSError) {
        print("Display error%@",error.description)
              
                       isLoading = false
                     DispatchQueue.main.async {
                         self.lblPlsWait.isHidden = true
                         if !self.btnCheckNow.isEnabled {
                             self.btnCheckNow.isEnabled = true
                          self.btnCheckNow.backgroundColor = UIColor.blue

                         }
                         
                     }
                     print(error.localizedDescription)
    }
    
    func didUpdateContainmentInfo(_ info: ContainmentZoneInfo) {
        self.lblPlsWait.isHidden = true
                                   self.containmentZoneConatinerView.isHidden = false
                                   self.isLoading = false
                                 if !self.btnCheckNow.isEnabled {
                                     self.btnCheckNow.isEnabled = true
                                   self.btnCheckNow.backgroundColor = UIColor.blue
                                    }
        
                   let containmentWithInStatus = info.isInsideContainmentZone ?? false
                   let containmentName = info.containmentZoneName ?? ""
                   let containmentDistance = info.distanceToNearestZone ?? 0
                   let containmentZoneName = info.zoneType ?? ""
                   let containmentZoneDistrictName = info.districtName ?? ""
               
                  print("MAP LINK ======   %@",info.mapLink ?? "")
                                   if containmentWithInStatus == true
                                                     {
                                                         self.containmentZoneConatinerView.backgroundColor = UIColor.red
                                                     }
                                                     else
                                                     {
                                                         self.containmentZoneConatinerView.backgroundColor = UIColor.green
                                                     }
                                                      print(containmentName)
                                                       print(containmentDistance)
                                                      print(containmentZoneName)
                                                       print(containmentZoneDistrictName)
                                
                                                      var distanceNew = CGFloat(containmentDistance)
                                                       let tempUnit = (distanceNew >= 1000) ? "km" : "meters"
                                                       if (distanceNew >= 1000) {
                                                          distanceNew /= 1000
                                                           }
                                                        print("DISTANCE FIND===== \(Int(distanceNew)) \(tempUnit)")
                                                      self.containmentZoneName.text = containmentName
                                                      self.containmentZoneDistance.text = ("\(Int(distanceNew)) \(tempUnit)")
                                                      self.lblZoneName.text = containmentZoneName
                                                      self.lblDistrictName.text = containmentZoneDistrictName
    }
    
    func didRequestForContainmentInfo() {
         if !btnTrackNow.isEnabled {
                   self.lblPlsWait.isHidden = false
               }
    }
    
}
