//
//  UITableView+Extension.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 07/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

public extension UITableView {
    func register(nib: Nib) {
        self.register(UINib(nibName: nib.rawValue, bundle: Bundle.main), forCellReuseIdentifier: nib.rawValue)
    }
}
