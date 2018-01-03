//
//  AccessibleMessage.swift
//  UIMessageBar
//
//  Created by Elias Abel on 3/11/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/**
 Message views that `AccessibleMessage`, as `UIMessageView` does will
 have proper accessibility behavior when displaying messages.
 `UIMessageView` implements this protocol.
 */
public protocol AccessibleMessage {
    var accessibilityMessage: String? { get }
    var accessibilityElement: NSObject? { get }
    var additonalAccessibilityElements: [NSObject]? { get }
}
