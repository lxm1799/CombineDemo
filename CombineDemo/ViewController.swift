//
//  ViewController.swift
//  CombineDemo
//
//  Created by luckyBoy on 2022/12/6.
//

import UIKit
import Combine

class ViewController: UITableViewController {
    
    var viewModel = ViewModel.init()
    var viewDataSource = ViewDataSource.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = viewDataSource
        tableView.dataSource = viewDataSource
        tableView.register(HomeTableViewCell.self, forCellReuseIdentifier: "HomeTableViewCell")
        viewDataSource.dataSource = viewModel.dataSource
        
        viewDataSource.didSelectSubject
            .print()
            .sink {[weak self] model,_ in
                let vc = model.cls.init()
                vc.title = model.title
                self?.navigationController?.pushViewController(vc, animated: true)
            }.store(in: &cancellableBag)
        
        viewDataSource.didSetSubject
            .print()
            .sink {[weak self]  in
                self?.tableView.reloadData()
            }.store(in: &cancellableBag)
    }
}



