//
//  MakeTweetViewModel.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/26.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

final class MakeTweetViewModel {
    
    // MARK: - Properties -

    fileprivate let disposeBag = DisposeBag()
    
    
    // MARK: - Inputs -
    
    var submitTweet = PublishSubject<String>()
    
    
    // MARK: - Initializers -
    
    init() {
        submitTweet
            .subscribe(onNext: { (text) in
                let realm = try! Realm()
                try! realm.write() {
                    let tweet = Tweet()
                    tweet.content = text
                    if let lastTweet = realm.objects(Tweet.self).sorted(byKeyPath: "id", ascending: true).last {
                        tweet.id = lastTweet.id + 1
                    }
                    realm.add(tweet)
                }
            })
            .disposed(by: disposeBag)
    }
}
