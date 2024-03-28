//
//  UIColor+Extensions.swift
//  SchematicViewer
//
//  Created by Amos Todman on 3/11/24.
//

import UIKit

extension UIColor {
    /// color components value between 0 to 255
    public convenience init(r: Int, g: Int, b: Int, alpha: CGFloat = 1.0) {
        self.init(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: alpha)
    }
    
    static let fire = UIColor(r: 252, g: 102, b: 3, alpha: 1.0)
    static let lightBlue = UIColor(r: 173, g: 216, b: 230, alpha: 1.0)
    static let lime = UIColor(r: 50, g: 205, b: 50, alpha: 1.0)
    static let pink = UIColor(r: 255, g: 192, b: 203, alpha: 1.0)
    
    static func colorWith(name: String) -> UIColor? {
        switch name {
        case "light_blue":
            return .lightBlue
        case "light_gray":
            return .lightGray
        case "lime":
            return .lime
        case "pink":
            return .pink
        default:
            break
        }
        
        let selector = Selector("\(name)Color")
        if UIColor.self.responds(to: selector) {
            let color = UIColor.self.perform(selector).takeUnretainedValue()
            return (color as? UIColor)
        } else {
            return nil
        }
    }
}
