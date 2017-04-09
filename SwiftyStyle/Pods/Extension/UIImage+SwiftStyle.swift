//
//  UIImage+SwiftStyle.swift
//  SwiftyStyle
//
//  Created by taewan on 2017. 4. 9..
//  Copyright © 2017년 taewan. All rights reserved.
//

import UIKit

extension UIImage {
    
    static func image(by color: UIColor) -> UIImage {
        let rect = CGRect(x: 0, y: 0, width: 1, height: 1)
        UIGraphicsBeginImageContext(rect.size)
        
        if let context = UIGraphicsGetCurrentContext() {
            context.setFillColor(color.cgColor)
            context.fill(rect)
            if let image = UIGraphicsGetImageFromCurrentImageContext() {
                UIGraphicsEndImageContext()
                return image
            }
        }
        
        return UIImage()
    }
}
