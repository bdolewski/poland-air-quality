//
//  Measure.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 08/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

enum MeasureError: Error {
    case noKey
    case emptyValueList
}

struct Measure: Decodable {
    let key: Key
    let value: Double
    let date: String
    
    init(from decoder: Decoder) throws {
        let rawResponse = try! RawResponse(from: decoder)
        
        guard let key = Key(rawValue: rawResponse.key) else { throw MeasureError.noKey }
        
        guard let rawValues = rawResponse.values.first(where: { $0.value != nil }),
            let value = rawValues.value else { throw MeasureError.emptyValueList }
        
        self.key = key
        self.value = value
        self.date = rawValues.date
    }
    
    var description: MeasurementDescription {
        let bounds = key.boundaries
        
        switch value {
        case 0..<bounds.veryGood: return .veryGood
        case bounds.veryGood..<bounds.good: return .good
        case bounds.good..<bounds.moderate: return .moderate
        case bounds.moderate..<bounds.passable: return .passable
        case bounds.passable..<bounds.bad: return .bad
        default: return .veryBad
        }
    }
    
    private struct RawResponse: Decodable {
        let key: String
        let values: [RawValue]
        
        struct RawValue: Decodable {
            let date: String
            let value: Double?
        }
    }
}
