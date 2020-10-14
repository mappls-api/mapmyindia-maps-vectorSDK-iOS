import Foundation

@objc public enum AutosuggestWidgetSampleType: Int, CaseIterable {
    
    case defaultController
    
    
    case customTheme
    
    
    case customUISearchController
    
    
    case textFieldSearch
}

@objc class AutosuggestWidgetSampleTypeConverter: NSObject {
    
    @objc class func titleFor(sampleType: AutosuggestWidgetSampleType) -> String {
        switch sampleType {
        case .defaultController:
            return "Default Controller"
        case .customTheme:
            return "Custom Theme"
        case .customUISearchController:
            return "Custom UISearchController"
        case .textFieldSearch:
            return "UITextField Search"
        default:
            return ""
        }
    }
}
