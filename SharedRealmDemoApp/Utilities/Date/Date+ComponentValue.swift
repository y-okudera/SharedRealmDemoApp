//
//  Date+ComponentValue.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/19.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

private extension Date {

    private var calendar: Calendar {
        return .gregorianJST()
    }

    private mutating func setComponentValue(_ value: Int, for component: Calendar.Component) {
        var components = calendar.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self)
        components.setValue(value, for: component)
        if let date = calendar.date(from: components) {
            self = date
        }
    }
}

extension Date {
    
    init(year: Int? = nil, month: Int? = nil, day: Int? = nil, hour: Int? = nil, minute: Int? = nil, second: Int? = nil) {
        self.init()
        if let year = year {
            self.year = year
        }
        if let month = month {
            self.month = month
        }
        if let day = day {
            self.day = day
        }
        if let hour = hour {
            self.hour = hour
        }
        if let minute = minute {
            self.minute = minute
        }
        if let second = second {
            self.second = second
        }
    }

    var year: Int {
        get {
            return calendar.component(.year, from: self)
        }
        set {
            setComponentValue(newValue, for: .year)
        }
    }

    var month: Int {
        get {
            return calendar.component(.month, from: self)
        }
        set {
            setComponentValue(newValue, for: .month)
        }
    }

    var day: Int {
        get {
            return calendar.component(.day, from: self)
        }
        set {
            setComponentValue(newValue, for: .day)
        }
    }

    var hour: Int {
        get {
            return calendar.component(.hour, from: self)
        }
        set {
            setComponentValue(newValue, for: .hour)
        }
    }

    var minute: Int {
        get {
            return calendar.component(.minute, from: self)
        }
        set {
            setComponentValue(newValue, for: .minute)
        }
    }

    var second: Int {
        get {
            return calendar.component(.second, from: self)
        }
        set {
            setComponentValue(newValue, for: .second)
        }
    }
}
