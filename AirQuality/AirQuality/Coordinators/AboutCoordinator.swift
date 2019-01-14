//
//  AboutCoordinator.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 08/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

class AboutCoordinator: Coordinator {    
    var rootViewController: UIViewController {
        return navigationController
    }
    
    private var navigationController: UINavigationController
    
    init() {
        self.navigationController = UINavigationController()
    }
    
    public func start() {
        let aboutVC = AboutViewController.instantiate(AboutViewController.self)
        let aboutVM = AboutViewModel()
        
        aboutVC.viewModel = aboutVM
        aboutVC.title = NSLocalizedString("about.header", comment: "")
        aboutVC.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 1)
        
        self.navigationController.pushViewController(aboutVC, animated: false)
    }
}
