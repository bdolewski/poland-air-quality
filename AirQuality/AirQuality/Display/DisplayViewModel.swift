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
    func generalMeasurements(from stationId: Int)
    func detailedMeasurements(from stationId: Int)
}

protocol DisplayViewModelOutput {
    var generalQuality: BehaviorRelay<String> { get }
    var pm_10Status: BehaviorRelay<String> { get }
    var pm_10Date: BehaviorRelay<String> { get }
    
    var pm_2_5Status: BehaviorRelay<String> { get }
    var pm_2_5Date: BehaviorRelay<String> { get }
}

protocol DisplayViewModelType {
    /// Input points of the view model
    var inputs: DisplayViewModelInput { get }
    
    /// Output points of the view model
    var outputs: DisplayViewModelOutput { get }
}

class DisplayViewModel: DisplayViewModelInput, DisplayViewModelOutput {
    let generalQuality = BehaviorRelay<String>.init(value: "")
    let pm_10Status = BehaviorRelay<String>.init(value: "")
    let pm_10Date = BehaviorRelay<String>.init(value: "")
    
    let pm_2_5Status = BehaviorRelay<String>.init(value: "")
    let pm_2_5Date = BehaviorRelay<String>.init(value: "")
    
    let disposeBag = DisposeBag()
    
    deinit {
        print(#function, String(describing: self))
    }
    
    func generalMeasurements(from stationId: Int) {
        let general = DisplayViewModel.downloadGeneralQuality(stationId: stationId)
                .share()
        general
            .do(onNext: { data in dump(data) })
            .map { $0.stIndexLevel.indexLevelName }
            .bind(to: generalQuality)
            .disposed(by: disposeBag)
    }
    
    func detailedMeasurements(from stationId: Int) {
        let measurements = DisplayViewModel
            .downloadSensors(from: stationId)
            .flatMap { sensors in Observable.from(sensors)}
            .flatMap { DisplayViewModel.downloadMeasurement(from: $0) }
            .toArray()
            .share()
        
        let key_pm10 = measurements
            .map { $0.first(where: { $0.key == Key.pm10 }) }
            .flatMap { Observable.from( optional: $0 ) }
            .do(onNext: { key in print("PM 10: \(key.value)") })
            .share()

        key_pm10
            .map { String("\($0.description)") }
            .bind(to: pm_10Status)
            .disposed(by: disposeBag)
        
        key_pm10
            .map { String("\($0.date)") }
            .bind(to: pm_10Date)
            .disposed(by: disposeBag)
        
        let key_pm2_5 = measurements
            .map { $0.first(where: { $0.key == Key.pm2_5 }) }
            .flatMap { Observable.from( optional: $0 ) }
            .do(onNext: { key in print("PM 2,5: \(key.value)") })
            .share()
        
        key_pm2_5
            .map { String("\($0.description)") }
            .bind(to: pm_2_5Status)
            .disposed(by: disposeBag)
        
        key_pm2_5
            .map { String("\($0.date)") }
            .bind(to: pm_2_5Date)
            .disposed(by: disposeBag)

//        measurements
//            .subscribe(onNext: { measures in
//                measures.forEach { measure in
//                    print("****************")
//                    dump(measure)
//                    print("****************")
//                }
//            })
//            .disposed(by: disposeBag)
        
//        funcA().flatMap{ objects in
//            Observable.from(objects)
//            }
//            .flatMap{ eachObject in
//                funcB(eachObject)
//        }

    }
}

extension DisplayViewModel: DisplayViewModelType {
    var inputs: DisplayViewModelInput { return self }
    var outputs: DisplayViewModelOutput { return self }
}

// MARK: - Functions to get general measurements
extension DisplayViewModel {
    static func downloadGeneralQuality(stationId: Int) -> Observable<QualityIndex> {
        let remote = URL(string: "http://api.gios.gov.pl/pjp-api/rest/aqindex/getIndex/\(stationId)")!
        let request = URLRequest(url: remote)
        
        return URLSession.shared.rx.response(request: request)
            .map { try DisplayViewModel.parseGeneralQuality(data: $1) }
    }
    
    static func parseGeneralQuality(data: Data) throws -> QualityIndex {
        let quality = try JSONDecoder().decode(QualityIndex.self, from: data)
        return quality
    }
}

// MARK: - Functions to get detailed measurements
extension DisplayViewModel {
    static func downloadSensors(from stationId: Int) -> Observable<[Sensor]> {
        let remote = URL(string: "http://api.gios.gov.pl/pjp-api/rest/station/sensors/\(stationId)")!
        let request = URLRequest(url: remote)
        //let request = URLRequest(url: remote, cachePolicy: .returnCacheDataElseLoad)
        
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
//            .catchErrorJustReturn(T##element: Measure##Measure)
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
