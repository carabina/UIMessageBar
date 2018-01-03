//
//  UIMessagePassthroughView.swift
//  UIMessageBar
//
//  Created by Elias Abel on 8/5/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import UIKit

class UIMessagePassthroughView: UIControl {

    var tappedHander: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        initCommon()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initCommon()
    }

    private func initCommon() {
        addTarget(self, action: #selector(tapped), for: .touchUpInside)
    }

    @objc func tapped() {
        tappedHander?()
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self && tappedHander == nil ? nil : view
    }
}
