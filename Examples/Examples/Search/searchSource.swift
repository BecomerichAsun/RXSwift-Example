//
//  searchSource.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/11.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit

enum searchNetWork {
    case changeSearch(text: String)
    case loadMoreItems
//    case gitHubResponseReceived(SearchRepositoriesResponse)
}

struct SearchRepositoriesState {
    // control
    var searchText: String
    var shouldLoadNextPage: Bool
    var nextURL: URL?
    
    init(searchText: String) {
        self.searchText = searchText
        shouldLoadNextPage = true
        nextURL = URL(string: "https://api.github.com/search/repositories?q=\(searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? "")")
    }
}




class searchSource: NSObject {

}
