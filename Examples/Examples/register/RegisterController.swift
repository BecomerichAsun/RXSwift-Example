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

public enum SingleEvent<Element> {
    case success(Element)
    case error(Swift.Error)
}

enum DataError: Error {
    case cantParseJSON
}

class RegisterController: UIViewController {
    
    @IBOutlet weak var registerBtn: UIButton!
    @IBOutlet weak var userInput: UITextField!
    @IBOutlet weak var userTitle: UILabel!
    @IBOutlet weak var pwdInput: UITextField!
    @IBOutlet weak var pwdTitle: UILabel!
    
    lazy var count:Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userTitle.text = "帐号不能小于\(minimalUsernameLength)位数"
        pwdTitle.text = "密码不能小于\(minimalPasswordLength)位数"
        
        let user = userInput.rx.text.orEmpty.map({$0.count >= minimalUsernameLength}).share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        let pwd = pwdInput.rx.text.orEmpty.map({$0.count >= minimalPasswordLength}).share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        let every = Observable.combineLatest(user,pwd) {$0 && $1}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        
        user.bind(to: userTitle.rx.isHidden).disposed(by: rx.disposeBag)
        pwd.bind(to: pwdTitle.rx.isHidden).disposed(by: rx.disposeBag)
        every.bind(to: registerBtn.rx.isEnabled).disposed(by: rx.disposeBag)
        
        registerBtn.rx.tap.throttle(1, scheduler: MainScheduler.instance).subscribe(onNext: { [weak self] _ in self?.showAlert()
            self?.getPlaylist("1").subscribe({ (event) in
                switch event {
                case .success(let data):
                    print("请求成功\(data)")
                case .error(let error):
                    print("请求失败\(error)")
                }
            })
            }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        print("======== \(self.classForCoder) =======")
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
    
    //获取豆瓣某频道下的歌曲信息
    func getPlaylist(_ channel: String) -> Single<[String: Any]> {
        return Single<[String: Any]>.create { single in
            let url = "https://douban.fm/j/mine/playlist?"
                + "type=n&channel=\(channel)&from=mainsite"
            let task = URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
                if let error = error {
                    single(.error(error))
                    return
                }
                
                guard let data = data,
                    let json = try? JSONSerialization.jsonObject(with: data,
                                                                 options: .mutableLeaves),
                    let result = json as? [String: Any] else {
                        single(.error(DataError.cantParseJSON))
                        return
                }
                
                single(.success(result))
            }
            
            task.resume()
            
            return Disposables.create { task.cancel() }
        }
    }
    
    //与数据相关的错误类型
    enum DataError: Error {
        case cantParseJSON
    }
    
}
