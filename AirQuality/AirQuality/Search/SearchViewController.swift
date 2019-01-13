//
//  SearchViewController.swift
//  AirQuality
//
//  Created by Bartosz Dolewski on 07/01/2019.
//  Copyright © 2019 Bartosz Dolewski. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var viewModel: SearchViewModelType?
    let disposeBag = DisposeBag()
    
    deinit {
        print(#function, String(describing: self))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        
        viewModel?.inputs.fetchData()
    }
}

extension SearchViewController {
    func setupTableView() {
        tableView.register(nib: Nib.SearchViewCell)
        tableView.rowHeight = 50.0
        
        // add activity indicator
        let spinner = UIActivityIndicatorView(style: .gray)
        tableView.backgroundView = spinner
        
        // rx bindings
        viewModel?.outputs.dataSource
            //.observeOn(MainScheduler.instance)
            .map { $0.isEmpty }
            .bind(to: spinner.rx.isAnimating)
            .disposed(by: disposeBag)
        
        viewModel?.outputs.dataSource
            .bind(to: tableView.rx.items(cellIdentifier: SearchViewCell.defaultReusableId, cellType: SearchViewCell.self))
            { _, model, cell in
                cell.configure(with: model) }
            .disposed(by: disposeBag)
        
        viewModel?.outputs.selected
            .subscribe(onNext: { station in
                print("Selected: \(station)")
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MeasuringStation.self)
            .subscribe(onNext: { [weak self] station in
                self?.viewModel?.inputs.select(station: station)
            }).disposed(by: disposeBag)
    }
}
