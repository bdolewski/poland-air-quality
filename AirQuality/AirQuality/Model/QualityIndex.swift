//
//  QualityIndex.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 12/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import Foundation

struct Quality: Codable {
    let id: Int
    let overallDate: String
    let overall: Level
    
    let so2Date: String?
    let so2: Level?
    
    let no2Date: Int?
    let no2: Level?
    
    let coDate: String?
    let co: Level?
    
    let pm10Date: String?
    let pm10: Level?
    
    let pm25Date: String?
    let pm25: Level?
    
    let o3Date: String?
    let o3: Level?
    
    let c6H6Date: String?
    let c6H6: Level?
    
    enum CodingKeys: String, CodingKey {
        case id          = "id"
        case overallDate = "stCalcDate"
        case overall     = "stIndexLevel"
        case so2Date     = "so2CalcDate"
        case so2         = "so2IndexLevel"
        case no2Date     = "no2CalcDate"
        case no2         = "no2IndexLevel"
        case coDate      = "coCalcDate"
        case co          = "coIndexLevel"
        case pm10Date    = "pm10CalcDate"
        case pm10        = "pm10IndexLevel"
        case pm25Date    = "pm25CalcDate"
        case pm25        = "pm25IndexLevel"
        case o3Date      = "o3CalcDate"
        case o3          = "o3IndexLevel"
        case c6H6Date    = "c6h6CalcDate"
        case c6H6        = "c6h6IndexLevel"
    }
}

enum QualityState: Int, Codable {
    case veryGood = 0
    case good
    case moderate
    case passable
    case bad
    case veryBad
    case notAvailable
    
    init(value: Int) {
        switch value {
        case 0: self = .veryGood
        case 1: self = .good
        case 2: self = .moderate
        case 3: self = .passable
        case 4: self = .bad
        case 5: self = .veryBad
        default: self = .notAvailable
        }
    }
}

struct Level: Codable {
    let state: QualityState
    let friendlyName: String
    
    enum CodingKeys: String, CodingKey {
        case state = "id"
        case friendlyName = "indexLevelName"
    }
}
