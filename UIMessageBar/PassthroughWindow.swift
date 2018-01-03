//
//  UIMessagePassthroughWindow.swift
//  UIMessageBar
//
//  Created by Elias Abel on 8/5/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import UIKit

class UIMessagePassthroughWindow: UIWindow {

    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
}
