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
        table.dataSource = self
        table.delegate = self
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
        if let selectedRow = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: selectedRow, animated: true)
        }
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
                self.present(
                    CreateFormViewController(viewModel: CreateTweetViewModel()),
                    animated: true,
                    completion: nil)
            })
            .disposed(by: disposeBag)
        

        viewModel.tweetsVariable.asObservable()
            .subscribe(onNext: { [weak self] tweets in
                self?.tableView.reloadData()
            })
            .disposed(by: disposeBag)
    }
}


// MARK: - TableViewDataSource -

extension TimeLineViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.tweetsVariable.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
        cell.update(tweet: viewModel.tweetsVariable.value[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        let tweetId = viewModel.tweetsVariable.value[indexPath.row].id
        viewModel.delete(tweetId: tweetId)
    }
}


// MARK: - TableViewDelegate -

extension TimeLineViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweet = self.viewModel.tweetsVariable.value[indexPath.row]
        if let viewModel = TweetDetailViewModel(tweetId: tweet.id) {
            self.navigationController?.pushViewController(
                TweetDetailViewController(viewModel: viewModel),
                animated: true)
        }
    }
}
