//
//  Comment.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/25.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation
import RealmSwift

class Comment: Object {
    dynamic var id = 0
    dynamic var date = Date()
    dynamic var content = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["id"]
    }
    
    /// call in write transaction
    func setId() {
        let realm = try! Realm()
        if let lastComment = realm.objects(Comment.self).sorted(byKeyPath: "id", ascending: true).last {
            id = lastComment.id + 1
        }
    }
}
