//
//  Labels.swift
//  AirQuality
//
//  Created by Dolewski Bartosz A (Ext) on 14/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

enum Font: String {
    case helveticaNeue = "HelveticaNeue"
    case helveticaNeueBold = "HelveticaNeue-Bold"
}

extension Font: CustomStringConvertible {
    var description: String {
        return self.rawValue
    }
}

struct Labels {
    static func overall(text: String, color: UIColor) -> NSAttributedString {
        let font = UIFont(name: Font.helveticaNeueBold.description, size: 45.0)
        let attributes: [NSAttributedString.Key : Any] = [
            .font: font as Any,
            .foregroundColor: color
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
    
    static func measurementQuality(text: String, color: UIColor) -> NSAttributedString {
        let font = UIFont(name: Font.helveticaNeue.description, size: 17.0)
        let attributes: [NSAttributedString.Key : Any] = [
            .font: font as Any,
            .foregroundColor: color
        ]
        
        return NSAttributedString(string: text, attributes: attributes)
    }
}
