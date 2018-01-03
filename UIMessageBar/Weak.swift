//
//  Weak.swift
//  UIMessageBar
//
//  Created by Elias Abel on 6/4/16.
//  Copyright © 2016 Meniny. All rights reserved.
//

import Foundation

public class Weak<T: AnyObject> {
    public weak var value : T?
    public init(value: T?) {
        self.value = value
    }
}
