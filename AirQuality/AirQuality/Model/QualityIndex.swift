//
//  QualityIndex.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 12/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import Foundation

struct QualityIndex: Codable {
    let id: Int
    let stCalcDate: String
    let stIndexLevel: IndexLevel
    
    struct IndexLevel: Codable {
        let id: Int
        let indexLevelName: String
    }
}
