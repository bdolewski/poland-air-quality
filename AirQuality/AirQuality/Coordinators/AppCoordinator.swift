//
//  AppCoordinator.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 06/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

class AppCoordinator: Coordinator {
    var rootViewController: UIViewController {
        return tabBarController
    }
    
    var window: UIWindow?
    let childCoordinators: [Coordinator]
    
    lazy var tabBarController: UIViewController = {
        let tabBarController = UITabBarController()
        
        childCoordinators.forEach { $0.start() }
        let viewControllers = childCoordinators.map { $0.rootViewController }
        
        tabBarController.viewControllers = viewControllers
        return tabBarController
    }()
    
    init(window: UIWindow?) {
        self.window = window
        self.childCoordinators = [DisplayCoordinator(), SearchCoordinator(), AboutCoordinator()]
    }
    
    func start() {
        self.window?.makeKeyAndVisible()
        self.window?.rootViewController = self.rootViewController
    }
}

extension AppCoordinator: SearchCoordinatorDelegate {
    func didSelected(station: Station) {
        guard let coordinator = self.childCoordinators.first(where: { $0 is DisplayCoordinator }),
            let displayCoordinator = coordinator as? DisplayCoordinator else { return }
        
        displayCoordinator.updatedStation.accept(station)
    }
}
