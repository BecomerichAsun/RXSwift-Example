//
//  RegisterModels.swift
//  Examples
//
//  Created by Asun on 2018/7/12.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift


class RegisterModels : NSObject{
    let userName = Variable("")
    let userPwd = Variable("")
    let userNameUsable :Observable<Result>
    let userPasswordAble :Observable<Result>
    
    override init() {
        userNameUsable = userName.asObservable().flatMapLatest{ userStr in
            return judgeLogin().loginUserNameValid(userStr).catchErrorJustReturn(Result.failed(message: "账号错误")).share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        }
        
        userPasswordAble = userPwd.asObservable().flatMapLatest{ userStr in
            return judgeLogin().loginPwdValid(userStr).catchErrorJustReturn(Result.failed(message: "密码错误")).share(replay: 1, scope: SubjectLifetimeScope.whileConnected)
        }
    }
}
