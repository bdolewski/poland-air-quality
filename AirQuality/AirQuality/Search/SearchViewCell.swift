//
//  SearchViewCell.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 07/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

class SearchViewCell: UITableViewCell {
    @IBOutlet var streeLabel: UILabel!
    @IBOutlet var cityLabel: UILabel!
    
    deinit {
        print(#function, String(describing: self))
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure(with model: MeasuringStation) {
        self.streeLabel.text = model.addressStreet ?? "No street"
        self.cityLabel.text = model.city?.name ?? "No city"
    }
}
