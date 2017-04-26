//
//  ViewController.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/22.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift
import RxCocoa

class TimeLineViewController: UIViewController {
    
    // MARK: - Properties -
    
    fileprivate let disposeBag = DisposeBag()
    
    
    // MARK: - View -
    
    fileprivate lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    fileprivate lazy var tweetButton: UIButton = {
        let button = UIButton()
        button.setTitle("ツイート作成", for: .normal)
        button.titleLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 20)
        return button
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
        table.dataSource = self
        table.estimatedRowHeight = 40
        table.rowHeight = UITableViewAutomaticDimension
        return table
    }()
    
    
    // MARK: - Life Cycle Events -
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setLayout()
        bindView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    
    // MARK: - Set Up Views -
    
    fileprivate func setUpView() {
        view.addSubview(headerView)
        headerView.addSubview(tweetButton)
        view.addSubview(tableView)
    }
    
    
    // MARK: - Layout Views -
    
    fileprivate func setLayout() {
        headerView.snp.remakeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.height.equalTo(64)
        }
        
        tweetButton.snp.remakeConstraints { (make) in
            make.top.equalTo(headerView).inset(32)
            make.right.equalTo(headerView).inset(20)
            make.height.equalTo(22)
        }
        
        tableView.snp.remakeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom)
            make.left.right.bottom.equalTo(view)
        }
    }
    
    
    // MARK: - Bind -
    
    fileprivate func bindView() {
        tweetButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.present(MakeTweetViewController(), animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}

extension TimeLineViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        cell.dateLabel.text = "2016/4/24"
        cell.contentLabel.text = "ツイートの内容"
        cell.commentCountLabel.text = "コメント数:0"
        return cell
    }
}
