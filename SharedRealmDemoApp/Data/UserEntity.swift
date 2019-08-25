//
//  UserEntity.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/25.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation
import RealmSwift

final class UserEntity: RealmSwift.Object {
    
    /// ID
    @objc dynamic var userId = 1
    /// 姓
    @objc dynamic var familyName = "テスト"
    /// 名
    @objc dynamic var givenName = "太郎"
    /// 生年月日
    @objc dynamic var birthday = Date()
    /// 郵便番号
    @objc dynamic var postalCode = ""
    /// 住所
    @objc dynamic var address = ""
    /// 電話番号
    @objc dynamic var phoneNumber = ""
    /// 携帯電話番号
    @objc dynamic var mobileNumber: String?
    
    let taskList = List<TaskEntity>()
    
    override static func primaryKey() -> String? {
        return "userId"
    }
    
    /// Standalone objectのイニシャライザ
    ///
    /// Object.init()のoverrideはサポートされていないため、Initializerを追加する場合はConvenience Initializerを実装する
    ///
    /// - Parameters:
    ///   - userId: ID
    ///   - familyName: 姓
    ///   - givenName: 名
    ///   - birthday: 生年月日
    ///   - postalCode: 郵便番号
    ///   - address: 住所
    ///   - phoneNumber: 電話番号
    ///   - mobileNumber: 携帯電話番号
    ///   - taskList: ユーザに紐づくタスクリスト
    convenience init(userId: Int = 1,
                     familyName: String,
                     givenName: String,
                     birthday: Date,
                     postalCode: String,
                     address: String,
                     phoneNumber: String,
                     mobileNumber: String?,
                     taskList: [TaskEntity] = [])
    {
        self.init()
        self.userId = userId
        self.familyName = familyName
        self.givenName = givenName
        self.birthday = birthday
        self.postalCode = postalCode
        self.address = address
        self.phoneNumber = phoneNumber
        self.mobileNumber = mobileNumber
        self.taskList.append(objectsIn: taskList)
    }
}

extension UserEntity {
    
    /// 現在の年齢を取得する
    ///
    /// - warning:
    /// Calendarは、Locale(identifier: "ja_JP"), TimeZone(identifier: "Asia/Tokyo")の前提
    /// - Returns: 現在の年齢
    func currentAge() -> Int? {
        let calendar = Calendar.gregorianJST()
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: self.birthday, to: now)
        let age = ageComponents.year
        print("Current age", age ?? 0)
        return age
    }
}
