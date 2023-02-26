//
//  ViewModel.swift
//  CombineDemo
//
//  Created by luckyBoy on 2/26/23.
//

import Foundation
import UIKit

struct Name {
    var title:String
    var cls:UIViewController.Type
}


class ViewModel {
    
    lazy var dataSource: [Name] = {
        var datas = [Name]()
        datas.append(Name.init(title: NSStringFromClass(LoginViewController.self), cls: LoginViewController.self))
        datas.append(Name.init(title: NSStringFromClass(TimerViewController.self), cls: TimerViewController.self))
        datas.append(Name.init(title: NSStringFromClass(TableTableViewController.self), cls: TableTableViewController.self))
        datas.append(Name.init(title: NSStringFromClass(OtherViewController.self), cls: OtherViewController.self))
        return datas
    }()
}
