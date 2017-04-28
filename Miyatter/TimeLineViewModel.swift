//
//  TimeLineViewModel.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/27.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift
import RxSwift

final class TimeLineViewModel {
    
    // MARK: - Properties -
    
    var tweetVariable: Variable<Results<Tweet>>
    fileprivate var tweetToken: NotificationToken?
    
    
    // MARK: - Life Cycle Events -
    
    init() {
        let realm = try! Realm()
        let results = realm.objects(Tweet.self).sorted(byKeyPath: "date", ascending: false)
        tweetVariable = Variable(results)
        tweetToken = results.addNotificationBlock({ [weak self] (changes: RealmCollectionChange) in
            self?.tweetVariable.value = results
        })
    }
    
    deinit{
        tweetToken?.stop()
    }
}
