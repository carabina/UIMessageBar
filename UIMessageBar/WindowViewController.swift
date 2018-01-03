//
//  UIMessageWindowViewController.swift
//  UIMessageBar
//
//  Created by Elias Abel on 8/1/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import UIKit

class UIMessageWindowViewController: UIViewController
{
    fileprivate var window: UIWindow?
    
    let windowLevel: UIWindowLevel
    let config: UIMessageBar.UIMessageBarConfig
    
    override var shouldAutorotate: Bool {
        return config.shouldAutorotate
    }
    
    init(windowLevel: UIWindowLevel = UIWindowLevelNormal, config: UIMessageBar.UIMessageBarConfig)
    {
        self.windowLevel = windowLevel
        self.config = config
        let window = UIMessagePassthroughWindow(frame: UIScreen.main.bounds)
        self.window = window
        super.init(nibName: nil, bundle: nil)
        self.view = UIMessagePassthroughView()
        window.rootViewController = self
        window.windowLevel = windowLevel
    }
    
    func install(becomeKey: Bool) {
        guard let window = window else { return }
        if becomeKey {
            window.makeKeyAndVisible()            
        } else {
            window.isHidden = false
        }
    }
    
    func uninstall() {
        window?.isHidden = true
        window = nil
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override public var preferredStatusBarStyle: UIStatusBarStyle {
        return config.preferredStatusBarStyle ?? super.preferredStatusBarStyle
    }
}
