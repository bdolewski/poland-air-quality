//
//  DisplayCoordinator.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 08/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

class DisplayCoordinator: Coordinator {
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
        
        displayVC.viewModel = displayVM
        displayVC.tabBarItem = UITabBarItem(tabBarSystemItem: .downloads, tag: 0)
        
        self.navigationController.pushViewController(displayVC, animated: false)
    }
}
