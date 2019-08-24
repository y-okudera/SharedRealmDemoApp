//
//  RealmInitializer.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/17.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmInitializer: RealmInitializerCompatible {
    
    let configuration: Realm.Configuration?
    
    init(configuration: Realm.Configuration? = defaultConfiguration()) {
        self.configuration = configuration
    }
    
    static func defaultConfiguration() -> Realm.Configuration {
        let configuration = Realm.Configuration()
        return configuration
    }
    
    /// 暗号化キーを取得する
    static func encryptionKey() -> Data? {
        let keyString = "ssuMMd3a97IIGbGxF4kLP6y0Vf723qklg8IaIZHEQgUNnb9lE1W1wx4nlLCgQa0p"
        let keyData = keyString.data(using: .utf8)
        
        #if DEBUG
        print("Realm encryptionKey -> " + keyData!.map { String(format: "%.2hhx", $0) }.joined())
        #endif
        
        return keyData
    }
}
