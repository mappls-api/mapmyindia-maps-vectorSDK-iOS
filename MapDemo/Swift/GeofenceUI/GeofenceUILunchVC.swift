//
//  LunchVC.swift
//  MapmyIndiaGeofenceUI
//
//  Created by Abhinav on 29/05/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import UIKit

class GeofenceUILunchVC: UIViewController {

    var btnDefaultClicked: UIButton!
    var btnCustomGefenceClicked: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Geofence UI"
        let settingsButton = UIBarButtonItem(title: "Settings", style: .plain, target: self, action: #selector(openSettingController))
        navigationItem.rightBarButtonItems = [settingsButton]
        
        self.view.backgroundColor = .white
        setupButtonLayout()
        
    }
    
    @objc func openSettingController() {
        let settingsVC = SettingsViewController(nibName: nil, bundle: nil)
        self.navigationController?.pushViewController(settingsVC, animated: true)
    }
    

    
    @objc func btnCustomGefence() {
        print(geofenceShapeData.currentShapeArr)
        geofenceShapeData.currentShapeArr = []
        let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DrawCircleVC") as? DrawCircleVC
        self.navigationController?.pushViewController(vctrl!, animated: true)
    }
    
    @objc func btnDefault() {
        let vctrl = DefaultGeofenceVC()
        self.navigationController?.pushViewController(vctrl, animated: true)
    }
    
    func setupButtonLayout() {
        btnDefaultClicked = UIButton()
        btnDefaultClicked.setTitle("Default", for: .normal)
        btnDefaultClicked.backgroundColor = .gray
        btnDefaultClicked.setTitleColor(.white, for: .normal)
        btnDefaultClicked.addTarget(self, action: #selector(btnDefault), for: .touchUpInside)
        self.view.addSubview(btnDefaultClicked)
        
        btnDefaultClicked.translatesAutoresizingMaskIntoConstraints = false
        btnDefaultClicked.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnDefaultClicked.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: -20).isActive = true
        btnDefaultClicked.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnDefaultClicked.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
        
        btnCustomGefenceClicked = UIButton()
        btnCustomGefenceClicked.setTitle("Custom", for: .normal)
        btnCustomGefenceClicked.backgroundColor = .gray
        btnCustomGefenceClicked.setTitleColor(.white, for: .normal)
        btnCustomGefenceClicked.addTarget(self, action: #selector(btnCustomGefence), for: .touchUpInside)
        self.view.addSubview(btnCustomGefenceClicked)
        
        btnCustomGefenceClicked.translatesAutoresizingMaskIntoConstraints = false
        btnCustomGefenceClicked.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        btnDefaultClicked.topAnchor.constraint(equalTo: btnCustomGefenceClicked.bottomAnchor, constant: 30).isActive = true
        btnCustomGefenceClicked.heightAnchor.constraint(equalToConstant: 50).isActive = true
        btnCustomGefenceClicked.widthAnchor.constraint(equalToConstant: 200).isActive = true
        
    }
}
