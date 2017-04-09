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
    @objc optional static func swiftyStyle(update type: String, view: UIView, json: [String: Any])
    @objc optional static func swiftyStyle(color name: String?) -> UIColor?
    @objc optional static func swiftyStyle(number name: String?) -> NSNumber?
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

final class SwiftyStyle {
    public static var isUseDefaultStyle: Bool = true
    
    static var customStyle: SwiftyStyleable.Type? {
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
            
            if isUseDefaultStyle {
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
                case "shadow":
                    setShadow(view, json: json)
                default:
                    break
                }
            }
            
            customStyle?.swiftyStyle?(update: key, view: view, json: json)
        }//forEatch
        
    }
}

extension SwiftyStyle {
    
    static func setTint(_ view: UIView, json: [String: Any]) {
        let object = Object(json)
        if let color = object["color"].color {
            view.tintColor = color
        }
    }
    
    static func setFont(_ view: UIView, json: [String: Any]) {
        let object = Object(json)
        let size = object["size"].float
        setFont(view, fontSize: size)
    }
    
    static func setText(_ view: UIView, json: [String: Any]) {
        let object = Object(json)
        let color = object["color"].color
        setText(view, color: color)
    }
    
    static func setBackground(_ view: UIView, json: [String: Any]) {
        let object = Object(json)
        let color = object["color"].color
        setBackground(view, color: color)
    }
    
    static func setBorder(_ view: UIView, json: [String: Any]) {
        let object = Object(json)
        let color = object["color"].color
        let width = object["width"].float
        let radius = object["radius"].float
        view.drawBorder(width ?? 0, color: color, cornerRadius: radius)
    }
    
    static func setShadow(_ view: UIView, json: [String: Any]) {
        let object = Object(json)
        let x = object["offset"]["x"].float ?? view.layer.shadowOffset.width
        let y = object["offset"]["y"].float ?? view.layer.shadowOffset.height
        let offset = CGSize(width: x, height: y)
        
        let color = object["color"].color
        let radius = object["radius"].float
        let opacity = object["opacity"].float
        view.drawShadow(offset, color: color, radius: radius, opacity: opacity)
    }
}


extension SwiftyStyle {
    static func setFont(_ view: UIView?, fontSize: CGFloat?) {
        guard let view = view, let fontSize = fontSize else { return }
        
        switch view {
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
    
    static func setText(_ view: UIView, color: UIColor?) {
        guard let color = color else { return }
        switch view {
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
    
    static func setBackground(_ view: UIView, color: UIColor?) {
        guard let color = color else { return }
        switch view {
        case let button as UIButton:
            button.setBackgroundImage(.image(by: color), for: .normal)
        default:
            view.backgroundColor = color
        }
    }
    
    static func setBorder(_ view: UIView,
                          width: CGFloat?,
                          color: UIColor?,
                          radius: CGFloat?) {
        view.drawBorder(width ?? 0, color: color, cornerRadius: radius)
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
        
        //숫자가 아닌 영어 찾기
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


