//
//  InstructionTableViewCell.swift
//  MapDemo
//
//  Created by Ayush Dayal on 25/01/20.
//  Copyright © 2020 MMI. All rights reserved.
//

import UIKit

class InstructionTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl_Distance: UILabel!
    @IBOutlet weak var lbl_Instruction: UILabel!
    @IBOutlet weak var directionIndicationContainerView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
