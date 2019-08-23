//
//  FolderEntity.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/23.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation
import RealmSwift

final class FolderEntity: RealmSwift.Object {
    
    @objc dynamic var folderId = 1
    @objc dynamic var title = ""
    @objc dynamic var lastUpdated: Date?
    let taskList = List<TaskEntity>()
    
    override static func primaryKey() -> String? {
        return "folderId"
    }
    
    /*
     RealmSwift.Objectを継承したモデルクラスにInitializerを追加する場合はConvenience Initializerを実装する
     （Object.init()のoverrideはサポートされていないため）
     */
    convenience init(folderId: Int = 1, title: String, lastUpdated: Date?, taskList: [TaskEntity] = []) {
        self.init()
        self.folderId = folderId
        self.title = title
        self.lastUpdated = lastUpdated
        self.taskList.append(objectsIn: taskList)
    }
}
