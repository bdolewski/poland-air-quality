//
//  SearchCoordinator.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 08/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

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
        searchVC.title = "Search station"
        searchVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        self.navigationController.pushViewController(searchVC, animated: false)
    }
}
