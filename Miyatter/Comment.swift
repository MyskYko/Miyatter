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
    dynamic var date: NSDate?
    dynamic var content = ""
    dynamic var tweet: Tweet?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}
