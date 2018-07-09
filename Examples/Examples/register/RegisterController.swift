//
//  RegisterController.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/9.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import NSObject_Rx

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class RegisterController: UIViewController {
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var pwdInput: UITextField!
    @IBOutlet weak var pwdTitle: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTitle.text = "帐号不能小于\(minimalUsernameLength)位数"
        pwdTitle.text = "密码不能小于\(minimalPasswordLength)位数"
        
        /**判断输入长度是否大于5*/
        let user = userInput.rx.text.orEmpty.map({$0.count >= minimalUsernameLength}).share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        let pwd = pwdInput.rx.text.orEmpty.map({$0.count >= minimalPasswordLength}).share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        /**两个都成立的情况下*/
        let every = Observable.combineLatest(user,pwd) {$0 && $1}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        user.bind(to: userTitle.rx.isHidden).disposed(by: rx.disposeBag)
        pwd.bind(to: pwdTitle.rx.isHidden).disposed(by: rx.disposeBag)
        every.bind(to: registerBtn.rx.isEnabled).disposed(by: rx.disposeBag)
        
        registerBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.showAlert() })
            .disposed(by: rx.disposeBag)
    }
}

extension RegisterController {
    func showAlert() {
        let alert = UIAlertView(
            title: "Login Success",
            message: "Hellow Word !!!",
            delegate: nil,
            cancelButtonTitle: "OK")
        
        alert.show()
    }
}
