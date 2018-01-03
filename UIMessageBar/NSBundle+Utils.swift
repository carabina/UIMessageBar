//
//  NSBundle+Utils.swift
//  UIMessageBar
//
//  Created by Elias Abel on 8/8/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

extension Bundle {
    static func frameworkBundle() -> Bundle {
        let bundle = Bundle(for: UIMessageView.self)
        if let path = bundle.path(forResource: "UIMessageBar", ofType: "bundle") {
            return Bundle(path: path)!
        }
        else {
            return bundle
        }
    }
}
