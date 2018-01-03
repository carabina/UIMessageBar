//
//  UIMessageBar.Theme.swift
//  UIMessageBar
//
//  Created by Elias Abel on 8/7/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import UIKit

public extension UIMessageBar {
    /// The theme enum specifies the built-in theme options
    public enum Theme {
        case info
        case success
        case warning
        case error
    }
    
    /// The UIMessageBar.Icon enum provides type-safe access to the included icons.
    public enum Icon: String {
        
        case error = "errorIcon"
        case warning = "warningIcon"
        case success = "successIcon"
        case info = "infoIcon"
        case errorLight = "errorIconLight"
        case warningLight = "warningIconLight"
        case successLight = "successIconLight"
        case infoLight = "infoIconLight"
        case errorSubtle = "errorIconSubtle"
        case warningSubtle = "warningIconSubtle"
        case successSubtle = "successIconSubtle"
        case infoSubtle = "infoIconSubtle"
        
        /// Returns the associated image.
        public var image: UIImage {
            return UIImage(named: rawValue, in: Bundle.frameworkBundle(), compatibleWith: nil)!.withRenderingMode(.alwaysTemplate)
        }
    }
    
    /// The UIMessageBar.IconStyle enum specifies the different variations of the included icons.
    public enum IconStyle {
        
        case `default`
        case light
        case subtle
        case none
        
        /// Returns the image for the given theme
        public func image(theme: UIMessageBar.Theme) -> UIImage? {
            switch (theme, self) {
            case (.info, .default): return UIMessageBar.Icon.info.image
            case (.info, .light): return UIMessageBar.Icon.infoLight.image
            case (.info, .subtle): return UIMessageBar.Icon.infoSubtle.image
            case (.success, .default): return UIMessageBar.Icon.success.image
            case (.success, .light): return UIMessageBar.Icon.successLight.image
            case (.success, .subtle): return UIMessageBar.Icon.successSubtle.image
            case (.warning, .default): return UIMessageBar.Icon.warning.image
            case (.warning, .light): return UIMessageBar.Icon.warningLight.image
            case (.warning, .subtle): return UIMessageBar.Icon.warningSubtle.image
            case (.error, .default): return UIMessageBar.Icon.error.image
            case (.error, .light): return UIMessageBar.Icon.errorLight.image
            case (.error, .subtle): return UIMessageBar.Icon.errorSubtle.image
            default: return nil
            }
        }
    }

}
