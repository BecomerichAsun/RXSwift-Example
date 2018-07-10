//
//  ExamplesOneController.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/9.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import NSObject_Rx
/**
 总结:
 利用combineLatest特性,将三个输入框的字符串长度取出,做出判断,求和得出总结果
 
 拓展:
 此方法适用于 注册登录 输入框长度判断等模块
 */

class ExamplesOneController: UIViewController {
    
    @IBOutlet weak var threeTextField: UITextField!
    
    @IBOutlet weak var oneTextField: UITextField!
    
    @IBOutlet weak var twoTextField: UITextField!
    
    @IBOutlet weak var result: UILabel!
    
    @IBOutlet weak var sumBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "combineLatest"
        view.backgroundColor = UIColor.white
        
        sumBtn.rx.tap
            .subscribe(onNext: { [weak self] _ in self?.sum() })
            .disposed(by: rx.disposeBag)
    }
    
    func sum() {
        Observable.combineLatest(oneTextField.rx.text.orEmpty, twoTextField.rx.text.orEmpty, threeTextField.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0)+(Int(textValue3) ?? 0)
            }
            .map { $0.description }
            .bind(to: result.rx.text).disposed(by: rx.disposeBag)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    deinit {
        print("======== \(self.classForCoder) =======")
    }
}


