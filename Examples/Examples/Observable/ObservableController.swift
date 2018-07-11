//
//  ObservableController.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/10.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
/**总结:
 IOS: UI方面 创建控件 -> 设置默认值 -> 改变默认值 -> 展示
 使用RXSwift: 创建控件 -> 设置默认值 -> 创建观察者(获取数据/存储数据) -> 订阅观察者(给控件赋值/根据需求做操作) -> 展示
 Observable:观察者,可以指定类型,适用于特定数据
 AnyObservable:任何类型的观察者,适用于任何数据
 Binder:不会回调错误事件的观察者,适用于UI控件订阅
 Binder使用: 实例化控件,回调含有当前控件,以及所需要的数据
 let binderObservable:Binder<String> = Binder(time2){(label,value) in
 label.text = value
 }
 */

class ObservableController: UIViewController {
    
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var time1: UILabel!
    @IBOutlet weak var time2: UILabel!
    @IBOutlet weak var replayBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        //观察者
        let observable = Observable<Int>.interval(1, scheduler: MainScheduler.asyncInstance)
        
        observable.map {"当前索引:\($0)秒"}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected).bind {[unowned self](value) in
            self.time.text = value
            
            }.disposed(by: rx.disposeBag)
        
        //任意观察者
        let anyObservable:AnyObserver<String> = AnyObserver { [weak self] (value) in
            switch value {
            case .next(let data):
                self?.time1.text = data
            case.error(let error):
                print(error)
            case.completed:
                print("completed")
            }
        }
        
        
        observable.map{"当前索引:\($0)秒"}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected).bind(to: anyObservable).disposed(by: rx.disposeBag)
        
        //不会处理错误事件的观察者
        let binderObservable:Binder<String> = Binder(time2){(label,value) in
            label.text = value
        }
    
        observable.map {"当前索引:\($0)秒"}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected).bind(to: binderObservable).disposed(by: rx.disposeBag)
        
        //自定义绑定属性
        observable.map{CGFloat($0)}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected).bind(to: time.fontSize).disposed(by: rx.disposeBag)
        observable.map{CGFloat($0)}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected).bind(to: time1.fontSize).disposed(by: rx.disposeBag)
        observable.map{CGFloat($0)}.share(replay: 1, scope: SubjectLifetimeScope.whileConnected).bind(to: time2.rx.fontSize).disposed(by: rx.disposeBag)
    }
    deinit {
        print("======== \(self.classForCoder) =======")
    }
}
//对UILabel扩展
extension UILabel {
    public var fontSize: Binder<CGFloat> {
        return Binder(self){(label,fontSize) in
            guard fontSize >= 17 else {
             label.font = UIFont.systemFont(ofSize: fontSize)
             return
            }
        }
    }
}
//对Reactive扩展
extension Reactive where Base: UILabel {
    public var fontSize: Binder<CGFloat> {
        return  Binder(base) {(label,fontSize) in
            guard fontSize >= 17 else {
                label.font = UIFont.systemFont(ofSize: fontSize)
                return
            }
        }
    }
}

