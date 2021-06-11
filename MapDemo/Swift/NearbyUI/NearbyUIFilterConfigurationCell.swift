
//
//  LocationChooserTableViewCell.swift
//  MapDemo
//
//  Created by Apple on 09/01/21.
//  Copyright © 2021 MMI. All rights reserved.
//

import UIKit

class NearbyUIFilterConfigurationCell: UITableViewCell {
    var autocompleteWidgetButton: UIButton!
    var refLocationAutocompleteWidgetButton: UIButton!
    var viaAutocompleteWidgetButton: UIButton!
    var nearbyRadiusTextField = UITextField()
    var destinationLocationTextField = UITextField()
    var boundTextField = UITextField()
        
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
        
//        sourceLocationTextField.isHidden = true
        destinationLocationTextField.isHidden = true
        boundTextField.isHidden = true
        autocompleteWidgetButton.isHidden = true
        viaAutocompleteWidgetButton.isHidden = true
        boundTextField.isHidden = true
        refLocationAutocompleteWidgetButton.isHidden = true
    }
    
    func setupViews() {
        nearbyRadiusTextField = UITextField()
        nearbyRadiusTextField.placeholder = "Set Radius"
//        sourceLocationTextField.isHidden = true
        nearbyRadiusTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(nearbyRadiusTextField)
        
        destinationLocationTextField = UITextField()
        destinationLocationTextField.placeholder = "Set Reference Location"
        destinationLocationTextField.isHidden = true
        destinationLocationTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(destinationLocationTextField)
        
        boundTextField = UITextField()
        boundTextField.placeholder = "Via (eLoc or cordinate in longitude, latitude)"
        boundTextField.isHidden = true
        boundTextField.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(boundTextField)
        
        autocompleteWidgetButton = UIButton()
        autocompleteWidgetButton.setTitle("", for: .normal)
        autocompleteWidgetButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(autocompleteWidgetButton)
        
        refLocationAutocompleteWidgetButton = UIButton()
        refLocationAutocompleteWidgetButton.setTitle("", for: .normal)
        refLocationAutocompleteWidgetButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(refLocationAutocompleteWidgetButton)
        
        viaAutocompleteWidgetButton = UIButton()
        viaAutocompleteWidgetButton.setTitle("", for: .normal)
        viaAutocompleteWidgetButton.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(viaAutocompleteWidgetButton)
    }
    
    func setupConstraints() {
        nearbyRadiusTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        nearbyRadiusTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        nearbyRadiusTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        nearbyRadiusTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        
        destinationLocationTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        destinationLocationTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        destinationLocationTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        destinationLocationTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        
        boundTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        boundTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        boundTextField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        boundTextField.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        
        autocompleteWidgetButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        autocompleteWidgetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        autocompleteWidgetButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        autocompleteWidgetButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        
        refLocationAutocompleteWidgetButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        refLocationAutocompleteWidgetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        refLocationAutocompleteWidgetButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        refLocationAutocompleteWidgetButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
        
        viaAutocompleteWidgetButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        viaAutocompleteWidgetButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
        viaAutocompleteWidgetButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 3).isActive = true
        viaAutocompleteWidgetButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -3).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
