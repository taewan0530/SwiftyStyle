//
//  SwiftyConfig.swift
//  SwiftyStyle
//
//  Created by taewan on 2017. 4. 9..
//  Copyright © 2017년 taewan. All rights reserved.
//

import UIKit
import SwiftyStyle


@IBDesignable
class CustomView: UIView {}

@IBDesignable
class CustomLabel: UILabel {}

@IBDesignable
class CustomButton: UIButton {}


// MARK: - Custom Example
extension SwiftyStyle: SwiftyStyleConfigurable {
    public static func swiftyStyle(config type: String, view: UIView, json: [String : Any]) {
        let object = SwiftyStyle.Object(json)
        
        switch type {
        case "transform":
            let x = object["x"].floatValue
            let y = object["y"].floatValue
            
            var transform = view.transform.translatedBy(x: x, y: y)
            if let angle = object["angle"].float {
                let rotate = angle/360
                transform = transform.rotated(by: (.pi * 2) * rotate)
            }
            view.transform = transform
        
        default:
            break
        }
    }
    
    public static func swiftyStyle(number name: String?) -> NSNumber? {
        guard let name = name  else {
            return nil
        }
        
        switch name {
        case "large": return 30
        case "test": return 16
        default: return nil
        }
    }
    
    public static func swiftyStyle(color name: String?) -> UIColor? {
        if name == "blue" {
            return UIColor(red: 42.0 / 255.0, green: 125.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        }
        return nil
    }
}
