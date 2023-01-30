//
//  TableTableViewController.swift
//  CombineDemo
//
//  Created by luckyBoy on 2023/1/22.
//

import UIKit
import Combine
var cancellableBag = Set<AnyCancellable>()

class Number {
    @Published var value:Int = 0
    init(value: Int) {
        self.value = value
    }
}

class TableTableViewController: UITableViewController {
    
    var datas:[Number] = []
    {
        didSet{
            self.tableView.reloadData()
        }
    }
    let current = CurrentValueSubject<Number,Never>(Number(value: Int(arc4random())))
    var activity:UIActivityIndicatorView!
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let w:CGFloat = 100
        let rect:CGRect = .init(x: (self.view.frame.size.width - w)/2, y: (self.view.frame.size.height - w)/2, width: w, height: w)
        activity.frame = rect
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activity = UIActivityIndicatorView.init(style: .large)
        activity.backgroundColor = .black
        activity.color = .white
        activity.clipsToBounds = true
        activity.layer.cornerRadius = 10
        view.addSubview(activity)
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
        let rightBtn = UIButton.init(type: .custom)
        rightBtn.setTitle("加载", for: .normal)
        rightBtn.backgroundColor = .systemBlue
        rightBtn.addTarget(self, action: #selector(rightBtnAction), for: .touchUpInside)
        rightBtn.frame = .init(origin: .zero, size: .init(width: 60, height: 30))
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(customView: rightBtn)
        
        ///例1
//        let sub = Subscribers.Sink<Number, Never> { completion in
//            if completion == .finished{
//                print("TableTableViewController finished")
//            }else{
//                print("TableTableViewController error")
//            }
//        } receiveValue: {[weak self] value in
//            self?.datas.append(value)
//        }
//        current.subscribe(sub)
        
        ///例2
        current.sink { number in
            self.datas.append(number)
        }.store(in: &cancellableBag)
    }
    
    @objc func rightBtnAction() {
        activity.startAnimating()
        DispatchQueue.main.asyncAfter(deadline: .now() + 1){
            let model = Number(value: Int(arc4random()))
            self.current.send(model)
            self.activity.stopAnimating()
        }
    }
    
    deinit {
        self.current.send(completion: .finished)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return datas.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard datas.count > 0 else {
            return UITableViewCell()
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
        let number = datas[indexPath.row]
        cell.textLabel?.text = "\(number.value)"
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard datas.count > 0 else {
            return
        }
        let number = datas[indexPath.row]
        let vc = NextViewController.init()
        vc.model = number
        number.$value
            .receive(on: DispatchQueue.main)
            .first()
            .sink { value in
                print("value = \(value)")
                tableView.reloadData()
            }
            .store(in: &cancellableBag)
        navigationController?.pushViewController(vc, animated: true)
    }
  

}
