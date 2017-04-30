//
//  CreateCommentViewModel.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/29.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

final class CreateCommentViewModel: CreateFormViewModel {
    
    // MARK: - Properties -
    
    let disposeBag:DisposeBag = DisposeBag()
    
    let buttonTitle = "コメント投稿"
    
    
    // MARK: - Inputs -
    
    let submitForm = PublishSubject<String>()
    
    
    // MARK: - Initializers -
    
    init(tweetId: Int) {
        submitForm
            .subscribe(onNext: { (text) in
                let realm = try! Realm()
                try! realm.write() {
                    let comment = Comment()
                    comment.content = text
                    comment.setId()
                    if let tweet = realm.object(ofType: Tweet.self, forPrimaryKey: tweetId) {
                        tweet.comments.append(comment)
                        realm.add(comment)
                    }
                    else {
                        //error
                    }
                }
            })
            .disposed(by: disposeBag)
    }
}
