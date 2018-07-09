
//
//  NavGationController.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/9.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit

class NavGationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
      
    }
    
    override func pushViewController(_ viewController: UIViewController, animated: Bool) {
        if self.viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
}
