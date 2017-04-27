//
//  Date+Extension.swift
//  Miyatter
//
//  Created by miyasaka on 2017/04/27.
//  Copyright © 2017年 miyacc. All rights reserved.
//

import Foundation

extension Date {
    var mediumString: String {
        let formatter: DateFormatter = DateFormatter()
        formatter.locale = Locale(identifier: "ja_JP")
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        return formatter.string(from: self)
    }
}
