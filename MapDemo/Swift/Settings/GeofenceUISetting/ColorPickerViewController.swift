//
//  ColorPickerViewController.swift
//  GeofenceUISample
//
//  Created by Apple on 31/07/20.
//  Copyright © 2020 Abhinav. All rights reserved.
//

import UIKit

protocol ColorPickerViewControllerDelegate: class {
    func didPickedColor(color: UIColor)
    func didCancelColorPicker()
}

class ColorPickerViewController: UIViewController {
    weak var delegate: ColorPickerViewControllerDelegate?
    
    let backgroundContainerView = UIView(frame: .zero)
    let colorPicker = ColorPicker()
    let slider = UISlider()
    
    let buttonContainer = UIStackView()
    let doneButton = UIButton()
    let closeButton = UIButton()
    
    var containerView: UIView {
        return self.backgroundContainerView
    }
    
    
    var pickedColor: UIColor? {
        didSet {
            if let color = pickedColor {
                self.backgroundContainerView.backgroundColor = color.withAlphaComponent(pickedAlpha ?? 1.0)
            }
        }
    }
    
    var pickedAlpha: CGFloat? {
        didSet {
            if let alpha = pickedAlpha {
                if let backgroundColor = self.backgroundContainerView.backgroundColor {
                    self.backgroundContainerView.backgroundColor = backgroundColor.withAlphaComponent(alpha)
                }
            }
        }
    }
    
    override func loadView() {
        super.loadView()
        view.backgroundColor = .white
        setupBackgroundContainerView()
        setupColorPicker()
        setupSlider()
        setupDoneAndCloseButtons()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @available(iOS 11.0, *)
    func setupBackgroundContainerView() {
        view.addSubview(backgroundContainerView)
        
        backgroundContainerView.translatesAutoresizingMaskIntoConstraints = false
        backgroundContainerView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backgroundContainerView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor).isActive = true
        backgroundContainerView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor).isActive = true
        backgroundContainerView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
    }
        
    func setupColorPicker() {
        containerView.addSubview(colorPicker)
        
        colorPicker.delegate = self
        colorPicker.elementSize = 30
        
        colorPicker.translatesAutoresizingMaskIntoConstraints = false
        colorPicker.topAnchor.constraint(equalTo: containerView.topAnchor).isActive = true
        colorPicker.leftAnchor.constraint(equalTo: containerView.leftAnchor).isActive = true
        colorPicker.rightAnchor.constraint(equalTo: containerView.rightAnchor).isActive = true
        //colorPicker.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        colorPicker.heightAnchor.constraint(equalTo: containerView.heightAnchor, multiplier: 0.5).isActive = true
    }
    
    func setupSlider() {
        containerView.addSubview(slider)
        
        slider.minimumValue = 0
        slider.maximumValue = 1
        slider.value = 1
                
        slider.tintColor = .gray
        slider.backgroundColor = .clear
        slider.minimumTrackTintColor = .blue
        slider.maximumTrackTintColor = .white
        slider.thumbTintColor = .darkGray
        
        slider.translatesAutoresizingMaskIntoConstraints = false
        slider.topAnchor.constraint(equalTo: colorPicker.bottomAnchor, constant: 20).isActive = true
        //slider.topAnchor.constraint(equalTo: colorPicker.bottomAnchor).isActive = true
        slider.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor).isActive = true
        slider.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor).isActive = true
        
        slider.addTarget(self, action: #selector(self.sliderValueDidChange(_:)), for: .valueChanged)
        
        slider.isContinuous = false
    }
    
    @objc func sliderValueDidChange(_ sender: UISlider)
    {
        pickedAlpha = CGFloat(sender.value)
    }
    
    func setupDoneAndCloseButtons() {
        containerView.addSubview(buttonContainer)
        buttonContainer.axis = .horizontal
        buttonContainer.alignment = .fill
        buttonContainer.distribution = .fillEqually
        
        buttonContainer.addArrangedSubview(closeButton)
        buttonContainer.addArrangedSubview(doneButton)
                
        buttonContainer.translatesAutoresizingMaskIntoConstraints = false
        buttonContainer.bottomAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.bottomAnchor).isActive = true
        buttonContainer.leftAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.leftAnchor).isActive = true
        buttonContainer.rightAnchor.constraint(equalTo: containerView.safeAreaLayoutGuide.rightAnchor).isActive = true
        buttonContainer.heightAnchor.constraint(equalToConstant: 60).isActive = true
        
        doneButton.backgroundColor = UIColor.green
        doneButton.setTitleColor(.black, for: .normal)
        doneButton.setTitle("Done", for: .normal)
        doneButton.addTarget(self, action: #selector(doneButtonPressed(_:)), for: .touchUpInside)
        
        closeButton.backgroundColor = UIColor.red
        closeButton.setTitleColor(.black, for: .normal)
        closeButton.setTitle("Close", for: .normal)
        closeButton.addTarget(self, action: #selector(closeButtonPressed(_:)), for: .touchUpInside)
    }
    
    
    @objc func doneButtonPressed(_ sender: UIButton) {
        if let color = pickedColor {
            self.delegate?.didPickedColor(color: color.withAlphaComponent(pickedAlpha ?? 1.0))
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    @objc func closeButtonPressed(_ sender: UIButton) {
        self.delegate?.didCancelColorPicker()
        self.dismiss(animated: true, completion: nil)
    }
}

extension ColorPickerViewController: ColorPickerDelegate {
    func ColorColorPickerTouched(sender: ColorPicker, color: UIColor, point: CGPoint, state: UIGestureRecognizer.State) {
        pickedColor = color
    }
}
