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
        let json: [String: Any]
        
        public func get<T>(_ key: String) -> T? {
            return json[key] as? T
        }
        
        public func getSize(_ key: String) -> CGFloat? {
            if let value = json[key] as? CGFloat {
                return value
            } else if let name = json[key] as? String {
                return SizeStyle.by(name)
            }
            return nil
        }
        
        public func getColor(_ key: String) -> UIColor? {
            if let name = json[key] as? String {
                return ColorStyle.by(name)
            }
            return nil
        }
        
        public init(_ json: [String: Any]) {
            self.json = json
        }
    }
}
