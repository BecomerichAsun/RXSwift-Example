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
        
        sumBtn.addTarget(self, action: #selector(sum), for: .touchUpInside)
    }
    
    @objc func sum() {
        Observable.combineLatest(oneTextField.rx.text.orEmpty, twoTextField.rx.text.orEmpty, threeTextField.rx.text.orEmpty) { textValue1, textValue2, textValue3 -> Int in
            return (Int(textValue1) ?? 0) + (Int(textValue2) ?? 0)+(Int(textValue3) ?? 0)
            }
            .map { $0.description }
            .bind(to: result.rx.text).disposed(by: rx.disposeBag)
    }
}
