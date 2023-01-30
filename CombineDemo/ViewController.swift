//
//  ViewController.swift
//  CombineDemo
//
//  Created by luckyBoy on 2022/12/6.
//

import UIKit
import SnapKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.bottom.equalTo(self.view)
            make.top.equalTo(self.view).offset(88)
        }
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: .zero, style: .plain)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
        tableView.backgroundColor       = .clear
        tableView.separatorStyle        = .none
        tableView.estimatedRowHeight    = 0
        tableView.estimatedSectionHeaderHeight = 0
        tableView.estimatedSectionFooterHeight = 0
        tableView.showsHorizontalScrollIndicator    = false
        tableView.showsVerticalScrollIndicator      = false
        tableView.delegate = self
        tableView.dataSource = self
        if #available(iOS 11.0, *) {
            tableView.contentInsetAdjustmentBehavior = .never
        } else {
            // Fallback on earlier versions
        }
        if #available(iOS 15, *) {
            tableView.sectionHeaderTopPadding = 0
        }
        view.addSubview(tableView)
        return tableView
    }()
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let model = dataSource[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = model.title
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let model = dataSource[indexPath.row]
        let vc = model.cls.init()
        vc.title = model.title
        print("vc=\(model.title)")
        navigationController?.pushViewController(vc, animated: true)
    }
    
    lazy var dataSource: [Name] = {
        var datas = [Name]()
        datas.append(Name.init(title: NSStringFromClass(LoginViewController.self), cls: LoginViewController.self))
        datas.append(Name.init(title: NSStringFromClass(TimerViewController.self), cls: TimerViewController.self))
        datas.append(Name.init(title: NSStringFromClass(TableTableViewController.self), cls: TableTableViewController.self))
        datas.append(Name.init(title: NSStringFromClass(OtherViewController.self), cls: OtherViewController.self))
        
        
        
        return datas
    }()

}

struct Name {
    var title:String
    var cls:UIViewController.Type
}

