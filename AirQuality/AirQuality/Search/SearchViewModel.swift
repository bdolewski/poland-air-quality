//
//  SearchViewModel.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 07/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

protocol SearchViewModelInput {
    func fetchData()
    func select(station: MeasuringStation)
}

protocol SearchViewModelOutput {
    var dataSource: BehaviorSubject<[MeasuringStation]> { get }
    var selected: ReplaySubject<Station> { get }
}

protocol SearchViewModelType {
    /// Input points of the view model
    var inputs: SearchViewModelInput { get }
    
    /// Output points of the view model
    var outputs: SearchViewModelOutput { get }
}

class SearchViewModel: SearchViewModelInput, SearchViewModelOutput {
    let dataSource = BehaviorSubject<[MeasuringStation]>(value: [])
    let selected = ReplaySubject<Station>.create(bufferSize: 1)
    let disposeBag = DisposeBag()
    
//    init() {
//        selected
//            .subscribe(onNext: { station in
//                print("Selected: \(station)") })
//            .disposed(by: disposeBag)
//    }
    
    deinit {
        print(#function, String(describing: self))
    }
    
    func fetchData() {
        SearchViewModel
            .downloadStations()
            .bind(to: dataSource)
            .disposed(by: disposeBag)
    }
    
    func select(station: MeasuringStation) {
        let simplerStation = Station(id: station.id,
                                     cityName: station.city?.name,
                                     address: station.addressStreet)
        selected.onNext(simplerStation)
    }
}

extension SearchViewModel {
    static func downloadStations() -> Observable<[MeasuringStation]> {
        let remote = URL(string: "http://api.gios.gov.pl/pjp-api/rest/station/findAll")!
        let request = URLRequest(url: remote)
        //let request = URLRequest(url: remote, cachePolicy: .returnCacheDataElseLoad)
        
        return URLSession.shared.rx.response(request: request)
            .map { _, data in return try SearchViewModel.parseJSON(data: data) }
            .catchErrorJustReturn([])
    }
    
    static func parseJSON(data: Data) throws -> [MeasuringStation] {
        let airQualityStations = try JSONDecoder().decode([MeasuringStation].self, from: data)
        return airQualityStations
    }
}

extension SearchViewModel: SearchViewModelType {
    var inputs: SearchViewModelInput { return self }
    var outputs: SearchViewModelOutput { return self }
}
