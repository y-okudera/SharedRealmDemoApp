//
//  Date+Style.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/19.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

extension Date {
    
    func toStringMediumStyle() -> String {
        return toString(dateStyle: .medium, timeStyle: .medium)
    }
    
    func toString(dateStyle: DateFormatter.Style, timeStyle: DateFormatter.Style) -> String {
        let dateFormatter = DateFormatter.sharedFormatter()
        dateFormatter.dateStyle = dateStyle
        dateFormatter.timeStyle = timeStyle
        dateFormatter.locale = .jaJp
        return dateFormatter.string(from: self)
    }
}
