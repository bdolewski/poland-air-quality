//
//  Coordinator.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 08/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

protocol Coordinator: class {
    var rootViewController: UIViewController { get }
    func start()
}
