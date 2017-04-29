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
    
    var tweetsVariable: Variable<Results<Tweet>>
    fileprivate var tweetsToken: NotificationToken?
    
    
    // MARK: - Life Cycle Events -
    
    init() {
        let realm = try! Realm()
        let results = realm.objects(Tweet.self).sorted(byKeyPath: "date", ascending: false)
        tweetsVariable = Variable(results)
        tweetsToken = results.addNotificationBlock { [weak self] (changes: RealmCollectionChange) in
            self?.tweetsVariable.value = results
        }
    }
    
    deinit {
        tweetsToken?.stop()
    }
}
