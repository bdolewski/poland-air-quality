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
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindGeneral()
        bindDetails()
        
        viewModel?.inputs.generalMeasurements(from: 117)
        viewModel?.inputs.detailedMeasurements(from: 117)
    }
    
    deinit {
        print(#function, String(describing: self))
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
        
        viewModel.outputs.generalQuality
            .asDriver()
            .drive(generalQualityLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindDetails() {
        guard let viewModel = self.viewModel else { return }
        
        Observable.combineLatest(viewModel.outputs.pm_10Status,
                                 viewModel.outputs.pm_10Date) { "PM10: " + DisplayViewController.formatLabel(status: $0, date: $1) }
            .asDriver(onErrorJustReturn: "")
            .drive(pm10Label.rx.text)
            .disposed(by: disposeBag)
        
        Observable.combineLatest(viewModel.outputs.pm_2_5Status,
                                 viewModel.outputs.pm_2_5Date) { "PM 2,5: " + DisplayViewController.formatLabel(status: $0, date: $1) }
            .asDriver(onErrorJustReturn: "")
            .drive(pm2_5Label.rx.text)
            .disposed(by: disposeBag)
    }
}

extension DisplayViewController {
    static func formatLabel(status: String, date: String) -> String {
        return status + " (" + date + ")"
    }
}
