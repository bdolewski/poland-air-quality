//
//  UserDefaults+Extension.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 13/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import Foundation

extension UserDefaults {
    static var stationIdKey: String {
        return "currentStationID"
    }
    
    static var cityKey: String {
        return "currentCityName"
    }
    
    static var addressKey: String {
        return "currentAddress"
    }
    
    func store(station: Station) {
        self.set(station.id, forKey: UserDefaults.stationIdKey)
        self.set(station.cityName, forKey: UserDefaults.cityKey)
        self.set(station.address, forKey: UserDefaults.addressKey)
        //self.set(try? PropertyListEncoder().encode(station), forKey: UserDefaults.stationKey)
    }
    
    func fetch() -> Station? {
        guard let id = self.value(forKey: UserDefaults.stationIdKey) as? Int,
            let city = self.value(forKey: UserDefaults.cityKey) as? String?,
            let address = self.value(forKey: UserDefaults.addressKey) as? String? else { return nil }
        
        return Station(id: id, cityName: city, address: address)
        //guard let data = self.value(forKey: UserDefaults.stationKey) as? Data else { return nil }
        //return try? PropertyListDecoder().decode(Station.self, from: data)
    }
}
