//
//  MainViewModel.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/9.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
class MainViewModel: NSObject {

    func getNewsData() -> Observable<[SectionModel<String, MainModel>]> {
        return Observable.create({ (observer) -> Disposable in
            let dataSourceArray = [MainModel(title: "CombineLatest", introduce: "将可观察序列 组合处理"),MainModel(title: "register", introduce: "RX登录逻辑 组合处理"),MainModel(title: "Observable", introduce: "混合使用"),
            MainModel(title: "search", introduce: "搜索")]
            let section = [SectionModel(model: "", items: dataSourceArray)]
            observer.onNext(section)
            observer.onCompleted()
            return  Disposables.create()
        })
    }
}
