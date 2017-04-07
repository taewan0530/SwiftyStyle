//
//  SwiftyStyle+Size.swift
//  SwiftyStyle
//
//  Created by kimtaewan on 2017. 4. 7..
//  Copyright © 2017년 taewan. All rights reserved.
//

import UIKit


extension SwiftyStyle {
    open class SizeStyle {
        
        open static func by(_ name: String?) -> CGFloat? {
            guard let name = name else { return nil }
            
            if let styleable = SwiftyStyle.styeable,
                let fontSize = styleable.swiftyStyle?(size: name) {
                return CGFloat(fontSize.floatValue)
            }
            
            switch name.lowercased() {
            case "xs", "extrasmall":
                return 10
            case "sm", "small":
                return 12
            case "base", "default":
                return 15
            case "md", "medium":
                return 18
            case "lg", "large":
                return 20
            case "xl", "extralarge":
                return 25
            default:
                #if TARGET_INTERFACE_BUILDER
                    return 80
                #else
                    assertionFailure("\(name) size is undefined.")
                    return nil
                #endif
            }
        }
    }
}
