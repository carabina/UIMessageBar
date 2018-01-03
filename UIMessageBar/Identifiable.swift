//
//  Identifiable.swift
//  UIMessageBar
//
//  Created by Elias Abel on 8/1/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

/**
 Message views that adopt the `Identifiable` protocol will have duplicate messages
 removed from the `UIMessageView` queue. Typically, the `id` would be set to a string
 representation of the content of the message view. For example, `UIMessageView`, combines
 the title and message body text.
 
 This protocol is optional. Messave views that don't adopt `Identifiable` will not
 have duplicates removed.
 */
public protocol Identifiable {
    var id: String { get }
}
