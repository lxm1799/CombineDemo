//
//  NextViewController.swift
//  CombineDemo
//
//  Created by luckyBoy on 2023/1/24.
//

import UIKit

class NextViewController: UIViewController {

    var model:Number!
    var btn:UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let btn = UIButton.init(type: .custom)
        btn.setTitle("\(model.value)", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.frame = .init(origin: .zero, size: .init(width: 200, height: 30))
        btn.center = self.view.center
        btn.addTarget(self, action: #selector(btnAction), for: .touchUpInside)
        self.btn = btn
        view.addSubview(btn)
    }
    
    @objc func btnAction() {
        let vc = OtherViewController.init()
        vc.model = model
        model.value += 10
        model.$value
            .receive(on: DispatchQueue.main)
            .sink { value in
                print("richard NextViewController value = \(value)")
                self.btn.setTitle("\(value)", for: .normal)
            }
            .store(in: &cancellableBag)
        navigationController?.pushViewController(vc, animated: true)
    }


}
