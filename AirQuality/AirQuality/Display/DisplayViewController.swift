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
    @IBOutlet var pm10DateLabel: UILabel!
    
    @IBOutlet var pm2_5Label: UILabel!
    @IBOutlet var pm2_5DateLabel: UILabel!
    
    @IBOutlet var so2StateLabel: UILabel!
    @IBOutlet var so2DateLabel: UILabel!
    
    @IBOutlet var coStateLabel: UILabel!
    @IBOutlet var coDateLabel: UILabel!
    
    @IBOutlet var o3StateLabel: UILabel!
    @IBOutlet var o3DateLabel: UILabel!
    
    @IBOutlet var no2StateLabel: UILabel!
    @IBOutlet var no2DateLabel: UILabel!
    
    @IBOutlet var benzeneStateLabel: UILabel!
    @IBOutlet var benzeneDateLabel: UILabel!
    
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
            .map { Labels.overall(text: DisplayViewController.translate(qualityState: $0), color: $0.color) }
            .drive(generalQualityLabel.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    func bindDetails() {
        bindPM10()
        bindPM25()
        bindSO2()
        bindCO()
        bindO3()
        bindNO2()
        bindBenzene()
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
    
    static func formatDate(date: String) -> String {
        let formattedDate = date.isEmpty ? date : String(" (" + date + ")")
        return formattedDate
    }
}

private extension DisplayViewController {
    func bindPM10() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.outputs.pm_10Status
            .asDriver()
            .map { Labels.measurementQuality(text: DisplayViewController.translate(qualityState: $0), color: $0.color) }
            .drive(pm10Label.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.outputs.pm_10Date
            .asDriver()
            .map(DisplayViewController.formatDate)
            .drive(pm10DateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindPM25() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.outputs.pm_2_5Status
            .asDriver()
            .map { Labels.measurementQuality(text: DisplayViewController.translate(qualityState: $0), color: $0.color) }
            .drive(pm2_5Label.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.outputs.pm_2_5Date
            .asDriver()
            .map(DisplayViewController.formatDate)
            .drive(pm2_5DateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindSO2() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.outputs.so2Status
            .asDriver()
            .map { Labels.measurementQuality(text: DisplayViewController.translate(qualityState: $0), color: $0.color) }
            .drive(so2StateLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.outputs.so2Date
            .asDriver()
            .map(DisplayViewController.formatDate)
            .drive(so2DateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindCO() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.outputs.coStatus
            .asDriver()
            .map { Labels.measurementQuality(text: DisplayViewController.translate(qualityState: $0), color: $0.color) }
            .drive(coStateLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.outputs.coDate
            .asDriver()
            .map(DisplayViewController.formatDate)
            .drive(coDateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindO3() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.outputs.o3Status
            .asDriver()
            .map { Labels.measurementQuality(text: DisplayViewController.translate(qualityState: $0), color: $0.color) }
            .drive(o3StateLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.outputs.o3Date
            .asDriver()
            .map(DisplayViewController.formatDate)
            .drive(o3DateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindNO2() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.outputs.no2Status
            .asDriver()
            .map { Labels.measurementQuality(text: DisplayViewController.translate(qualityState: $0), color: $0.color) }
            .drive(no2StateLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.outputs.no2Date
            .asDriver()
            .map(DisplayViewController.formatDate)
            .drive(no2DateLabel.rx.text)
            .disposed(by: disposeBag)
    }
    
    func bindBenzene() {
        guard let viewModel = self.viewModel else { return }
        
        viewModel.outputs.c6H6Status
            .asDriver()
            .map { Labels.measurementQuality(text: DisplayViewController.translate(qualityState: $0), color: $0.color) }
            .drive(benzeneStateLabel.rx.attributedText)
            .disposed(by: disposeBag)
        
        viewModel.outputs.c6H6Date
            .asDriver()
            .map(DisplayViewController.formatDate)
            .drive(benzeneDateLabel.rx.text)
            .disposed(by: disposeBag)
    }
}
