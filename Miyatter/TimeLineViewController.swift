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
            .subscribe(onNext: { [unowned self] in
                self.present(CreateTweetViewController(viewModel: CreateTweetViewModel()),
                             animated: true,
                             completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.tweetsVariable.asObservable()
            .bind(to: tableView.rx.items(cellIdentifier: "TweetCell", cellType: TweetCell.self)) { index, tweet, cell in
                cell.update(tweet: tweet)
        }
        .disposed(by: disposeBag)
        
        tableView.rx.itemSelected.subscribe(onNext: { [unowned self] IndexPath in
            let tweet = self.viewModel.tweetsVariable.value[IndexPath.row]
            let viewModel = TweetDetailViewModel(tweetId: tweet.id)
            self.present(TweetDetailViewController(viewModel: viewModel),
                              animated: true,
                              completion: nil)
            
        })
        .disposed(by: disposeBag)
    }
}
