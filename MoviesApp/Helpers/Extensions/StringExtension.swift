//
//  StringExtension.swift
//  MoviesApp
//
//  Created by Chayan on 24/01/19.
//  Copyright © 2019 Systango Technologies Pvt Ltd. All rights reserved.
//

import Foundation
import UIKit

extension String {
    
    /// Get YouTube ID from any YouTube link
    var youtubeID: String? {
        let pattern = "((?<=(v|V)/)|(?<=be/)|(?<=(\\?|\\&)v=)|(?<=embed/))([\\w-]++)"
        
        let regex = try? NSRegularExpression(pattern: pattern, options: .caseInsensitive)
        let range = NSRange(location: 0, length: count)
        
        guard let result = regex?.firstMatch(in: self, range: range) else {
            return nil
        }
        
        return (self as NSString).substring(with: result.range)
    }
    
    /// Creates an image with the string
    ///
    /// - Parameters:
    ///   - frame: to set the frame of created image
    ///   - fontSize: to set the font size used in the image
    /// - Returns: Image with text in it with specified frame and font size. Returns nil in case the current context is nil
    func createImageWith(frame: CGRect, fontSize: CGFloat = 12.0) -> UIImage? {
        let nameLabel = UILabel(frame: frame)
        nameLabel.textAlignment = .center
        nameLabel.backgroundColor = .gray
        nameLabel.textColor = .white
        nameLabel.font = UIFont.systemFont(ofSize: fontSize)
        nameLabel.numberOfLines = 0
        nameLabel.text = self
        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.main.scale)
        if let currentContext = UIGraphicsGetCurrentContext() {
            nameLabel.layer.render(in: currentContext)
            let nameImage = UIGraphicsGetImageFromCurrentImageContext()
            return nameImage
        }
        return nil
    }
    
    /// Returns a localized string, can be used if there is no need to specify a tablename, bundle other than main or a value
    ///
    /// - Parameter comment: optional - send if you want to include a comment in localized string
    /// - Returns: default localized string
    func localized(withComment comment: String = "") -> String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: comment)
    }
    
}
