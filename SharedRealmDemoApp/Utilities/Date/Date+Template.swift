//
//  Date+Template.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/25.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

extension DateFormatter {
    // テンプレートの定義
    enum Template: String {
        case date = "yMd" // 2017/1/1
        case time = "Hms" // 12:39:22
        case full = "yMdHmsSSS" // 2017/1/1 12:39:22
        case onlyHour = "k"   // 17時
        case era = "GG"       // "西暦" (default) or "平成" (本体設定で和暦を指定している場合)
        case weekDay = "EEEE" // 日曜日
    }

    func setTemplate(_ template: Template) {
        dateFormat = DateFormatter.dateFormat(fromTemplate: template.rawValue, options: 0, locale: .current)
    }
}

extension Date {
    
    /// 端末で設定されているLocaleに応じたカスタムフォーマット
    func toString(template: DateFormatter.Template) -> String {
        let dateFormatter = DateFormatter.sharedFormatter()
        dateFormatter.setTemplate(template)
        return dateFormatter.string(from: self)
    }
}
