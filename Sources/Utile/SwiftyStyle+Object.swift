//
//  SwiftyStyle+Size.swift
//  SwiftyStyle
//
//  Created by kimtaewan on 2017. 4. 7..
//  Copyright © 2017년 taewan. All rights reserved.
//

import UIKit


extension SwiftyStyle {
    public struct Object {
        private let _object: Any
        
        private var dictionary: [String: Any]? {
            return _object as? [String: Any]
        }
        
        public subscript (key: String) -> Object {
            return Object(dictionaryValue[key] ?? [:])
        }

      
        
        public var float: CGFloat? {
            if let value = _object as? CGFloat {
                return value
            } else if let name = _object as? String {
                return Object.float(by: name)
            }
            return nil
        }
        
       public var color: UIColor? {
            if let name = _object as? String {
                return Object.color(by: name)
            }
            return nil
        }
        
        public var dictionaryValue: [String: Any] {
            return self.dictionary ?? [:]
        }
       
        public var floatValue: CGFloat {
            return self.float ?? 0
        }
        
        public var colorValue: UIColor {
            return self.color ?? .white
        }
        
        
        public init(_ object: Any) {
            self._object = object
        }
        
        
        
        
    }
}


extension SwiftyStyle.Object {
    public static func color(by name: String?) -> UIColor? {
        guard let name = name else { return nil }
        
        if let custom = SwiftyStyle.styleConfig,
            let color = custom.swiftyStyle?(color: name) {
            return color
        }
        
        switch name.lowercased() {
        case "black":
            return UIColor.black
        case "darkgray":
            return UIColor.darkGray
        case "lightgray":
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
    
    public static func float(by name: String?) -> CGFloat? {
        guard let name = name else { return nil }
        
        if let custom = SwiftyStyle.styleConfig,
            let number = custom.swiftyStyle?(number: name) {
            return CGFloat(number.floatValue)
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
                assertionFailure("\(name) number is undefined.")
                return nil
            #endif
        }
    }
}
