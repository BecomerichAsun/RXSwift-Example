//
//  MainModel.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/9.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit

struct MainModel {
    let title: String
    let introduce: String
}


extension MainModel : CustomStringConvertible {
    var description: String {
        return  "标题是\(title),内容是\(introduce)"
    }
}
