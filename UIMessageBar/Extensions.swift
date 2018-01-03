//
//  Array+Utils.swift
//  UIMessageBar
//
//  Created by Tim Moose on 8/30/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Darwin
import Foundation
import UIKit

public extension Array {
    
    /**
     Returns a random element from the array. Can be used to create a playful
     message that cycles randomly through a set of emoji icons, for example.
     */
    public func getRandom() -> Iterator.Element? {
        guard count > 0 else { return nil }
        return self[Int(arc4random_uniform(UInt32(count)))]
    }
}

private let UIModalFullScreenStyles: [UIModalPresentationStyle] = [.fullScreen, .overFullScreen]

extension UIViewController {
    
    func selectPresentationContextTopDown(_ config: UIMessageBar.UIMessageBarConfig) -> UIViewController {
        let presentationStyle = config.presentationStyle
        if let presented = presentedFullScreenViewController() {
            return presented.selectPresentationContextTopDown(config)
        } else if case .top = presentationStyle, let navigationController = selectNavigationControllerTopDown() {
            return navigationController
        } else if case .bottom = presentationStyle, let tabBarController = selectTabBarControllerTopDown() {
            return tabBarController
        }
        return UIMessageWindowViewController(windowLevel: self.view.window?.windowLevel ?? UIWindowLevelNormal, config: config)
    }
    
    fileprivate func selectNavigationControllerTopDown() -> UINavigationController? {
        if let presented = presentedFullScreenViewController() {
            return presented.selectNavigationControllerTopDown()
        } else if let navigationController = self as? UINavigationController {
            if navigationController.ifVisible(view: navigationController.navigationBar) {
                return navigationController
            }
            return navigationController.topViewController?.selectNavigationControllerTopDown()
        } else if let tabBarController = self as? UITabBarController {
            return tabBarController.selectedViewController?.selectNavigationControllerTopDown()
        }
        return nil
    }
    
    fileprivate func selectTabBarControllerTopDown() -> UITabBarController? {
        if let presented = presentedFullScreenViewController() {
            return presented.selectTabBarControllerTopDown()
        } else if let navigationController = self as? UINavigationController {
            return navigationController.topViewController?.selectTabBarControllerTopDown()
        } else if let tabBarController = self as? UITabBarController {
            if tabBarController.ifVisible(view: tabBarController.tabBar) {
                return tabBarController
            }
            return tabBarController.selectedViewController?.selectTabBarControllerTopDown()
        }
        return nil
    }
    
    fileprivate func presentedFullScreenViewController() -> UIViewController? {
        if let presented = self.presentedViewController, UIModalFullScreenStyles.contains(presented.modalPresentationStyle) {
            return presented
        }
        return nil
    }
    
    func selectPresentationContextBottomUp(_ config: UIMessageBar.UIMessageBarConfig) -> UIViewController {
        let presentationStyle = config.presentationStyle
        if let parent = parent {
            if let navigationController = parent as? UINavigationController {
                if case .top = presentationStyle, navigationController.ifVisible(view: navigationController.navigationBar) {
                    return navigationController
                }
                return navigationController.selectPresentationContextBottomUp(config)
            } else if let tabBarController = parent as? UITabBarController {
                if case .bottom = presentationStyle, tabBarController.ifVisible(view: tabBarController.tabBar) {
                    return tabBarController
                }
                return tabBarController.selectPresentationContextBottomUp(config)
            }
        }
        if self.view is UITableView {
            // Never select scroll view as presentation context
            // because, you know, it scrolls.
            if let parent = self.parent {
                return parent.selectPresentationContextBottomUp(config)
            } else {
                return UIMessageWindowViewController(windowLevel: self.view.window?.windowLevel ?? UIWindowLevelNormal, config: config)
            }
        }
        return self
    }
    
    func ifVisible(view: UIView) -> Bool {
        if view.isHidden { return false }
        if view.alpha == 0.0 { return false }
        let frame = self.view.convert(view.bounds, from: view)
        if !self.view.bounds.intersects(frame) { return false }
        return true
    }
}

public extension UIMessageBar {
    /// Show a custom UIMessageView
    ///
    /// - Parameters:
    ///   - layout: Specifies the layout style
    ///   - position: Specifies the bar position
    ///   - title: Title string
    ///   - message: Message string
    ///   - icon: Icon image, set `nil` to hide icon
    ///   - button: Button title string, set `nil` to hide button
    ///   - duration: Specifies the duration of the message view's time on screen before it is automatically hidden. The view will not hidden automatically if this value is less than `0.01`
    ///   - label: A label string to identify the message view
    ///   - action: An action closure
    public static func show(_ layout: UIMessageView.Layout = .tabView,
                            at position: UIMessageBar.PresentationStyle = .bottom,
                            title: String,
                            message: String,
                            icon: UIImage? = UIMessageBar.Icon.info.image,
                            button: String?,
                            duration: TimeInterval = 2.50,
                            label: String = #function,
                            action: UIMessageBar.BarActionClosure?) {
        
        let view: UIMessageView = UIMessageView.viewFromNib(layout: layout)
        
        view.configureContent(title: title, body: message, iconImage: icon, iconText: nil, buttonImage: nil, buttonTitle: button, action: action)
        view.configureTheme(.info, iconStyle: .default)
        view.accessibilityPrefix = label
        
//        let iconText = ["🐸", "🐷", "🐬", "🐠", "🐍", "🐹", "🐼"].getRandom()
//        view.configureTheme(backgroundColor: UIColor.purple, foregroundColor: UIColor.white, iconImage: nil, iconText: iconText)
//        view.button?.setImage(UIMessageBar.Icon.errorSubtle.image, for: .normal)
//        view.button?.setTitle(nil, for: .normal)
//        view.button?.backgroundColor = UIColor.clear
//        view.button?.tintColor = UIColor.green.withAlphaComponent(0.7)
        
        view.configureDropShadow()
        
        view.button?.isHidden = (button == nil)
        
        if button != nil && action == nil {
            view.buttonTapHandler = { _, _ in
                UIMessageBar.hide()
            }
        }
        
        view.iconImageView?.isHidden = (icon == nil)
        view.iconLabel?.isHidden = true
        
        // Show
        UIMessageBar.show(config: UIMessageBar.customConfig(position: position, duration: duration), view: view)
    }
    
    public static func customConfig(position: UIMessageBar.PresentationStyle = .bottom,
                                    duration: TimeInterval = 2.50) -> UIMessageBarConfig {
        // UIMessageBarConfig setup
        
        var config = UIMessageBar.defaultConfig
        config.presentationContext = .window(windowLevel: UIWindowLevelStatusBar)
        let forever = duration <= 0.01
        if forever {
            config.duration = Duration.forever
        } else {
            config.duration = Duration.seconds(seconds: duration)
        }
        config.dimMode = .gray(interactive: !forever)
        config.shouldAutorotate = true
        config.interactiveHide = !forever
        config.preferredStatusBarStyle = .lightContent
        config.presentationStyle = position
        
        return config
    }
}



