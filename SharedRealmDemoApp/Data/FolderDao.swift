//
//  FolderDao.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/23.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

final class FolderDao {
    static func add(entity: FolderEntity) {
        let dao = RealmDaoHelper<FolderEntity>()
        let object = FolderEntity(value: entity)
        dao.realm.add(object)
    }
    
    static func deleteAllTasks(folderId: Int) {
        
        guard let folder = findById(folderId: folderId) else {
            return
        }
        
        RealmDaoHelper.transaction {
            // フォルダ内のタスクを削除
            folder.taskList.forEach {
                TaskDao.delete(taskId: $0.taskId)
            }
            
            // フォルダを更新
            let updatedFolder = FolderEntity(
                folderId: folder.folderId,
                title: folder.title,
                lastUpdated: folder.lastUpdated,
                taskList: []
            )
            update(entity: updatedFolder)
        }
    }
    
    static func update(entity: FolderEntity) {
        let dao = RealmDaoHelper<FolderEntity>()
        dao.realm.add(entity, update: .modified)
    }
    
    static func findById(folderId: Int) -> FolderEntity? {
        let dao = RealmDaoHelper<FolderEntity>()
        guard let object = dao.findById(id: folderId as AnyObject) else {
            return nil
        }
        return FolderEntity(value: object)
    }
}
