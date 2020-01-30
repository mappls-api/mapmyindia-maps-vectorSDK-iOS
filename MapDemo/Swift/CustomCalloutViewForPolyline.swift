//
//  CustomCalloutViewForPolyline.swift
//  PolylineCalloutSample
//
//  Created by Ayush Dayal on 20/01/20.
//  Copyright © 2020 MapmyIndia. All rights reserved.
//

import UIKit
import Mapbox

class CustomCalloutViewForPolyline: UIView , MGLCalloutView{
    
    var representedObject: MGLAnnotation
    
    let dismissesAutomatically: Bool = false
    let isAnchoredToAnnotation: Bool = true
    
    override var center: CGPoint {
        set {
            var newCenter = newValue
            newCenter.y -= bounds.midY
            newCenter.x += bounds.midX
            super.center = newCenter
        }
        get {
            return super.center
        }
    }
    
    lazy var leftAccessoryView = UIView() /* unused */
    lazy var rightAccessoryView = UIView() /* unused */
    
    weak var delegate: MGLCalloutViewDelegate?
    
    let tipHeight: CGFloat = 10.0
    let tipWidth: CGFloat = 40.0
    
    let mainBody: UIButton
    
    required init(representedObject: MGLAnnotation) {
        self.representedObject = representedObject
        self.mainBody = UIButton()
        super.init(frame: .zero)
        mainBody.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 7, right: 0)
        addSubview(mainBody)
    }
    
    required init?(coder decoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - MGLCalloutView API
    
    func presentCallout(from rect: CGRect, in view: UIView, constrainedTo constrainedRect: CGRect, animated: Bool) {
        delegate?.calloutViewWillAppear?(self)
        view.addSubview(self)
        
        // Prepare title label.
        mainBody.setBackgroundImage(UIImage(named: "ETABubble"),for: .normal)
        mainBody.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: .normal)
        mainBody.isUserInteractionEnabled = false
        mainBody.titleEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 3, right: 0)
        mainBody.setTitle(representedObject.title!, for: .normal)
        let label = UILabel()
        label.text = (representedObject.title ?? "") ?? ""
        mainBody.frame = CGRect(x: mainBody.frame.minX + 2, y: mainBody.frame.minY + 5, width: label.intrinsicContentSize.width + 8, height: mainBody.frame.height - 10)
        mainBody.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        mainBody.sizeToFit()
        
        self.bringSubviewToFront(mainBody)
        
        if isCalloutTappable() {
            // Handle taps and eventually try to send them to the delegate (usually the map view).
            mainBody.addTarget(self, action: #selector(CustomCalloutViewForPolyline.calloutTapped), for: .touchUpInside)
        } else {
            // Disable tapping and highlighting.
            mainBody.isUserInteractionEnabled = false
        }
        
        // Prepare our frame, adding extra space at the bottom for the tip.
        let frameWidth = mainBody.bounds.size.width
        let frameHeight = mainBody.bounds.size.height
        let frameOriginX = rect.origin.x
        let frameOriginY = rect.origin.y - frameHeight
        frame = CGRect(x: frameOriginX, y: frameOriginY, width: frameWidth, height: frameHeight)
        
        if animated {
            alpha = 0
            
            UIView.animate(withDuration: 0.2) { [weak self] in
                guard let strongSelf = self else {
                    return
                }
                strongSelf.alpha = 1
                strongSelf.delegate?.calloutViewDidAppear?(strongSelf)
            }
        } else{
            delegate?.calloutViewDidAppear?(self)
        }
    }
    
    func dismissCallout(animated: Bool) {
        if (superview != nil) {
            if animated {
                UIView.animate(withDuration: 0.2, animations: { [weak self] in
                    self?.alpha = 0
                    }, completion: { [weak self] _ in
                        self?.removeFromSuperview()
                })
            } else {
                removeFromSuperview()
            }
        }
    }
    
    // MARK: - Callout interaction handlers
    
    func isCalloutTappable() -> Bool {
        if let delegate = delegate {
            if delegate.responds(to: #selector(MGLCalloutViewDelegate.calloutViewShouldHighlight)) {
                return delegate.calloutViewShouldHighlight!(self)
            }
        }
        return false
    }
    
    @objc func calloutTapped() {
        if isCalloutTappable() && delegate!.responds(to: #selector(MGLCalloutViewDelegate.calloutViewTapped)) {
            delegate!.calloutViewTapped!(self)
        }
    }
    
}

