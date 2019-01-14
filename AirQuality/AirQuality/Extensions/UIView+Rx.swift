//
//  UIView+Rx.swift
//  AirQuality
//
//  Created by Dolewski Bartosz A (Ext) on 14/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

#if os(iOS) || os(tvOS)

import UIKit
import RxSwift
import RxCocoa

extension Reactive where Base: UIView {

    /// Bindable sink for `alpha` property.
    public var backgroundColor: Binder<UIColor> {
        return Binder(self.base) { view, backgroundColor in
            view.backgroundColor = backgroundColor
        }
    }
}

#endif
