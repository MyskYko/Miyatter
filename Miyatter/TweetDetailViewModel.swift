//
//  TweetDetailViewModel.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/28.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

final class TweetDetailViewModel {
    
    // MARK: - Properties -
    
    let tweet: Tweet!
    let comments: List<Comment>
    
    
    // MARK: - Life Cycle Events -
    
    init(tweetId: Int) {
        let realm = try! Realm()
        if let tweet = realm.object(ofType: Tweet.self, forPrimaryKey: tweetId) {
            self.tweet = tweet
            comments = tweet.comments
        }
        else {
            //error
            self.tweet = nil
            self.comments = List<Comment>()
        }
    }
}
