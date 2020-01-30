//
//  MapmyIndiaFeedbackUIKitManager.swift
//  MapmyIndiaFeedbackUIKit
//
//  Created by apple on 05/09/18.
//  Copyright © 2018 MapmyIndia. All rights reserved.
//

import Foundation
import CoreLocation

@objc
open class MapmyIndiaFeedbackUIKitManager:NSObject {
    @objc(sharedManager)
    open static let shared = MapmyIndiaFeedbackUIKitManager()
    
    @objc public func getViewController(location: CLLocation, moduleId: String? = nil) -> UINavigationController {
        let selfBundle = Bundle(for: type(of: self))
        let feedbackVC = MapmyIndiaFeedbackController(nibName: "MapmyIndiaFeedbackController", bundle: selfBundle)
        feedbackVC.feedbackLocation = location
        if let id = moduleId {
            feedbackVC.moduleId = id
        }
        let navigationController = UINavigationController(rootViewController: feedbackVC)
        return navigationController
    }
}
