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
    func passStation(station: Station)
}

class SearchCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return navigationController
    }
    
    var delegate: SearchCoordinatorDelegate? {
        didSet {
            print("SearchCoordinatorDelegate is set")
        }
    }
    
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
        self.viewController.delegate = self
        self.viewController.title = "Search station"
        self.viewController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        self.navigationController.pushViewController(self.viewController, animated: false)
    }
}

extension SearchCoordinator: SearchViewControllerDelegate {
    func didSelected(station: Station) {
        if self.delegate == nil {
            print("delegate == nil")
            return
        }
        
        delegate?.passStation(station: station)
        //self.delegate?.didSelected(station: station)
    }
}

extension SearchCoordinator {
    static func debug(station: Station) {
        print(#function, String(describing: self))
        dump(station)
    }
}
