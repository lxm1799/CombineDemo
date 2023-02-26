//
//  OtherViewController.swift
//  CombineDemo
//
//  Created by luckyBoy on 2023/1/25.
//

import UIKit
import Combine
class OtherViewController: UIViewController {

    var model:Number!
    var btn:UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        mergeFunc()
//        zipFun()
//        someUI()
//        aboutPublisherAndSubscribers()
//        futureTest()
        conditionTest()
    }
    
    enum NetWorkError:Error {
        case error(code:Int,msg:String,data:Any?)
    }
    
    ///异步使用
    func futureTest() {
        Future<Int,NetWorkError>.init { promiss in
            DispatchQueue.main.asyncAfter(deadline: .now() + 1){
                promiss(.failure(NetWorkError.error(code: -1, msg: "网络异常", data: nil)))
            }
        }.sink(receiveCompletion: { error in
            print("error = \(error)")
        }, receiveValue: { value in
            print("value = \(value)")
        }).store(in: &cancellableBag)
    }
    
    ///判断类型
    func conditionTest() {
        let arr = [1,2,3,4,5]
        arr.publisher
            .allSatisfy{$0 > 0}
            .sink { flag in
                print("value = \(flag)")
            }
            .store(in: &cancellableBag)
        
        arr.publisher
            .contains(0)
            .sink { flag in
                print("value = \(flag)")
            }
            .store(in: &cancellableBag)
    }
    
    
    func aboutPublisherAndSubscribers() {
        ///发布者
        let arr = [1,2,3,4,5]
        let arrPublisher = arr.publisher
            .map{$0 + 1}
            .filter{$0 % 2 == 0}
            .print()
        
        ///订阅者
        let subscription = Subscribers.Sink<Int,Never> { complatetion in
            if complatetion == .finished{
                print("subscription finished")
            }else{
                print("subscription error")
            }
        } receiveValue: { value in
            print("subscription value = \(value)")
        }
        
        ///发布者与订阅者建立联系
        arrPublisher.receive(subscriber: subscription)
    }
    
    func someUI() {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("\(model.value)", for: .normal)
        btn.backgroundColor = .systemBlue
        btn.frame = .init(origin: .zero, size: .init(width: 200, height: 30))
        btn.center = self.view.center
//        btn.addTarget(self, action: #selector(aaaaaa), for: .touchUpInside)
        btn.publisher(for: .touchUpInside)
            .throttle(for: 1, scheduler: RunLoop.main, latest: true)
            .sink { button in
                self.model.value += 1
                btn.setTitle("\(self.model.value)", for: .normal)
                print("richard OtherViewController value = \(self.model.value)")
            }.store(in: &cancellableBag)
        view.addSubview(btn)
        

        let lab = UILabel.init()
        lab.backgroundColor = .red
        view.addSubview(lab)
        lab.text = "点击我呀"
        lab.textAlignment = .center
        lab.textColor = .white
        lab.isUserInteractionEnabled = true
        lab.snp.makeConstraints { make in
            make.center.equalTo(self.view)
            make.size.equalTo(CGSize.init(width: 100, height: 100))
        }
        lab.gesturePublisher(.tap)
            .throttle(for: 1, scheduler: RunLoop.main, latest: false)
            .sink(receiveValue: { tap in
                print("tap = \(tap)")
            })
            .store(in: &cancellableBag)
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
