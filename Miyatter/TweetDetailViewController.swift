//
//  TweetDetailViewController.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/28.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import UIKit
import RxSwift

class TweetDetailViewController: UIViewController {
    
    // MARK: - Properties -
    
    fileprivate let viewModel: TweetDetailViewModel
    fileprivate let disposeBag = DisposeBag()
    
    
    // MARK: - View -
    
    fileprivate lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    fileprivate lazy var commentButton: UIButton = {
        let button = UIButton()
        button.setTitle("コメント作成", for: .normal)
        button.titleLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 20)
        return button
    }()
    
    fileprivate lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("戻る", for: .normal)
        button.titleLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 20)
        return button
    }()
    
    fileprivate lazy var tableView: UITableView = {
        let table = UITableView()
        table.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
        table.register(CommentCell.self, forCellReuseIdentifier: "CommentCell")
        table.estimatedRowHeight = 40
        table.rowHeight = UITableViewAutomaticDimension
        table.dataSource = self
        return table
    }()
    
    
    // MARK: - Life Cycle Events -
    
    init(viewModel: TweetDetailViewModel) {
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
        view.backgroundColor = UIColor.white
        view.addSubview(headerView)
        headerView.addSubview(backButton)
        view.addSubview(commentButton)
        view.addSubview(tableView)
    }
    
    
    // MARK: - Layout Views -
    
    fileprivate func setLayout() {
        headerView.snp.remakeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.height.equalTo(64)
        }
        
        backButton.snp.remakeConstraints { (make) in
            make.top.equalTo(headerView).inset(32)
            make.left.equalTo(headerView).inset(20)
            make.height.equalTo(22)
        }
        
        commentButton.snp.remakeConstraints { (make) in
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
        commentButton.rx
            .tap
            .subscribe(onNext: { [unowned self] in
                let viewModel = CreateCommentViewModel(tweetId: self.viewModel.commentingTweetVariable.value.id)
                self.present(
                    CreateCommentViewController(viewModel: viewModel),
                    animated: true,
                    completion: nil)
            })
            .disposed(by: disposeBag)
        
        backButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        viewModel.commentingTweetVariable.asObservable()
            .subscribe(onNext: { [weak self] tweet in
            self?.tableView.reloadData()
        })
        .disposed(by: disposeBag)
    }
}


// MARK: - TableViewDataSource -

extension TweetDetailViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
                return 1
        }
        else {
            return viewModel.commentingTweetVariable.value.comments.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as! TweetCell
            cell.update(tweet: viewModel.commentingTweetVariable.value)
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell") as! CommentCell
            cell.update(comment: viewModel.commentingTweetVariable.value.comments[indexPath.row])
            return cell
        }
    }
}
