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
    
    var commentingTweetVariable: Variable<Tweet>
    var commentingTweetToken: NotificationToken?

    
    
    // MARK: - Life Cycle Events -
    
    init?(tweetId: Int) {
        let realm = try! Realm()
        guard let tweet = realm.object(ofType: Tweet.self, forPrimaryKey: tweetId) else {
            return nil
        }
        commentingTweetVariable = Variable(tweet)
        commentingTweetToken = tweet.addNotificationBlock { [weak self] change in
            self?.commentingTweetVariable.value = tweet
        }
    }
    
    deinit {
        commentingTweetToken?.stop()
    }
}
