//
//  SearchController.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/11.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit
import RxCocoa
import RxSwift
import RxDataSources
import NSObject_Rx

class SearchController: UIViewController,UITableViewDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,ResponseSearch>>(configureCell: {
        (_,tableView,indexPath,model) in
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell")!
        cell.textLabel?.text = model.name ?? ""
        cell.detailTextLabel?.text = model.url?.absoluteString ?? ""
        return cell
    }, titleForHeaderInSection: { dataSource, sectionIndex in
        let section = dataSource[sectionIndex]
        return section.items.count > 0 ? "搜索 (\(section.items.count))" : "没找到"
    })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
 let state = SearchRepositoriesState.init(searchText: <#T##String#>)
        
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 35
    }
}
