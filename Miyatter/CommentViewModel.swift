//
//  CommentViewModel.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/28.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift



final class CommentViewModel {
    
    // MARK: - Properties -
    
    var tweet: Tweet
    var comments: List<Comment>
    
    
    // MARK: - Life Cycle Events -
    
    init(selected: Tweet) {
        tweet = selected
                print(tweet)
        
        comments = tweet.comments
    }
}
