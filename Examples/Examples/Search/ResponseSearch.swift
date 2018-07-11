//
//  Response.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/11.
//  Copyright © 2018年 Asun. All rights reserved.
//

import RxSwift
import ObjectMapper

class ResponseSearch:Mappable,CustomDebugStringConvertible {
    
    var name: String?
    var url: URL?
    
    var description: String {
        return "\(String(describing: name)) | \(String(describing: url))"
    }
    
    init(){}
    
    required init?(map: Map) {}

    func mapping(map: Map) {
        name <- map["name"]
        url <- map["url"]
    }
}


