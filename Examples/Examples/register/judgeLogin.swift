//
//  judgeLogin.swift
//  Examples
//
//  Created by Asun on 2018/7/12.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

enum Result {
    case ok(message:String)//输入正确
    case empty//输入为空
    case failed(message:String)//输入不合法
}

fileprivate let minCout = 10

class judgeLogin: NSObject {
    
    override init() {
        
    }
    
    func loginUserNameValid(_ name:String) -> Observable<Result> {
      
        if name.isEmpty {
            return Observable.just(Result.empty)
        }
        
        if name.count < 10 {
            return Observable.just(Result.failed(message: "用户名小于\(minCout)位"))
        }
        return Observable.just(Result.ok(message: "用户名可用"))
    }
    
    func loginPwdValid(_ pwd:String) -> Observable<Result> {
        
        if pwd.isEmpty {
            return Observable.just(Result.empty)
        }
        
        if pwd.count < 10 {
            return Observable.just(Result.failed(message: "密码小于\(minCout)位"))
        }
        return Observable.just(Result.ok(message: "密码可用"))
    }
}
