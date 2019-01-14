//
//  DisplayViewModel.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 07/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol DisplayViewModelInput {
    func generalMeasurements()
    func detailedMeasurements()
}

protocol DisplayViewModelOutput {
    var availableInStorage: BehaviorRelay<Bool> { get }
    
    var overallState: BehaviorRelay<QualityState> { get }
    var overallDate: BehaviorRelay<String> { get }
    
    var pm_10Status: BehaviorRelay<QualityState> { get }
    var pm_10Date: BehaviorRelay<String> { get }
    
    var pm_2_5Status: BehaviorRelay<QualityState> { get }
    var pm_2_5Date: BehaviorRelay<String> { get }
    
    var no2Status: BehaviorRelay<QualityState> { get }
    var no2Date: BehaviorRelay<String> { get }
    
    var so2Status: BehaviorRelay<QualityState> { get }
    var so2Date: BehaviorRelay<String> { get }
    
    var coStatus: BehaviorRelay<QualityState> { get }
    var coDate: BehaviorRelay<String> { get }
    
    var o3Status: BehaviorRelay<QualityState> { get }
    var o3Date: BehaviorRelay<String> { get }
    
    var c6H6Status: BehaviorRelay<QualityState> { get }
    var c6H6Date: BehaviorRelay<String> { get }
    
    var cityName: BehaviorRelay<String> { get }
    var streetAddres: BehaviorRelay<String> { get }
}

protocol DisplayViewModelType {
    /// Input points of the view model
    var inputs: DisplayViewModelInput { get }
    
    /// Output points of the view model
    var outputs: DisplayViewModelOutput { get }
}

struct DisplayViewModelConfig {
    static let noData = ""
    static let noCityName = String("No city")
    static let noStreetName = String("No street address")
}


class DisplayViewModel: DisplayViewModelInput, DisplayViewModelOutput {
    let availableInStorage = BehaviorRelay<Bool>.init(value: false)
    
    let overallState = BehaviorRelay<QualityState>.init(value: .notAvailable)
    let overallDate = BehaviorRelay<String>.init(value: DisplayViewModelConfig.noData)
    
    let pm_10Status = BehaviorRelay<QualityState>.init(value: .notAvailable)
    let pm_10Date = BehaviorRelay<String>.init(value: DisplayViewModelConfig.noData)
    
    let pm_2_5Status = BehaviorRelay<QualityState>.init(value: .notAvailable)
    let pm_2_5Date = BehaviorRelay<String>.init(value: DisplayViewModelConfig.noData)
    
    let no2Status = BehaviorRelay<QualityState>.init(value: .notAvailable)
    let no2Date = BehaviorRelay<String>.init(value: DisplayViewModelConfig.noData)
    
    let so2Status = BehaviorRelay<QualityState>.init(value: .notAvailable)
    let so2Date = BehaviorRelay<String>.init(value: DisplayViewModelConfig.noData)
    
    let coStatus = BehaviorRelay<QualityState>.init(value: .notAvailable)
    let coDate = BehaviorRelay<String>.init(value: DisplayViewModelConfig.noData)
    
    let o3Status = BehaviorRelay<QualityState>.init(value: .notAvailable)
    let o3Date = BehaviorRelay<String>.init(value: DisplayViewModelConfig.noData)
    
    let c6H6Status = BehaviorRelay<QualityState>.init(value: .notAvailable)
    let c6H6Date = BehaviorRelay<String>.init(value: DisplayViewModelConfig.noData)
    
    var cityName = BehaviorRelay<String>.init(value: DisplayViewModelConfig.noData)
    var streetAddres = BehaviorRelay<String>.init(value: DisplayViewModelConfig.noData)
    
    private let disposeBag = DisposeBag()
    private let storage = UserDefaults.standard
    
    init() {
        storage.rx
            .observe(Int.self, UserDefaults.stationIdKey)
            .map { $0 != nil }
            .bind(to: availableInStorage)
            .disposed(by: disposeBag)
        
        storage.rx
            .observe(String.self, UserDefaults.cityKey)
            .map { $0 ?? DisplayViewModelConfig.noData }
            .bind(to: cityName)
            .disposed(by: disposeBag)
        
        storage.rx
            .observe(String.self, UserDefaults.addressKey)
            .map { $0 ?? DisplayViewModelConfig.noData }
            .bind(to: streetAddres)
            .disposed(by: disposeBag)
    }
    
    deinit {
        print(#function, String(describing: self))
    }
    
    func generalMeasurements() {
        guard let storage = storage.fetch() else { return }
        
        let general = DisplayViewModel.downloadGeneralQuality(stationId: storage.id)
                .share()
        general
//            .do(onNext: { data in
//                dump(data)
//                print("*************")
//            })
            .map { $0.overall.state }
            .catchErrorJustReturn(.notAvailable)
            .bind(to: overallState)
            .disposed(by: disposeBag)
        
        general
            .map { $0.overallDate }
            .catchErrorJustReturn(DisplayViewModelConfig.noData)
            .bind(to: overallDate)
            .disposed(by: disposeBag)
        
        //PM10 - status & calculation date
        general
            .map { $0.pm10?.state ?? .notAvailable }
            .catchErrorJustReturn(.notAvailable)
            .bind(to: pm_10Status)
            .disposed(by: disposeBag)
        
        general
            .map { $0.pm10Date ?? DisplayViewModelConfig.noData }
            .catchErrorJustReturn(DisplayViewModelConfig.noData)
            .bind(to: pm_10Date)
            .disposed(by: disposeBag)
        
        //PM2,5 - status & calculation date
        general
            .map { $0.pm25?.state ?? .notAvailable }
            .catchErrorJustReturn(.notAvailable)
            .bind(to: pm_2_5Status)
            .disposed(by: disposeBag)
        
        general
            .map { $0.pm25Date ?? DisplayViewModelConfig.noData }
            .catchErrorJustReturn(DisplayViewModelConfig.noData)
            .bind(to: pm_2_5Date)
            .disposed(by: disposeBag)
   
        //NO2 - status & calculation date
        general
            .map { $0.no2?.state ?? .notAvailable }
            .catchErrorJustReturn(.notAvailable)
            .bind(to: no2Status)
            .disposed(by: disposeBag)
        
        //There is something seriously wrong on back-end with date format for NO2
        //Should be String like everything else, but we got some jibberish Int value like 1547450437000
        //Instead - use date from overall measurement
        overallDate
            .bind(to: no2Date)
            .disposed(by: disposeBag)
        
        //SO2 - status & calculation date
        general
            .map { $0.so2?.state ?? .notAvailable }
            .catchErrorJustReturn(.notAvailable)
            .bind(to: so2Status)
            .disposed(by: disposeBag)
        
        general
            .map { $0.so2Date ?? DisplayViewModelConfig.noData }
            .catchErrorJustReturn(DisplayViewModelConfig.noData)
            .bind(to: so2Date)
            .disposed(by: disposeBag)
        
        //CO - status & calculation date
        general
            .map { $0.co?.state ?? .notAvailable }
            .catchErrorJustReturn(.notAvailable)
            .bind(to: coStatus)
            .disposed(by: disposeBag)
        
        general
            .map { $0.coDate ?? DisplayViewModelConfig.noData }
            .catchErrorJustReturn(DisplayViewModelConfig.noData)
            .bind(to: coDate)
            .disposed(by: disposeBag)
        
        //O3 - status & calculation date
        general
            .map { $0.o3?.state ?? .notAvailable }
            .catchErrorJustReturn(.notAvailable)
            .bind(to: o3Status)
            .disposed(by: disposeBag)
        
        general
            .map { $0.o3Date ?? DisplayViewModelConfig.noData }
            .catchErrorJustReturn(DisplayViewModelConfig.noData)
            .bind(to: o3Date)
            .disposed(by: disposeBag)
        
        //C6H6 - status & calculation date
        general
            .map { $0.c6H6?.state ?? .notAvailable }
            .catchErrorJustReturn(.notAvailable)
            .bind(to: c6H6Status)
            .disposed(by: disposeBag)
        
        general
            .map { $0.c6H6Date ?? DisplayViewModelConfig.noData }
            .catchErrorJustReturn(DisplayViewModelConfig.noData)
            .bind(to: c6H6Date)
            .disposed(by: disposeBag)
    }
    
    func detailedMeasurements() {
        //guard let storage = storage.fetch() else { return }
        
//        let measurements = DisplayViewModel
//            .downloadSensors(from: storage.id)
//            .flatMap { sensors in Observable.from(sensors)}
//            .flatMap { DisplayViewModel.downloadMeasurement(from: $0) }
//            .toArray()
//            .share()
        
//        let key_pm10 = measurements
//            .map { $0.first(where: { $0.key == Key.pm10 }) }
//            .flatMap { Observable.from( optional: $0 ) }
//            .do(onNext: { key in print("PM 10: \(key.value)") })
//            .share()

//        key_pm10
//            .map { String("\($0.description)") }
//            .catchErrorJustReturn("")
//            .bind(to: pm_10Status)
//            .disposed(by: disposeBag)
//
//        key_pm10
//            .map { String("\($0.date)") }
//            .catchErrorJustReturn("")
//            .bind(to: pm_10Date)
//            .disposed(by: disposeBag)
//
//        let key_pm2_5 = measurements
//            .map { $0.first(where: { $0.key == Key.pm2_5 }) }
//            .flatMap { Observable.from( optional: $0 ) }
//            .do(onNext: { key in print("PM 2,5: \(key.value)") })
//            .share()
        
//        key_pm2_5
//            .map { String("\($0.description)") }
//            .bind(to: pm_2_5Status)
//            .disposed(by: disposeBag)
        
//        key_pm2_5
//            .map { String("\($0.date)") }
//            .bind(to: pm_2_5Date)
//            .disposed(by: disposeBag)
    }
}

extension DisplayViewModel: DisplayViewModelType {
    var inputs: DisplayViewModelInput { return self }
    var outputs: DisplayViewModelOutput { return self }
}

// MARK: - Functions to get general measurements
extension DisplayViewModel {
    static func downloadGeneralQuality(stationId: Int) -> Observable<Quality> {
        let remote = URL(string: "http://api.gios.gov.pl/pjp-api/rest/aqindex/getIndex/\(stationId)")!
        let request = URLRequest(url: remote)
        
        return URLSession.shared.rx.response(request: request)
            .map { try DisplayViewModel.parseGeneralQuality(data: $1) }
    }
    
    static func parseGeneralQuality(data: Data) throws -> Quality {
        let quality = try JSONDecoder().decode(Quality.self, from: data)
        return quality
    }
}

// MARK: - Functions to get detailed measurements
extension DisplayViewModel {
    static func downloadSensors(from stationId: Int) -> Observable<[Sensor]> {
        let remote = URL(string: "http://api.gios.gov.pl/pjp-api/rest/station/sensors/\(stationId)")!
        let request = URLRequest(url: remote)
        
        return URLSession.shared.rx.response(request: request)
            .map { _, data in return try DisplayViewModel.parseSensors(data: data) }
            .catchErrorJustReturn([])
    }
    
    static func downloadMeasurement(from sensor: Sensor) -> Observable<Measure> {
        let sensorId = sensor.id
        let remote = URL(string: "http://api.gios.gov.pl/pjp-api/rest/data/getData/\(sensorId)")!
        let request = URLRequest(url: remote)
        
        return URLSession.shared.rx.response(request: request)
            .map { _, data in return try DisplayViewModel.parseMeasurement(data: data) }
    }
    
    static func parseSensors(data: Data) throws -> [Sensor] {
        let sensors = try JSONDecoder().decode([Sensor].self, from: data)
        return sensors
    }
    
    static func parseMeasurement(data: Data) throws -> Measure {
        let measure = try JSONDecoder().decode(Measure.self, from: data)
        return measure
    }
}
