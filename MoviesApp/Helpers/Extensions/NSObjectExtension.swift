//
//  NSObjectExtension.swift
//  LovCash
//
//  Created by Systango on 13/06/18.
//  Copyright © 2018 Systango. All rights reserved.
//

import Foundation

public extension NSObject {
    
    /// Get class name of any NSObject
    public class var nameOfClass: String {
        return String(describing: self)
    }
    
    public var nameOfClass: String {
        return type(of: self).nameOfClass
    }
    
}
