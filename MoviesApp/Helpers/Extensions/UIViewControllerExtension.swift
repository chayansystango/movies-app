//
//  UIViewControllerExtension.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import UIKit

extension UIViewController {
    
    /// This method instantiates a view controller for the specified Storyboard (enum defined in Constants), if no identifier is sent the class name is considered as the identifier
    ///
    /// - Parameters:
    ///   - storyboard: enum defined in Constants
    ///   - identifier: optional - send if different than class name
    /// - Returns: view controller for specified storyboard and identifier
    class func instance(storyboard: Storyboard, identifier: String = "") -> UIViewController {
        let i = identifier.count == 0 ? nameOfClass : identifier
        return UIStoryboard(name: storyboard.rawValue, bundle: nil).instantiateViewController(withIdentifier: i)
    }
    
}
