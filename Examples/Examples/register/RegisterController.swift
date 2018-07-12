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
import Alamofire
/**
 总结:
 界面布局就不多说了
 首先 这只是一个简单的登录注册逻辑
 逻辑判断:
 对两个输入框做出操作,先拿出输入框字符串长度做Map遍历操作,判断其长度 是否大于等于限定长度,尾部Share的添加是防止Map多次循环
 SubjectLifetimeScope: 关于whileConnected这是默认值,当订阅者从1变成0时会被清除,作者推荐使用whileConnected
 combineLatest:这个Examples中获取到帐号密码输入框输入的字符串长度,并且两个都不为空的时候,相当于一个并集
 
 数据绑定:
 将账号密码与提示文字所绑定bind(to:"code") Code位置可以填写弹窗等 (按照需求来)
 
 将账号密码的两个输入长度与按钮的启动做出绑定
 
 点击按钮:
 弹窗成功
 */

fileprivate let minimalUsernameLength = 5
fileprivate let minimalPasswordLength = 5

class RegisterController: UIViewController {
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var pwdInput: UITextField!
    @IBOutlet weak var pwdTitle: UILabel!
    
    lazy var count:Int = 0
    lazy var url:URL = URL(string: "https://www.douban.com/j/app/radio/channels")!
    
    lazy var table:UITableView = {
        let table = UITableView(frame: CGRect.zero, style: UITableViewStyle.plain)
        table.sizeToFit()
        table.clipsToBounds = true
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        userTitle.text = "帐号不能小于\(minimalUsernameLength)位数"
        pwdTitle.text = "密码不能小于\(minimalPasswordLength)位数"

        
        view.addSubview(table)
        table.frame = CGRect(x: 0, y: UIScreen.main.bounds.size.height/2 + 30, width: UIScreen.main.bounds.size.width, height: UIScreen.main.bounds.size.height/2)
        
        addEvent()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        print("======== \(self.classForCoder) =======")
    }
}

extension RegisterController {
    
   
    
    func addEvent() {
        
        let user = userInput.rx.text.orEmpty.map({$0.count >= minimalUsernameLength}).share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        let pwd = pwdInput.rx.text.orEmpty.map({$0.count >= minimalPasswordLength}).share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        let every = Observable.combineLatest(user,pwd) {$0 && $1}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        user.asDriver(onErrorJustReturn: true).drive(userTitle.rx.isHidden).disposed(by: rx.disposeBag)
        
        pwd.asDriver(onErrorJustReturn: true).drive(pwdTitle.rx.isHidden).disposed(by: rx.disposeBag)
        
        every.asDriver(onErrorJustReturn: true).drive(registerBtn.rx.isEnabled).disposed(by: rx.disposeBag)
        
        isHidden()
        
        registerBtn.rx.tap.throttle(1, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in self?.showAlert()
            self?.requestAddTable()
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
    }
    
    func isHidden() {
        let isUser = userInput.rx.text.orEmpty.map({$0.count >= 5 }).share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        let isPwd = pwdInput.rx.text.orEmpty.map({$0.count >= 5}).share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        let every = Observable.combineLatest(isUser,isPwd) {($0 && $1) == false}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        every.asDriver(onErrorJustReturn: true).drive(self.table.rx.isHidden).disposed(by: rx.disposeBag)
    }
    
    func requestAddTable() {
        table.delegate = nil
        table.dataSource = nil
        
        let data = requestJSON(.get, url)
            .map{$1}
            .mapObject(type: requestModel.self)
            .map{$0.channels ?? []}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        data.asDriver(onErrorJustReturn: []).drive(table.rx.items){ (tableView, row, element) in
            tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
            cell.textLabel?.text = "\(row+1)：\(element.name!)"
            return cell
            }.disposed(by: rx.disposeBag)
    }
    
    
}

extension RegisterController {
    func showAlert() {
        count += 1
        let alert = UIAlertView(
            title: "Login Success",
            message: "Hellow Word !!!\n 点击弹窗\(count)",
            delegate: nil,
            cancelButtonTitle: "OK")
        alert.show()
    }
}

