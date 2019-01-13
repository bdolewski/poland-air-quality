//
//  SearchCoordinator.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 08/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

struct Station {
    let id: Int
    let cityName: String?
    let address: String?
}

protocol SearchCoordinatorDelegate: AnyObject {
    func didSelected(station: Station)
}

class SearchCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return navigationController
    }
    
    weak var delegate: SearchCoordinatorDelegate?
    
    private var navigationController: UINavigationController
    private let viewController: SearchViewController
    private let disposeBag = DisposeBag()
    
    init() {
        self.navigationController = UINavigationController()
        self.viewController = SearchViewController.instantiate(SearchViewController.self)
    }
    
    public func start() {
        //let searchVC = SearchViewController.instantiate(SearchViewController.self)
        let searchVM = SearchViewModel()
        
        self.viewController.viewModel = searchVM
        self.viewController.title = "Search station"
        self.viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        self.viewController.viewModel?.outputs.dataSource
            .subscribe(onNext: { dataSource in
                print("Got data source in Coordinator: \(dataSource)")
            }).disposed(by: disposeBag)
        
        // bind view model selected model to someone intested in (other coordinator for example)
        self.viewController.viewModel?.outputs.selected
            .do(onNext: { SearchCoordinator.debug(station: $0) })
            .subscribe(onNext: { [weak self] station in
                self?.delegate?.didSelected(station: station) })
            .disposed(by: disposeBag)
        
        self.navigationController.pushViewController(self.viewController, animated: false)
    }
}

extension SearchCoordinator {
    static func debug(station: Station) {
        print(#function, String(describing: self))
        dump(station)
    }
}
