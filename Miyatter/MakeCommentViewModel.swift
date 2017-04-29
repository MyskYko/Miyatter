//
//  MakeCommentViewModel.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/29.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

final class MakeCommentViewModel {
    // MARK: - Properties -
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate let tweet: Tweet
    
    
    // MARK: - Inputs -
    
    var submitComment = PublishSubject<String>()
    
    
    // MARK: - Initializers -
    
    init(selected: Tweet) {
        tweet = selected
        submitComment
            .subscribe(onNext: { (text) in
                let realm = try! Realm()
                try! realm.write() {
                    let comment = Comment()
                    comment.content = text
                    comment.setId()
                    self.tweet.comments.append(comment)
                    realm.add(comment)
                }
            })
            .disposed(by: disposeBag)
    }
}
