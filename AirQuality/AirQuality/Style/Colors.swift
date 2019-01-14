//
//  Colors.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 14/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

struct Colors {
    struct Backgrounds {
        static let veryGood = UIColor(red: 0.89, green: 0.99, blue: 0.79, alpha: 1.0)
        static let good = UIColor(red: 0.91, green: 0.98, blue: 0.67, alpha: 1.0)
        static let moderate = UIColor(red: 1.00, green: 0.95, blue: 0.66, alpha: 1.0)
        static let passable = UIColor(red: 1.00, green: 0.84, blue: 0.63, alpha: 1.0)
        static let bad = UIColor(red: 1.00, green: 0.63, blue: 0.63, alpha: 1.0)
        static let veryBad = UIColor(red: 0.98, green: 0.67, blue: 0.69, alpha: 1.0)
        static let notAvailable = UIColor(red: 0.45, green: 0.45, blue: 0.45, alpha: 1.0)
    }
    
    struct Measurements {
        static let veryGood = UIColor(red: 0.35, green: 0.69, blue: 0.02, alpha: 1.0)
        static let good = UIColor(red: 0.69, green: 0.87, blue: 0.05, alpha: 1.0)
        static let moderate = UIColor(red: 1.00, green: 0.85, blue: 0.06, alpha: 1.0)
        static let passable = UIColor(red: 0.90, green: 0.51, blue: 0.00, alpha: 1.0)
        static let bad = UIColor(red:0.90, green:0.00, blue:0.00, alpha:1.0)
        static let veryBad = UIColor(red: 0.60, green: 0.00, blue: 0.00, alpha: 1.0)
        static let notAvailable = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
    }
    
    static let black = UIColor(red: 0.07, green: 0.07, blue: 0.07, alpha: 1.0)
    
    static func toBackgroundColor(quality: QualityState) -> UIColor {
        switch quality {
        case .veryGood: return Colors.Backgrounds.veryGood
        case .good: return Colors.Backgrounds.good
        case .moderate: return Colors.Backgrounds.moderate
        case .passable: return Colors.Backgrounds.passable
        case .bad: return Colors.Backgrounds.bad
        case .veryBad: return Colors.Backgrounds.veryBad
        case .notAvailable: return Colors.Backgrounds.notAvailable
        }
    }
}


