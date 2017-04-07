//
//  SwiftyStyle.swift
//  SwiftyStyle
//
//  Created by kimtaewan on 2017. 4. 6..
//  Copyright © 2017년 taewan. All rights reserved.
//


import UIKit


@objc
public protocol SwiftyStyleable {
    @objc optional static func swiftyStyle(update view: UIView?, type: String, json: [String: Any])
    @objc optional static func swiftyStyle(color name: String?) -> UIColor?
    @objc optional static func swiftyStyle(size name: String?) -> NSNumber?
    
}

extension UIView {
    @IBInspectable
    public var swiftyStyle: String {
        get {
            assertionFailure("not support")
            return ""
        }
        set {
            SwiftyStyle.generator(self, style: newValue)
        }
    }
}

open class SwiftyStyle {
    static var styeable: SwiftyStyleable.Type? {
        return (self as Any) as? SwiftyStyleable.Type
    }
    
    static func generator(_ view: UIView, style: String) {
        guard let json = try? toJSON(by: style) else {
            #if !TARGET_INTERFACE_BUILDER
                assertionFailure("style to json error")
            #endif
            return
        }
        
        json.forEach { (key: String, value: Any) in
            let json: [String: Any] = value as? [String: Any] ?? [:]
            
            switch key {
            case "font":
                setFont(view, json: json)
            case "text":
                setText(view, json: json)
            case "background", "bg":
                setBackground(view, json: json)
            case "border":
                setBorder(view, json: json)
            case "tint":
                setTint(view, json: json)
            default:
                break
            }
            
            styeable?.swiftyStyle?(update: view, type: key, json: json)
            
        }//forEatch
        
    }
}

extension SwiftyStyle {
    
    open static func setFont(_ view: UIView?, json: [String: Any]) {
        let object = Object(json)
        setFont(view, fontSize: object.getSize("size"))
    }
    
    open static func setText(_ view: UIView?, json: [String: Any]) {
        let object = Object(json)
        setText(view, color: object.getColor("color"))
    }
    
    open static func setBackground(_ view: UIView?, json: [String: Any]) {
        let object = Object(json)
        setBackground(view, color: object.getColor("color"))
    }
    
    open static func setBorder(_ view: UIView?, json: [String: Any]) {
        let object = Object(json)
        let color = object.getColor("color")
        let width = object.getSize("width")
        let radius = object.getSize("radius")
        view?.drawBorder(width ?? 0, color: color, cornerRadius: radius)
    }
    
    open static func setTint(_ view: UIView?, json: [String: Any]) {
        let object = Object(json)
        if let color = object.getColor("color") {
            view?.tintColor = color
        }
    }
}



extension SwiftyStyle {
    
    open static func setFont(_ view: UIView?, fontSize: CGFloat?) {
        guard let target = view, let fontSize = fontSize else { return }
        switch target {
        case let label as UILabel:
            label.font = label.font.withSize(fontSize)
        case let button as UIButton:
            setFont(button.titleLabel, fontSize: fontSize)
        case let textView as UITextView:
            textView.font = textView.font?.withSize(fontSize)
        case let textField as UITextField:
            textField.font = textField.font?.withSize(fontSize)
        default: break
        }
    }
    
    open static func setText(_ view: UIView?, color: UIColor?) {
        guard let target = view, let color = color else { return }
        switch target {
        case let label as UILabel:
            label.textColor = color
        case let button as UIButton:
            button.setTitleColor(color, for: .normal)
        case let textView as UITextView:
            textView.textColor = color
        case let textField as UITextField:
            textField.textColor = color
        default: break
        }
    }
    
    open static func setBackground(_ view: UIView?, color: UIColor?) {
        guard let target = view, let color = color else { return }
        switch target {
        case let button as UIButton:
            button.setBackgroundImage(.image(by: color), for: .normal)
        default:
            target.backgroundColor = color
        }
    }
    
    
    open static func setBorder(_ view: UIView?,
                              width: CGFloat?,
                              color: UIColor?,
                              radius: CGFloat?) {
        view?.drawBorder(width ?? 0, color: color, cornerRadius: radius)
    }
    
    open static func setTint(_ view: UIView?, color: UIColor?) {
        if let color = color {
            view?.tintColor = color
        }
    }
}




// MARK: - fileprivate


fileprivate extension SwiftyStyle {
    /// json형태로 변환 하는것.
    ///
    /// - Parameter style: style description
    /// - Returns: Dictionary
    /// - Throws: 정규식 변환 실패 또는 json 변환 실패
    static func toJSON(by swiftyStyle: String) throws -> [String: Any] {
        var style = swiftyStyle
        
        //함수 느낌을 json 으로 변경해준다.
        style = style.replacingOccurrences(of: "(", with: ":{")
        style = style.replacingOccurrences(of: ")", with: "}")
        style = "{\(style)}"
        
        //영어 찾기 
        let regex = try NSRegularExpression(pattern: "([a-zA-Z]+)\\w*",
                                            options: [.caseInsensitive])
        
        //영어들 ""로 묶어주기
        style = regex.stringByReplacingMatches(in: style,
                                               options: [],
                                               range: NSMakeRange(0, style.utf16.count),
                                               withTemplate: "\"$0\"")
        
        if let data = style.data(using: .utf8, allowLossyConversion: false) {
            let json = try JSONSerialization.jsonObject(with: data, options: [])
            return json as? [String: Any] ?? [:]
        }
        
        return [:]
    }
}


fileprivate extension UIView {
    
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
}



fileprivate extension UIImage {
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
