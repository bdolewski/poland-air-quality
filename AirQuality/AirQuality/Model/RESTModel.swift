//
//  RESTModel.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 08/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import Foundation

struct MeasuringStation: Decodable {
    let id: Int
    let stationName: String
    let gegrLat: String
    let gegrLon: String
    let city: City?
    let addressStreet: String?
}

struct Sensor: Decodable {
    let id: Int
    let stationId: Int
}

struct City: Decodable {
    let id: Int
    let name: String
    let commune: Commune
}

struct Commune: Decodable {
    let communeName: String
    let districtName: String
    let provinceName: String
}
