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
    public static let shared = MapmyIndiaFeedbackUIKitManager()
    
    public func getViewController(location: String, flag: Int? = 0, speed: Int? = 0 , alt: Int? = 0,  quality: Int? = 0, bearing: Int? = 0, accuracy: Int? = 0, utc: Double? = 0, expiry: Double? = 0, zeroId: String? = nil, pushEvent: Bool? = nil, appVersion: String? = nil, osVersionoptional: String? = nil, deviceName: String? = nil) -> UINavigationController {
        let selfBundle = Bundle(for: type(of: self))
        let feedbackVC = MapmyIndiaFeedbackController(nibName: "MapmyIndiaFeedbackController", bundle: selfBundle)
    
        feedbackVC.feedbackLocation = location
        feedbackVC.accuracy = accuracy
        feedbackVC.alt = alt
        feedbackVC.appVersion = appVersion
        feedbackVC.bearing = bearing
        feedbackVC.deviceName = deviceName
        feedbackVC.expiry = expiry
        feedbackVC.flag = flag
        feedbackVC.osVersionoptional = osVersionoptional
        feedbackVC.quality = quality
        feedbackVC.speed = speed
        feedbackVC.utc = utc
        feedbackVC.zeroId = zeroId
        feedbackVC.flag = flag
        feedbackVC.pushEvent = pushEvent
        
        let navigationController = UINavigationController(rootViewController: feedbackVC)
        return navigationController
    }
}
