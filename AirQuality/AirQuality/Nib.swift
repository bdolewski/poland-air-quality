//
//  Nib.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 06/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

public enum Nib: String {
    // View controllers
    case AboutViewController
    case DisplayViewController
    case SearchViewController
    
    // Cells
    case SearchViewCell
}

extension Nib {
    public func instantiate<VC: UIViewController>(_ viewController: VC.Type) -> VC {
        let vc = VC.init(nibName: self.rawValue, bundle: Bundle.main)
        return vc
    }
    
//    public func instantiate<V: UIView>(_ view: V.Type, inBundle bundle: Bundle = .framework) -> V {
//        return bundle.loadNibNamed(self.rawValue, owner: nil, options: nil)!.first as! V
//    }
}
