//
//  AppDelegate.swift
//  CombineDemo
//
//  Created by luckyBoy on 2022/12/6.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window:UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow.init(frame: UIScreen.main.bounds)
        window?.backgroundColor = .white
        let nav = UINavigationController.init(rootViewController: ViewController.init())
        window?.rootViewController = nav
        window?.makeKeyAndVisible()
        return true
    }




}

