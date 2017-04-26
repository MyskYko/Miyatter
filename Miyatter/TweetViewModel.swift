//
//  TweetViewModel.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/26.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

class TweetViewModel {
    
    // MARK: - Properties -

    fileprivate let disposeBag = DisposeBag()
    
    
    // MARK: - Inputs -
    
    var submitTweet = PublishSubject<String>()
    
    
    // MARK: - Initializers -
    
    init() {
        submitTweet
            .subscribe(onNext: { (text) in
                let realm = try! Realm()
                let tweet = Tweet()
                tweet.content = text
                tweet.date = NSDate()
                try! realm.write() {
                    realm.add(tweet)
                }
            })
            .disposed(by: disposeBag)
    }
}
