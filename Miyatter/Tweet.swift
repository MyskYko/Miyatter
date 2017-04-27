//
//  Tweet.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/25.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift

class Tweet: Object {
    dynamic var id = 0
    dynamic var date = Date()
    dynamic var content = ""
    let comments = List<Comment>()
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
    
    func setId() {
        let realm = try! Realm()
        if let lastTweet = realm.objects(Tweet.self).sorted(byKeyPath: "id", ascending: true).last {
            id = lastTweet.id + 1
        }
    }
}
