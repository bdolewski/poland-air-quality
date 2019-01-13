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

protocol SearchViewControllerDelegate {
    func didSelected(station: Station)
}

class SearchViewController: UIViewController {
    @IBOutlet var tableView: UITableView!
    
    var viewModel: SearchViewModelType?
    var delegate: SearchViewControllerDelegate?
    
    private let disposeBag = DisposeBag()
    private let storage = UserDefaults.standard
    
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
        
        viewModel?.outputs.dataSource
            .observeOn(MainScheduler.instance)
            .skip(1)
            .take(1)
            .withLatestFrom(Observable.just(storage.fetch())) { fetchedOnline, storage -> Int? in
                guard let storage = storage else { return nil }
                return fetchedOnline.firstIndex(where: { $0.id == storage.id }) }
            .subscribe(onNext: { [weak self] row in
                guard let row = row else { return }
                self?.tableView.selectRow(at: IndexPath(row: row, section: 0), animated: true, scrollPosition: .middle) })
            .disposed(by: disposeBag)

        viewModel?.outputs.selected
            .subscribe(onNext: { [weak self] station in
                self?.delegate?.didSelected(station: station)
            })
            .disposed(by: disposeBag)
        
        tableView.rx.modelSelected(MeasuringStation.self)
            .subscribe(onNext: { [weak self] station in
                self?.viewModel?.inputs.select(station: station)
            }).disposed(by: disposeBag)
    }
}
