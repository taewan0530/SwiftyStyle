//
//  ViewController.swift
//  SwiftyStyle
//
//  Created by kimtaewan on 2017. 4. 6..
//  Copyright © 2017년 taewan. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}


@IBDesignable
class CustomView: UIView {
    
}


@IBDesignable
class CustomLabel: UILabel {
    
}


@IBDesignable
class CustomButton: UIButton {
    
}


extension SwiftyStyle: SwiftyStyleable {
    public static func swiftyStyle(update view: UIView?, type: String, json: [String : Any]) {
        if type == "transform" {
            let object = SwiftyStyle.Object(json)
            let x = object.getSize("x") ?? 0
            let y = object.getSize("y") ?? 0
            
            var transform = CGAffineTransform(translationX: x, y: y)
            
            if let angle = object.getSize("angle") {
                let rotate = angle/360
                transform = transform.rotated(by: (.pi * 2) * rotate)
            }
            
            view?.transform = transform
        }
    }
    
    public static func swiftyStyle(size name: String?) -> NSNumber? {
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
