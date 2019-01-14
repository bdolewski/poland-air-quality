//
//  DisplayViewController.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 07/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DisplayViewController: UIViewController {
    @IBOutlet var generalQualityLabel: UILabel!
    @IBOutlet var stationAddressLabel: UILabel!
    @IBOutlet var pm10Label: UILabel!
    @IBOutlet var pm2_5Label: UILabel!
    
    var viewModel: DisplayViewModelType?
    
    private let disposeBag = DisposeBag()
    
    deinit {
        print(#function, String(describing: self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindGeneral()
        bindDetails()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        viewModel?.inputs.fetchMeasurements()
    }
}

extension DisplayViewController {
    func bindGeneral() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.outputs.cityName
            .asDriver()
            .drive(self.rx.title)
            .disposed(by: disposeBag)
        
        viewModel.outputs.streetAddres
            .asDriver()
            .drive(stationAddressLabel.rx.text)
            .disposed(by: disposeBag)
        
        viewModel.outputs.overallState
            .asDriver()
            .map(DisplayViewController.translate)
            .drive(generalQualityLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindDetails() {
        guard let viewModel = self.viewModel else { return }
        
        let pm10Status = viewModel.outputs.pm_10Status
            .map(DisplayViewController.translate)
        
        Observable.combineLatest(pm10Status,
                                 viewModel.outputs.pm_10Date) { "PM10: " + DisplayViewController.formatLabel(status: $0, date: $1) }
            .asDriver(onErrorJustReturn: "")
            .drive(pm10Label.rx.text)
            .disposed(by: disposeBag)
        
        let pm25Status = viewModel.outputs.pm_2_5Status
            .map(DisplayViewController.translate)
        
        Observable.combineLatest(pm25Status,
                                 viewModel.outputs.pm_2_5Date) { "PM 2,5: " + DisplayViewController.formatLabel(status: $0, date: $1) }
            .asDriver(onErrorJustReturn: "")
            .drive(pm2_5Label.rx.text)
            .disposed(by: disposeBag)
    }
}

extension DisplayViewController {
    static func translate(qualityState: QualityState) -> String {
        switch qualityState {
        case .veryGood:
            return "Bardzo dobra"
        case .good:
            return "Dobra"
        case .moderate:
            return "Umiarkowana"
        case .passable:
            return "Dostateczna"
        case .bad:
            return "Zła"
        case .veryBad:
            return "Bardzo zła"
        case .notAvailable:
            return "Brak danych"
        }
    }
    
    static func formatLabel(status: String, date: String) -> String {
        let formattedDate = date.isEmpty ? date : String(" (" + date + ")")
        return status + formattedDate
    }
}
