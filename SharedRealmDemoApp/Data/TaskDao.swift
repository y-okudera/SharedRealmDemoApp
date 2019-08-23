//
//  TaskDao.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/23.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

final class TaskDao {
    static func add(entity: TaskEntity) {
        let dao = RealmDaoHelper<TaskEntity>()
        let object = TaskEntity(value: entity)
        dao.add(d: object)
    }
    
    static func delete(taskId: Int) {
        let dao = RealmDaoHelper<TaskEntity>()
        guard let object = dao.findById(id: taskId as AnyObject) else {
            return
        }
        dao.delete(d: object)
    }
}
