//
//  CommentCell.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/29.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import UIKit

class CommentCell: UITableViewCell {
    
    // MARK: - View -
    
    fileprivate lazy var dateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HiraKakuProN-W3", size: 12)
        label.textAlignment = .right
        return label
    }()
    
    fileprivate lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont(name: "HiraKakuProN-W3", size: 16)
        label.numberOfLines = 0
        return label
    }()
    
    
    // MARK: - Life Cycle Events -
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setUpView()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Set Up Views -
    
    fileprivate func setUpView() {
        addSubview(dateLabel)
        addSubview(contentLabel)
    }
    
    
    // MARK: - Layout Views -
    
    fileprivate func setLayout() {
        dateLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(self).inset(8)
            make.left.right.equalTo(self).inset(20)
        }
        
        contentLabel.snp.remakeConstraints { (make) in
            make.top.equalTo(dateLabel.snp.bottom).inset(-8)
            make.left.right.equalTo(self).inset(12)
            make.bottom.equalTo(self).inset(16)
        }
    }
    
    
    // MARK: - Update -
    
    func update(comment: Comment) {
        dateLabel.text = comment.date.mediumString
        contentLabel.text = comment.content
    }
}
