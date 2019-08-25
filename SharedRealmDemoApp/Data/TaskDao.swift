//
//  TaskDao.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/23.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

protocol TaskDaoDelegate: class {
    func caughtError(taskDao: TaskDao, error: Error)
}

final class TaskDao {

    weak var delegate: TaskDaoDelegate?

    /// taskIdを指定して、タスクを削除する
    func delete(taskId: Int) -> Bool {
        let dao = RealmDaoHelper<TaskEntity>()
        guard let object = dao.findById(id: taskId) else {
            return false
        }

        do {
            try dao.delete(d: object)
            return true
        } catch {
            print("delete(taskId: Int) ERROR", error)
            delegate?.caughtError(taskDao: self, error: error)
            return false
        }
    }
    
    /// taskIdを複数指定して、タスクを削除する
    @discardableResult
    func delete(taskIds: [Int]) -> Bool {
        let dao = RealmDaoHelper<TaskEntity>()
        guard let objects = dao.findByIds(ids: taskIds) else {
            return false
        }
        
        do {
            try dao.delete(objects: objects)
            return true
        } catch {
            print("delete(taskIds: [Int]) ERROR", error)
            delegate?.caughtError(taskDao: self, error: error)
            return false
        }
    }
}
