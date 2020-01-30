//
//  MapmyIndiaReportCategoryCell.swift
//  MapmyIndiaFeedbackUIKit
//
//  Created by apple on 28/08/18.
//  Copyright © 2018 MapmyIndia. All rights reserved.
//

import UIKit

class MapmyIndiaReportCategoryCell: UITableViewCell {

    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var selectionImageView: UIImageView!
    
    var selectionImage: UIImage?
    var unSelectionImage: UIImage?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
        unSelectionImage = UIImage(named: "UnselectedButton", in: Bundle(for: type(of: self)), compatibleWith: nil)
        selectionImage = UIImage(named: "SelectedButton", in: Bundle(for: type(of: self)), compatibleWith: nil)
        selectionImageView.image = unSelectionImage
        //self.selectedBackgroundView?.backgroundColor = UIColor.clear
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        //selectionImageView.image = selected ? selectionImage : unSelectionImage
        /*UIView.transition(with: selectionImageView,
                          duration: 0.6,
                          options: .transitionCrossDissolve,
                          animations: {
                            self.selectionImageView.image = selected ? self.selectionImage : self.unSelectionImage
        }, completion: nil)*/
        
        if animated {
            if (selected) {
                let expandTransform:CGAffineTransform = CGAffineTransform(scaleX: 1.15, y: 1.15);
                UIView.transition(with: self.selectionImageView,
                                              duration:0.1,
                                              options: UIView.AnimationOptions.transitionCrossDissolve,
                                              animations: {
                                                self.selectionImageView.image = selected ? self.selectionImage : self.unSelectionImage
                                                self.selectionImageView.transform = expandTransform
                },
                                              completion: {(finished: Bool) in
                                                UIView.animate(withDuration: 0.5,
                                                                           delay:0.1,
                                                                           usingSpringWithDamping:0.50,
                                                                           initialSpringVelocity:0.5,
                                                                           options:UIView.AnimationOptions.curveEaseOut,
                                                                           animations: {
                                                                            self.selectionImageView.transform = expandTransform.inverted()
                                                }, completion:nil)
                })
            } else {
                UIView.transition(with: selectionImageView,
                                  duration: 0.4,
                                  options: .transitionCrossDissolve,
                                  animations: {
                                    self.selectionImageView.image = selected ? self.selectionImage : self.unSelectionImage
                }, completion: nil)
            }
        } else {
            selectionImageView.image = selected ? selectionImage : unSelectionImage
        }
    }
}
