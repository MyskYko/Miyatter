//
//  CreatePostViewModel.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/29.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

enum PostType: Int {
    case tweet = 1
    case comment = 2
}

class CreatePostViewModel {
    
    // MARK: - Properties -
    
    fileprivate let disposeBag = DisposeBag()
    let postType: PostType
    
    
    // MARK: - Inputs -
    
    var submitPost = PublishSubject<String>()
    
    
    // MARK: - Initializers -
    
    init() {
        postType = .tweet
        submitPost
            .subscribe(onNext: { (text) in
                let realm = try! Realm()
                try! realm.write() {
                    let tweet = Tweet()
                    tweet.content = text
                    tweet.setId()
                    realm.add(tweet)
                }
            })
            .disposed(by: disposeBag)
    }
    
    init(tweetId: Int) {
        postType = .comment
        submitPost
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
