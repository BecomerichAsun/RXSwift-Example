//
//  Model.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/11.
//  Copyright © 2018年 Asun. All rights reserved.
//

import ObjectMapper
import RxSwift

public enum ErrorType:Error {
    case JsonError(str:String)
}

/**调试使用*/
func Jsonerror(Str:String) {
    let alert = UIAlertView(
        title: "警告",
        message: Str,
        delegate: nil,
        cancelButtonTitle: "OK")
    alert.show()
}

public extension Observable where Element:Any {
    //将JSON数据转成对象
    public func mapObject< T>(type:T.Type) -> Observable<T> where T:Mappable {
        let mapper = Mapper<T>()
        
        return self.map { (element) -> T in
            guard let parsedElement = mapper.map(JSONObject: element) else {
                throw ErrorType.JsonError(str: "映射对象失败")
            }
            return parsedElement
        }
    }
    
    //将JSON数据转成数组
    public func mapArray< T>(type:T.Type) -> Observable<[T]> where T:Mappable {
        let mapper = Mapper<T>()
        return self.map { (element) -> [T] in
            guard let parsedArray = mapper.mapArray(JSONObject: element) else {
                throw ErrorType.JsonError(str: "映射数组失败")
            }
            return parsedArray
        }
    }
}


