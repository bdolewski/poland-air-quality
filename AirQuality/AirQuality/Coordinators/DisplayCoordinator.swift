//
//  DisplayCoordinator.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 08/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class DisplayCoordinator: Coordinator {
    let updatedStation = BehaviorRelay<Station?>(value: nil)
    let disposeBag = DisposeBag()
    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    public func start() {
        let displayVC = DisplayViewController.instantiate(DisplayViewController.self)
        let displayVM = DisplayViewModel()
        
        updatedStation
            .do(onNext: { DisplayCoordinator.debug(station: $0) })
            .flatMap { Observable.from( optional: $0 ) }
            .subscribe(onNext: { [weak displayVM] station in
                displayVM?.inputs.city(named: station.cityName)
                displayVM?.inputs.street(address: station.address)
                displayVM?.inputs.generalMeasurements(from: station.id)
                displayVM?.inputs.detailedMeasurements(from: station.id) })
            .disposed(by: disposeBag)
        
        displayVC.viewModel = displayVM
        displayVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        self.navigationController.pushViewController(displayVC, animated: false)
    }
}

extension DisplayCoordinator {
    static func debug(station: Station?) {
        print(#function, String(describing: self))
        dump(station)
    }
}
