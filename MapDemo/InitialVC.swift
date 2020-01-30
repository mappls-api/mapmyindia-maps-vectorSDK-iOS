//
//  InitialVC.swift
//  MapDemo
//
//  Created by CE Info on 27/07/18.
//  Copyright © 2018 MMI. All rights reserved.
//

import UIKit

class InitialVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //    MARK: -  Button Method
    @IBAction func objectiveC(_ sender: Any) {
        let vctrl = UIStoryboard(name: "MainC", bundle: nil).instantiateViewController(withIdentifier: "ListVCOC") as? ListVCOC
        self.navigationController?.pushViewController(vctrl!, animated: true)
    }
    
    @IBAction func swift(_ sender: Any) {
        let vctrl = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ListVC") as? ListVC
        self.navigationController?.pushViewController(vctrl!, animated: true)
    }
}
