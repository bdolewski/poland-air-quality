//
//  UIViewController+Extensions.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 06/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

public extension UIViewController {
    
    static var defaultNib: String {
        return self.description().components(separatedBy: ".").dropFirst().joined(separator: ".")
    }
    
    static func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {
        return Nib(rawValue: VC.defaultNib)!.instantiate(VC.self)
    }
}
