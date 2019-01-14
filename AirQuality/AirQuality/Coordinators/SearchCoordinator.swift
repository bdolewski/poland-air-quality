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

class SearchCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    public func start() {
        let searchVC = SearchViewController.instantiate(SearchViewController.self)
        let searchVM = SearchViewModel()
        
        searchVC.viewModel = searchVM
        searchVC.title = NSLocalizedString("search.header", comment: "")
        searchVC.tabBarItem = UITabBarItem(title: NSLocalizedString("tab.search", comment: ""),
                                           image: UIImage(named: "Search")!,
                                           tag: 1)
//        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .search, tag: 1)
        
        self.navigationController.pushViewController(searchVC, animated: false)
    }
}
