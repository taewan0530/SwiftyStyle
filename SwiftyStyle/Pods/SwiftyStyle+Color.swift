//
//  SwiftyStyle+Color.swift
//  SwiftyStyle
//
//  Created by kimtaewan on 2017. 4. 7..
//  Copyright © 2017년 taewan. All rights reserved.
//

import UIKit


extension SwiftyStyle {
    open class ColorStyle {
        
        
        open static func by(_ name: String?) -> UIColor? {
            guard let name = name else { return nil }
            
            if let styleable = SwiftyStyle.styeable,
                let color = styleable.swiftyStyle?(color: name) {
                return color
            }
            
            switch name.lowercased() {
            case "black":
                return UIColor.black
            case "darkGray":
                return UIColor.darkGray
            case "lightGray":
                return UIColor.lightGray
            case "white":
                return UIColor.white
            case "gray":
                return UIColor.gray
            case "red":
                return UIColor.red
            case "green":
                return UIColor.green
            case "blue":
                return UIColor.blue
            case "cyan":
                return UIColor.cyan
            case "yellow":
                return UIColor.yellow
            case "magenta":
                return UIColor.magenta
            case "orange":
                return UIColor.orange
            case "purple":
                return UIColor.purple
            case "brown":
                return UIColor.brown
            case "clear":
                return UIColor.clear
            default:
                #if TARGET_INTERFACE_BUILDER
                    return UIColor.red
                #else
                    assertionFailure("\(name) color is undefined.")
                    return nil
                #endif
            }
        }
    }
}



