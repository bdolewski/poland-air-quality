//
//  Colors.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 14/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

struct Colors {
    struct Measurements {
        static let veryGood = UIColor(red: 0.35, green: 0.69, blue: 0.02, alpha: 1.0)
        static let good = UIColor(red: 0.69, green: 0.87, blue: 0.05, alpha: 1.0)
        static let moderate = UIColor(red: 1.00, green: 0.85, blue: 0.06, alpha: 1.0)
        static let passable = UIColor(red: 0.90, green: 0.51, blue: 0.00, alpha: 1.0)
        static let bad = UIColor(red:0.90, green:0.00, blue:0.00, alpha:1.0)
        static let veryBad = UIColor(red: 0.60, green: 0.00, blue: 0.00, alpha: 1.0)
        static let notAvailable = UIColor(red: 0.75, green: 0.75, blue: 0.75, alpha: 1.0)
    }
}
