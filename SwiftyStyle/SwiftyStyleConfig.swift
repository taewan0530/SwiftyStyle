//
//  SwiftyConfig.swift
//  SwiftyStyle
//
//  Created by taewan on 2017. 4. 9..
//  Copyright © 2017년 taewan. All rights reserved.
//

import UIKit
//import SwiftyStyle


extension SwiftyStyle: SwiftyStyleable {
    public static func swiftyStyle(update type: String, view: UIView, json: [String : Any]) {
        
        let object: SwiftyStyle.Object = Object(json)
    
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
            
//        case "margin"://nibdesignable
//            let top = object["top"].floatValue
//            let right = object["right"].floatValue
//            let bottom = object["bottom"].floatValue
//            let left = object["left"].floatValue
//            
//        //자식뷰의 리딩 이것저것 다 가져온당.
        default:
            break
        }
    }
    
    public static func swiftyStyle(number name: String?) -> NSNumber? {
        if name == "love" {
            return 60
        }
        return nil
    }
    
    public static func swiftyStyle(color name: String?) -> UIColor? {
        if name == "blue" {
            return UIColor(red: 42.0 / 255.0, green: 125.0 / 255.0, blue: 226.0 / 255.0, alpha: 1.0)
        }
        return nil
    }
}
