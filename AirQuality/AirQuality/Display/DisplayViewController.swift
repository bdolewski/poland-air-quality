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
        guard let viewModel = self.viewModel else { return }
        
        let qualityStates = [viewModel.outputs.pm_10Status,
                             viewModel.outputs.pm_2_5Status,
                             viewModel.outputs.so2Status,
                             viewModel.outputs.coStatus,
                             viewModel.outputs.o3Status,
                             viewModel.outputs.no2Status,
                             viewModel.outputs.c6H6Status]
        
        let qualityLabels: [UILabel] = [pm10Label,
                                        pm2_5Label,
                                        so2StateLabel,
                                        coStateLabel,
                                        o3StateLabel,
                                        no2StateLabel,
                                        benzeneStateLabel]
        
        zip(qualityStates, qualityLabels).forEach { self.bindStatus(status: $0, label: $1) }
        
        let qualityDates = [viewModel.outputs.pm_10Date,
                            viewModel.outputs.pm_2_5Date,
                            viewModel.outputs.so2Date,
                            viewModel.outputs.coDate,
                            viewModel.outputs.o3Date,
                            viewModel.outputs.no2Date,
                            viewModel.outputs.c6H6Date]
        
        let dateLabels: [UILabel] = [pm10DateLabel,
                                     pm2_5DateLabel,
                                     so2DateLabel,
                                     coDateLabel,
                                     o3DateLabel,
                                     no2DateLabel,
                                     benzeneDateLabel]
        
        zip(qualityDates, dateLabels).forEach { self.bindDate(date: $0, label: $1) }
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
    func bindStatus(status: BehaviorRelay<QualityState>, label: UILabel) {
        status
            .asDriver()
            .map { Labels.measurementQuality(text: DisplayViewController.translate(qualityState: $0), color: $0.color) }
            .drive(label.rx.attributedText)
            .disposed(by: disposeBag)
    }
    
    func bindDate(date: BehaviorRelay<String>, label: UILabel) {
        date
            .asDriver()
            .map(DisplayViewController.formatDate)
            .drive(label.rx.text)
            .disposed(by: disposeBag)
    }
}
