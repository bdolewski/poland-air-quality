//
//  UITableViewCell.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 07/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//
import UIKit

//public protocol ConfigurableCell: class {
//    associatedtype Value
//    static var defaultReusableId: String { get }
//    func configureWith(value: Value)
//}

extension UITableViewCell {
    public static var defaultReusableId: String {
        return self.description()
            .components(separatedBy: ".")
            .dropFirst()
            .joined(separator: ".")
    }
}
