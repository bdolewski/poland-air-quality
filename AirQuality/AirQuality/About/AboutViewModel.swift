//
//  AboutViewModel.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 06/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import Foundation

protocol AboutViewModelInput {
}

protocol AboutViewModelOutput {
}

protocol AboutViewModelType {
    /// Input points of the view model
    var inputs: AboutViewModelInput { get }
    
    /// Output points of the view model
    var outputs: AboutViewModelOutput { get }
}

class AboutViewModel: AboutViewModelInput, AboutViewModelOutput {
    
}

extension AboutViewModel: AboutViewModelType {
    var inputs: AboutViewModelInput { return self }
    var outputs: AboutViewModelOutput { return self }
}
