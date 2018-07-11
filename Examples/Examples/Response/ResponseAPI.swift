//
//  ResponseAPI.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/11.
//  Copyright © 2018年 Asun. All rights reserved.
//


import RxSwift
import RxCocoa
import Alamofire

class ResponseAPI : NSObject {

        public enum SingleEvent<Element> {
            case success(Element)
            case error(Swift.Error)
        }
    
        private static let worker: SessionManager = {
            let config = URLSessionConfiguration.default
            config.timeoutIntervalForRequest = 15
            config.timeoutIntervalForResource = config.timeoutIntervalForRequest
            Alamofire.SessionManager.default.delegate.taskWillPerformHTTPRedirection = nil
            return Alamofire.SessionManager(configuration: config)
        }()
    
        private static func createUrlAndHeaders(urlStr: String) -> (url: String, headers: [String: String]) {
            let Url = urlStr
            let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
            let headers = ["Accept": "application/json; version=\(version)"]
            return (Url, headers)
        }
}




