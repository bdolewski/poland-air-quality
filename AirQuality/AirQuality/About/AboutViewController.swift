//
//  AboutViewController.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 06/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    @IBOutlet var authorLabel: UILabel!
    @IBOutlet var subtitleLabel: UILabel!
    
    var viewModel: AboutViewModelType?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        authorLabel.text = NSLocalizedString("about.author", comment: "") + "Bartosz Dolewski"
        subtitleLabel.text = "Proof of concept 🛠🤓"
    }
}
