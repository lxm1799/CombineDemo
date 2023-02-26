//
//  ViewDataSource.swift
//  CombineDemo
//
//  Created by luckyBoy on 2/26/23.
//

import Foundation
import UIKit
import Combine

class ViewDataSource: NSObject,UITableViewDelegate,UITableViewDataSource {
    
    let didSelectSubject = PassthroughSubject<(Name,IndexPath),Never>()
    let didSetSubject = PassthroughSubject<Void,Never>()
    
    var dataSource:[Name] = []{
        didSet{
            print("didSet didSet")
            didSetSubject.send()
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSource.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell") as?  HomeTableViewCell else {
            return UITableViewCell()
        }
        guard dataSource.count > 0,indexPath.row <= dataSource.count - 1 else { return UITableViewCell()}
        let model = dataSource[indexPath.row]
        cell.titleLabel.text = model.title
       return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard dataSource.count > 0,indexPath.row <= dataSource.count - 1 else { return }
        didSelectSubject.send((dataSource[indexPath.row],indexPath))
    }
}
