//
//  TimerViewController.swift
//  CombineDemo
//
//  Created by luckyBoy on 2023/1/17.
//

import UIKit
import Combine


class TimerViewController: UIViewController {
    
    private var timerPublisher:AnyCancellable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let label = UILabel.init(frame: .init(origin: .zero, size: .init(width: 200, height: 30)))
        label.center = self.view.center
        label.textAlignment = .center
        label.backgroundColor = .systemBlue
        self.view.addSubview(label)
        
        
//        timerPublisher = Timer
//            .publish(every: 1, on: .main, in: .default)
//            .autoconnect()
//            .scan(0, { result, _ in
//                print("result = \(result)")
//                return result + 1
//            })
//            .sink { value in
//                label.text = "\(value)"
//            }
        
        
//        PassthroughSubject<Int,Error>()
//            .timeout(.seconds(2), scheduler: DispatchQueue.main)
//            .sink(receiveCompletion: { error in
//                print("result = \(error)")
//            }, receiveValue: { result in
//                print("result = \(result)")
//            })
//            .store(in: &cancellableBag)

    
        test2()
        test3()
        
    }
    
    
    deinit {
        timerPublisher?.cancel()
    }
    
    
    func test1() {
        
        let sub = Subscribers.Sink<String,Never> { completion in
            if completion == .finished{
                print("test1 finished")
            }else{
                print("test1 error")
            }
        } receiveValue: { value in
            print("test1 value1 = \(value)")
        }


        let arr = 0...3
//        arr.publisher.subscribe(sub)
        
        arr
            .publisher
            .map{
                "\($0) 111"
            }
//            .sink { value in
//                print("value2 = \(value)")
//            }
            .subscribe(sub)
    }

    func test2() {
        let current = CurrentValueSubject<Int,Never>(10)
        let sub1 = Subscribers.Sink<Int, Never> { completion in
            if completion == .finished{
                print("test2 finished")
            }else{
                print("test2 error")
            }
        } receiveValue: { value in
            print("test2 value1 = \(value)")
        }
        current.subscribe(sub1)
        current.send(5)
        current.send(completion: .finished)
        current.send(3)
    }
    
    func test3() {
        let current = PassthroughSubject<Int,Never>()
        let sub1 = Subscribers.Sink<Int, Never> { completion in
            if completion == .finished{
                print("test3 finished")
            }else{
                print("test3 error")
            }
        } receiveValue: { value in
            print("test3 value1 = \(value)")
        }
        current.subscribe(sub1)
        current.send(5)
        current.send(completion: .finished)
        current.send(3)
    }

}
