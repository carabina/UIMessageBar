//
//  UIMessageMaskingView.swift
//  UIMessageBar
//
//  Created by Elias Abel on 3/11/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import UIKit


class UIMessageMaskingView: UIMessagePassthroughView {

    var accessibleElements: [NSObject] = []

    weak var backgroundView: UIView? {
        didSet {
            oldValue?.removeFromSuperview()
            if let view = backgroundView {
                view.isUserInteractionEnabled = false
                view.frame = bounds
                view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
                addSubview(view)
                sendSubview(toBack: view)
            }
        }
    }

    override func accessibilityElementCount() -> Int {
        return accessibleElements.count
    }

    override func accessibilityElement(at index: Int) -> Any? {
        return accessibleElements[index]
    }

    override func index(ofAccessibilityElement element: Any) -> Int {
        guard let object = element as? NSObject else { return 0 }
        return accessibleElements.index(of: object) ?? 0
    }

    init() {
        super.init(frame: CGRect.zero)
        clipsToBounds = true
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        clipsToBounds = true
    }
}
