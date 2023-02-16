//
//  UIGesturePublish.swift
//  CombineDemo
//
//  Created by luckyBoy on 2/15/23.
//

import Combine
import UIKit

fileprivate class UIGestureSubscription<S:Subscriber,T:UIGestureRecognizer>:Subscription where S.Input == T{
    
    private var subscriber: S?
    private let gesture:T
    
    init(subscriber:S,gesture:T,view:UIView) {
        self.subscriber = subscriber
        self.gesture = gesture
        gesture.addTarget(self, action: #selector(gestureAction))
        view.addGestureRecognizer(gesture)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func gestureAction() {
        _ = subscriber?.receive(self.gesture)
    }
    
    func request(_ demand: Subscribers.Demand) {
        
    }
    
    func cancel() {
        self.subscriber = nil
    }
}

class UIGesturePublish<T:UIGestureRecognizer>: Publisher {
    typealias Output = T
    typealias Failure = Never
    
    let gesture:T
    let view:UIView
    init(gesture:T,view:UIView) {
        self.gesture = gesture
        self.view = view
    }
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, T == S.Input {
        let subscrip = UIGestureSubscription<S, T>.init(subscriber: subscriber, gesture: gesture, view: view)
        subscriber.receive(subscription: subscrip)
    }
}

extension UIView: CombineCompatible {
    ///手势类型
    enum UIGestureRecognizerType {
        ///点击
        case tap
        ///长按
        case longPress
        ///轻扫
        case swipe
        ///拖动
        case pan
        ///旋转
        case rotation
    }
}

extension CombineCompatible where Self: UIView {
    func gesturePublisher(_ type:UIGestureRecognizerType) -> UIGesturePublish<UIGestureRecognizer> {
        switch type {
        case .tap:
            return UIGesturePublish(gesture: UITapGestureRecognizer(), view: self)
        case .longPress:
            return UIGesturePublish(gesture: UILongPressGestureRecognizer(), view: self)
        case .swipe:
            return UIGesturePublish(gesture: UISwipeGestureRecognizer(), view: self)
        case .pan:
            return UIGesturePublish(gesture: UIPanGestureRecognizer(), view: self)
        case .rotation:
            return UIGesturePublish(gesture: UIRotationGestureRecognizer(), view: self)
        }
    }
}


