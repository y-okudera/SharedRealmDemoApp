//
//  Calendar+Extensions.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/19.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

extension Calendar {

    /// Calendarインスタンス
    ///
    /// Locale(identifier: "ja_JP")
    ///
    /// TimeZone(identifier: "Asia/Tokyo")!
    static func gregorianJST() -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = .jaJp
        calendar.timeZone = .jst
        return calendar
    }

    /// Calendarインスタンス
    ///
    /// Locale.current
    ///
    /// TimeZone.current
    static func gregorianCurrent() -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = .current
        calendar.timeZone = .current
        return calendar
    }

    /// Calendarインスタンス
    ///
    /// Locale.autoupdatingCurrent
    ///
    /// TimeZone.autoupdatingCurrent
    static func gregorianAutoupdatingCurrent() -> Calendar {
        var calendar = Calendar(identifier: .gregorian)
        calendar.locale = .autoupdatingCurrent
        calendar.timeZone = .autoupdatingCurrent
        return calendar
    }
}
