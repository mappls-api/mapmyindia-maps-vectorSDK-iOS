//
//  ShapeCell.swift
//  GeofenceUISample
//
//  Created by Abhinav on 23/06/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import UIKit

class ShapeCell: UITableViewCell {

    @IBOutlet weak var ShapeSwitch: UISwitch!
    @IBOutlet weak var lblGeofenceName: UILabel!
    
    @IBOutlet weak var btnEdit: UIButton!
    
    @IBOutlet weak var btnDelete: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
