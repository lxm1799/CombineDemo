//
//  LoginViewController.swift
//  CombineDemo
//
//  Created by luckyBoy on 2022/12/8.
//

import UIKit
import Combine


extension String{
    func substring(toIndex: Int) -> String {
        return (self as NSString).substring(to: toIndex)
    }
}

class LoginViewController: UIViewController {

    let passwordMinCount = 6
    let accountMaxCount = 11

    @Published var account:String?
    @Published var password:String?
    
    private var isValid:AnyPublisher<Bool,Never>{
        return Publishers.CombineLatest($account, $password)
            .map{v1,v2 in
                let aa =  v1?.count ?? 0 == self.accountMaxCount && v2?.count ?? 0 >= self.passwordMinCount
                print("aa = \(aa) v1Count:\(v1?.count ?? 0) v2Count:\(v2?.count ?? 0)")
                return aa
            }
            .eraseToAnyPublisher()
    }
    
    private var color:AnyPublisher<UIColor,Never>{
        return Publishers.CombineLatest($account, $password)
            .map{v1,v2 in
                let aa =  v1?.count ?? 0 == self.accountMaxCount && v2?.count ?? 0 >= self.passwordMinCount
                return aa ? .systemRed : .systemGray
            }
            .eraseToAnyPublisher()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        handleLogic()
    }
    
    func handleLogic() {
        $account
            .assign(to: \.text, on: accountTfd)
            .store(in: &cancellableBag)
        $password
            .assign(to: \.text, on: passwordTfd)
            .store(in: &cancellableBag)
        color
            .sink(receiveValue: { color in
                self.loginBtn.backgroundColor = color
            })
            .store(in: &cancellableBag)
        isValid
            .assign(to: \.isEnabled, on: loginBtn)
            .store(in: &cancellableBag)
    }
    
    @objc func loginBtnAction(){
        print("登录了----")
    }
    
    @objc func accountTfdAction(tfd:UITextField) {
        if let text = tfd.text,text.count > accountMaxCount{
            account = text.substring(toIndex: accountMaxCount)
        }else{
            account = tfd.text
        }
    }
    
    @objc func passwordTfdAction(tfd:UITextField) {
        if let text = tfd.text,text.count > passwordMinCount * 2{
            password = text.substring(toIndex: passwordMinCount * 2)
        }else{
            password = tfd.text
        }
    }
    
    func setupUI()  {
        view.addSubview(accountTfd)
        view.addSubview(passwordTfd)
        view.addSubview(loginBtn)
        
        accountTfd.backgroundColor = .systemBlue
        passwordTfd.backgroundColor = .systemBlue
        
        accountTfd.addTarget(self, action: #selector(accountTfdAction), for: .editingChanged)
        passwordTfd.addTarget(self, action: #selector(passwordTfdAction), for: .editingChanged)
        
        accountTfd.snp.makeConstraints { make in
            make.center.equalTo(view)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        passwordTfd.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(accountTfd.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(40)
        }
        
        loginBtn.snp.makeConstraints { make in
            make.centerX.equalTo(view)
            make.top.equalTo(passwordTfd.snp.bottom).offset(30)
            make.width.equalTo(200)
            make.height.equalTo(60)
        }
    }

    lazy var accountTfd = UITextField.init()
    lazy var passwordTfd = UITextField.init()
    lazy var loginBtn: UIButton = {
        let btn = UIButton.init(type: .custom)
        btn.setTitle("登录", for: .normal)
        btn.addTarget(self, action: #selector(loginBtnAction), for: .touchUpInside)
        btn.backgroundColor = .systemRed
        return btn
    }()
    
    

}
