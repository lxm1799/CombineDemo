//
//  OtherViewController.swift
//  CombineDemo
//
//  Created by luckyBoy on 2023/1/25.
//

import UIKit

class OtherViewController: UIViewController {

    var model:Number!
    var btn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mergeFunc()
//        zipFun()
        
        let btn = UIButton.init(type: .custom)
        btn.setTitle("\(model.value)", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.frame = .init(origin: .zero, size: .init(width: 200, height: 30))
        btn.center = self.view.center
        btn.publisher(for: .touchUpInside)
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .sink { button in
                self.model.value += 1
                btn.setTitle("\(self.model.value)", for: .normal)
                print("richard OtherViewController value = \(self.model.value)")
            }.store(in: &cancellableBag)
        view.addSubview(btn)
        
        
        let textView = UITextView.init()
//        textView.publisher(for: .touchUpInside)
        textView.publisher(for: \.text)
            .sink { string in
                btn.setTitle(string, for: .normal)
            }
            .store(in: &cancellableBag)
        
        let textField = UITextField.init()
        textField.publisher(for: .touchUpInside)
    }
    

    func mergeFunc() {
        let a = [1,2,3]
        let b = [4,5,6]
        a.publisher.merge(with: b.publisher)
            .filter{$0 > 2}
            .map{
                return "\($0)"
            }
            .sink { value in
                print("mergeFunc value = \(value)")
                /*
                 mergeFunc value = 3
                 mergeFunc value = 4
                 mergeFunc value = 5
                 mergeFunc value = 6
                 */
            }
            .store(in: &cancellableBag)
    }
    
    
    
    func zipFun() {
        
        let a = [1,2,3]
        let b = [4,5,6]
        a.publisher.zip(b.publisher)
            .sink { value in
                print("zipFun value = \(value)")
                /*
                 zipFun value = (1, 4)
                 zipFun value = (2, 5)
                 zipFun value = (3, 6)
                 */
            }
            .store(in: &cancellableBag)
    }

}
