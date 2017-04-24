//
//  MakeTweetViewController.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/24.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import UIKit

class MakeTweetViewController: UIViewController {
    
    // MARK: - View -
    
    private lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    private lazy var tweetTextView: UITextView = {
        let text = UITextView()
        text.layer.borderColor = UIColor.darkGray.cgColor
        text.layer.borderWidth = 1
        text.textAlignment = NSTextAlignment.left
        return text
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("戻る", for: .normal)
        button.titleLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 20)
        button.addTarget(self, action: #selector(tapBackButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle("投稿", for: .normal)
        button.titleLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 20)
        button.backgroundColor = UIColor.lightGray
        return button
    }()
    
    // MARK: - Life Cycle Events -

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpView()
        setLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    // MARK: - Set Up Views -

    private func setUpView() {
        view.backgroundColor = UIColor.white
        view.addSubview(headerView)
        headerView.addSubview(backButton)
        view.addSubview(tweetTextView)
        view.addSubview(submitButton)
    }
    
    // MARK: - Layout Views -
    
    private func setLayout() {
        headerView.snp.remakeConstraints { (make) in
            make.top.left.right.equalTo(view)
            make.height.equalTo(64)
        }
        
        backButton.snp.remakeConstraints { (make) in
            make.top.equalTo(headerView).inset(32)
            make.left.equalTo(headerView).inset(20)
            make.height.equalTo(22)
        }
        
        tweetTextView.snp.remakeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).inset(-20)
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(200)
        }
        
        submitButton.snp.remakeConstraints { (make) in
            make.top.equalTo(tweetTextView.snp.bottom).inset(-8)
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(32)
        }
    }
    
    // MARK: - View Transition -
    
    func tapBackButton() {
        self.dismiss(animated: true, completion: nil)
    }

}
