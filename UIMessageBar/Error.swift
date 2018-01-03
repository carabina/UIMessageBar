//
//  Error.swift
//  UIMessageBar
//
//  Created by Elias Abel on 8/7/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/**
 The `UIMessageBarError` enum contains the errors thrown by UIMessageBar.
 */
enum UIMessageBarError: Error {
    case cannotLoadViewFromNib(nibName: String)
    case noRootViewController
}
