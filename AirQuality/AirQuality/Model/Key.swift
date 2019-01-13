//
//  Key.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 08/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import Foundation

enum Key: String, Decodable {
    case pm10  = "PM10"
    case pm2_5 = "PM2.5"
    case co    = "CO"
    case no2   = "NO2"
    case o3    = "O3"
    case so2   = "SO2"
    case c6h6  = "C6H6"
}

extension Key {
    var boundaries: (veryGood: Double, good: Double, moderate: Double, passable: Double, bad: Double) {
        switch self {
        case .pm10:  return (21.0, 61.0,  101.0, 141.0, 201.0)
        case .pm2_5: return (13.0, 37.0,  61.0,  85.0,  121.0)
        case .o3:    return (71.0, 121.0, 151.0, 181.0, 241.0)
        case .no2:   return (41.0, 101.0, 151.0, 201.0, 401.0)
        case .so2:   return (51.0, 101.0, 201.0, 351.0, 501.0)
        case .c6h6:  return (6.0,  11.0,  16.0,  21.0,  51.0)
        case .co:    return (3.0,  7.0,   11.0,  15.0,  21.0)
        }
    }
}

extension Key: CustomStringConvertible {
    var description: String {
        return rawValue
    }
}
