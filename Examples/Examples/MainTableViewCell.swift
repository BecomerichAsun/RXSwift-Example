//
//  MainTableViewCell.swift
//  Examples
//
//  Created by 钟宏阳 on 2018/7/9.
//  Copyright © 2018年 Asun. All rights reserved.
//

import UIKit
import SnapKit

class MainTableViewCell: UITableViewCell {
    
    lazy var titleLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    lazy var introduceLabel:UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.textColor = UIColor.black
        return label
    }()
    
    var model: MainModel? {
        willSet {
            print("模型生儿子啦\n\(newValue!)")
        }
        didSet {
            titleLabel.text = model?.title ?? ""
            introduceLabel.text = model?.introduce ?? ""
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setTitle()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setTitle() {
        addSubview(titleLabel)
        titleLabel.snp.makeConstraints { (make) in
            make.leading.top.equalTo(10)
        }
        addSubview(introduceLabel)
        introduceLabel.snp.makeConstraints { (make) in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.leading.equalTo(titleLabel)
        }
    }
}
