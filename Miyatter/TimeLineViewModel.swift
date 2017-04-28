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
    fileprivate var token: NotificationToken?
    
    
    // MARK: - Life Cycle Events -
    
    init() {
        let realm = try! Realm()
        tweetVariable = Variable(realm.objects(Tweet.self).sorted(byKeyPath: "date", ascending: false))
        token = realm.addNotificationBlock({ [weak self] note, realm in
            self?.tweetVariable.value = realm.objects(Tweet.self).sorted(byKeyPath: "date", ascending: false)
        })
    }
}
