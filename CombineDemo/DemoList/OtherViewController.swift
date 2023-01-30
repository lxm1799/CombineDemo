//
//  OtherViewController.swift
//  CombineDemo
//
//  Created by luckyBoy on 2023/1/25.
//

import UIKit

class OtherViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        mergeFunc()
        zipFun()
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
