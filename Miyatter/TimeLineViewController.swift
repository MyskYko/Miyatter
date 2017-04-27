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
    
    fileprivate let viewModel: TimeLineViewModel
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
        table.estimatedRowHeight = 40
        table.rowHeight = UITableViewAutomaticDimension
        return table
    }()
    
    
    // MARK: - Life Cycle Events -
    
    init(viewModel: TimeLineViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
                self?.present(MakeTweetViewController(viewModel: MakeTweetViewModel()), animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.tweetVariable.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "TweetCell", cellType: TweetCell.self)) { index, tweet, cell in
            cell.setLabels(date: self.stringFromDate(date: tweet.date), content: tweet.content, commentCount: "コメント数:\(tweet.comments.count)")
        }
        .disposed(by: disposeBag)
    }
    
    fileprivate func stringFromDate(date: Date) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: date)
    }
}
