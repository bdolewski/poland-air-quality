//
//  Labels.swift
//  AirQuality
//
//  Created by Dolewski Bartosz A (Ext) on 14/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit
import HandyUIKit

enum Font: String {
    case helveticaNeue = "HelveticaNeue"
    case helveticaNeueBold = "HelveticaNeue-Bold"
    case helveticaNeueMedium = "HelveticaNeue-Medium"
}

extension Font: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}

struct Labels {
    static func streetAddress(text: String) -> NSAttributedString {
        let font = UIFont(name: Font.helveticaNeueMedium.description, size: 17.0)!
        return NSAttributedString(string: text, attributes: [.font: font])
    }
    
    static func overall(text: String, color: UIColor) -> NSAttributedString {
        let font = UIFont(name: Font.helveticaNeueBold.description, size: 45.0)!
        let attributes: [NSAttributedString.Key : Any] = [
            .font: font,
            .foregroundColor: color
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    static func measurementQuality(text: String, color: UIColor) -> NSAttributedString {
        let font = UIFont(name: Font.helveticaNeue.description, size: 17.0)!
        let attributes: [NSAttributedString.Key : Any] = [
            .font: font,
            .foregroundColor: color
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    static var textForPM10: NSAttributedString {
        let font = UIFont(name: Font.helveticaNeueBold.description, size: 17.0)!
        return NSAttributedString(string: "PM 10:", attributes: [.font: font])
    }
    
    static var textForPM25: NSAttributedString {
        let font = UIFont(name: Font.helveticaNeueBold.description, size: 17.0)!
        return NSAttributedString(string: "PM 2,5:", attributes: [.font: font])
    }
    
    static var textForSO2: NSAttributedString {
        let font = UIFont(name: Font.helveticaNeueBold.description, size: 17.0)!
        return "SO_{2}:".subscripted(font: font)
    }

    static var textForCO: NSAttributedString {
        let font = UIFont(name: Font.helveticaNeueBold.description, size: 17.0)!
        return NSAttributedString(string: "CO:", attributes: [.font: font])
    }
    
    static var textForO3: NSAttributedString {
        let font = UIFont(name: Font.helveticaNeueBold.description, size: 17.0)!
        return "O_{3}:".subscripted(font: font)
    }
    
    static var textForNO2: NSAttributedString {
        let font = UIFont(name: Font.helveticaNeueBold.description, size: 17.0)!
        return "NO_{2}:".subscripted(font: font)
    }
    
    static var textForBenzene: NSAttributedString {
        let font = UIFont(name: Font.helveticaNeueBold.description, size: 17.0)!
        return "C_{6}H_{6}:".subscripted(font: font)
    }
}
