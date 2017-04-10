//
//  UIView+Extension.swift
//  SwiftyStyle
//
//  Created by taewan on 2017. 4. 9..
//  Copyright © 2017년 taewan. All rights reserved.
//

import UIKit

extension UIView {
    
    func drawBorder(_ borderWidth: CGFloat? = nil,
                    color: UIColor? = nil,
                    cornerRadius: CGFloat? = nil) {
        
        if let borderWidth = borderWidth {
            layer.borderWidth = borderWidth
        }
        if let color = color {
            layer.borderColor = color.cgColor
        }
        if let cornerRadius = cornerRadius {
            layer.cornerRadius = cornerRadius
        }
    }
    
    func drawShadow(_ offset: CGSize? = nil,
                    color: UIColor? = nil,
                    radius: CGFloat? = nil,
                    opacity: CGFloat? = nil) {
        
        if let offset = offset {
            self.layer.shadowOffset = offset
        }
        
        if let radius = radius {
            self.layer.shadowRadius = radius
        }
        
        if let opacity = opacity {
            self.layer.shadowOpacity = Float(opacity)
        } else {
            self.layer.shadowOpacity = 0.6//default
        }
        
        if let color = color {
            self.layer.shadowColor = color.cgColor
        }   
    }
}
