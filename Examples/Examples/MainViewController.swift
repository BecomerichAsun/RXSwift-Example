//
//  MainViewController.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/9.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxDataSources
import NSObject_Rx

enum section:Int {
    case combineLatest = 0
    case Register = 1
    case Observable = 2
    case search = 3
}

class MainViewController: UITableViewController {
    
    let vm = MainViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "RXSwift - Examples - Asun"
        tableView.dataSource = nil
        tableView.delegate = nil
        
        let dataSource = RxTableViewSectionedReloadDataSource<SectionModel<String,MainModel>>(configureCell: {
            (_,tableView,indexPath,model) in
            let cell = MainTableViewCell(style: UITableViewCellStyle.subtitle, reuseIdentifier: "cell")
            cell.model = model
            return cell
        })
        
        vm.getNewsData().bind(to: tableView.rx.items(dataSource: dataSource)).disposed(by: rx.disposeBag)
        
        tableView.rx.itemSelected.map{ (index) in
            return (index,dataSource[index])
            }.subscribe(onNext: { [unowned self](indexPath,model) in
                switch indexPath.row {
                case section.combineLatest.hashValue:
                    self.creatVC(string: "ExamplesOneController")
                case section.Register.hashValue:
                    self.creatVC(string: "RegisterController")
                case section.Observable.hashValue:
                    self.creatVC(string: "ObservableController")
                case section.search.hashValue:
                    self.creatVC(string: "SearchController")
                default:
                    break
                }
                }, onError: nil, onCompleted: nil, onDisposed: nil).disposed(by: rx.disposeBag)
        
        tableView.rx.setDelegate(self).disposed(by: rx.disposeBag)
   
        
    }
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return .none
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return  80
    }
}

extension MainViewController {
    func creatVC(string:String) {
        let sb = UIStoryboard.init(name: string, bundle: nil)
        let controller =  sb.instantiateViewController(withIdentifier: string)
        navigationController?.pushViewController(controller, animated: true)
    }
}
