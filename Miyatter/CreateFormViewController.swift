//
//  CreateFormViewController.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/29.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import UIKit
import SnapKit
import RxSwift

class CreateFormViewController: UIViewController {
    
    // MARK: - Properties -
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let viewModel: CreateFormViewModel
    
    
    // MARK: - View -
    
    fileprivate lazy var headerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    fileprivate lazy var formTextView: UITextView = {
        let text = UITextView()
        text.layer.borderColor = UIColor.darkGray.cgColor
        text.layer.borderWidth = 1
        text.textAlignment = .left
        return text
    }()
    
    fileprivate lazy var backButton: UIButton = {
        let button = UIButton()
        button.setTitle("戻る", for: .normal)
        button.titleLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 20)
        return button
    }()
    
    fileprivate lazy var submitButton: UIButton = {
        let button = UIButton()
        button.setTitle(self.viewModel.buttonTitle, for: .normal)
        button.titleLabel?.font = UIFont(name: "HiraKakuProN-W3", size: 20)
        button.backgroundColor = UIColor.lightGray
        return button
    }()
    
    
    // MARK: - Life Cycle Events -
    
    init(viewModel: CreateFormViewModel) {
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
        view.addSubview(formTextView)
        view.addSubview(submitButton)
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
        
        formTextView.snp.remakeConstraints { (make) in
            make.top.equalTo(headerView.snp.bottom).inset(-20)
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(200)
        }
        
        submitButton.snp.remakeConstraints { (make) in
            make.top.equalTo(formTextView.snp.bottom).inset(-8)
            make.left.right.equalTo(view).inset(16)
            make.height.equalTo(32)
        }
    }
    
    
    // MARK: - Bind -
    
    fileprivate func bindView() {
        backButton.rx
            .tap
            .subscribe(onNext: { [weak self] in
                self?.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
        
        submitButton.rx
            .tap
            .subscribe(onNext: { [unowned self] in
                self.viewModel.submitForm.onNext(self.formTextView.text)
                self.dismiss(animated: true, completion: nil)
            })
            .disposed(by: disposeBag)
    }
}
