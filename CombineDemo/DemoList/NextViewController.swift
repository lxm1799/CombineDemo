//
//  NextViewController.swift
//  CombineDemo
//
//  Created by luckyBoy on 2023/1/24.
//

import UIKit

class NextViewController: UIViewController {

    var model:Number!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        model.value = Int(arc4random_uniform(10))
        
        let label = UILabel.init(frame: .init(origin: .zero, size: .init(width: 200, height: 30)))
        label.center = self.view.center
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        self.view.addSubview(label)
        label.text = "\(model.value)"
    }



}
