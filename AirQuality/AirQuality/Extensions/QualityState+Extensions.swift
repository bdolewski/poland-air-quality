//
//  QualityState+Extensions.swift
//  AirQuality
//
//  Created by Dolewski Bartosz A (Ext) on 14/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

extension QualityState {
    var color: UIColor {
        switch self {
        case .veryGood: return Colors.Measurements.veryGood
        case .good: return Colors.Measurements.good
        case .moderate: return Colors.Measurements.moderate
        case .passable: return Colors.Measurements.passable
        case .bad: return Colors.Measurements.bad
        case .veryBad: return Colors.Measurements.veryBad
        case .notAvailable: return Colors.Measurements.notAvailable
        }
    }
}
