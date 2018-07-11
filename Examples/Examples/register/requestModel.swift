//
//  requestModel.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/11.
//  Copyright © 2018年 Asun. All rights reserved.
//

import ObjectMapper
import RxSwift

class requestModel: Mappable {
    //频道列表
    var channels: [Channel]?
    
    init(){}
    
    required init?(map: Map) {}
    
    // Mappable
    func mapping(map: Map) {
        channels <- map["channels"]
    }
}

//频道模型
class Channel: Mappable {
    var name: String?
    var nameEn:String?
    var channelId: String?
    var seqId: Int?
    var abbrEn: String?
    
    init(){}
    
    required init?(map: Map) {}
    
    // Mappable
    func mapping(map: Map) {
        name <- map["name"]
        nameEn <- map["name_en"]
        channelId <- map["channel_id"]
        seqId <- map["seq_id"]
        abbrEn <- map["abbr_en"]
    }
}
