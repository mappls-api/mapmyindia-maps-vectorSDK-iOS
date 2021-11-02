//
//  StyleTableViewCell.swift
//  DemoApp_Swift
//
//  Created by CE00120420 on 22/05/21.
//  Copyright © 2021 Mapbox. All rights reserved.
//

import UIKit

class MapmyIndiaMapStyleTableViewCell: UITableViewCell {

    var styleName: UILabel!
    var styleDetails: UILabel!
    var styleImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
         setupViews()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
 
    }
    
    func setupViews(){
        styleName = UILabel()
        styleName.text = "Style Name"
        styleName.textColor = .black
        styleName.numberOfLines = 0
        styleName.font = .boldSystemFont(ofSize: 17)
        self.contentView.addSubview(styleName)
        
        styleDetails = UILabel()
        styleDetails.text = "Style Name descriptions wiht is te"
        styleDetails.numberOfLines = 0
        styleDetails.textColor = .black
        self.contentView.addSubview(styleDetails)
        
        styleImage = UIImageView()
        styleImage.contentMode = .scaleAspectFit
        self.contentView.addSubview(styleImage)
        
        styleImage.translatesAutoresizingMaskIntoConstraints = false
        styleImage.trailingAnchor.constraint(equalTo: self.trailingAnchor,constant: -7).isActive = true
        styleImage.heightAnchor.constraint(equalToConstant: 150).isActive = true
        styleImage.widthAnchor.constraint(equalToConstant: 150).isActive = true
        styleImage.topAnchor.constraint(equalTo: self.topAnchor, constant: 5).isActive = true
        styleImage.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        
        styleName.translatesAutoresizingMaskIntoConstraints = false
        styleName.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        styleName.trailingAnchor.constraint(equalTo: self.styleImage.leadingAnchor, constant: -7).isActive = true
        styleName.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: -30).isActive = true
        styleDetails.translatesAutoresizingMaskIntoConstraints = false
        styleDetails.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 5).isActive = true
        styleDetails.trailingAnchor.constraint(equalTo: self.styleImage.leadingAnchor, constant: -5).isActive = true
        styleDetails.topAnchor.constraint(equalTo: self.styleName.bottomAnchor, constant: 5).isActive = true
        
        
        
        
    }

}
