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
            print("delete(taskId: Int)", error)
            delegate?.caughtError(taskDao: self, error: error)
            return false
        }
    }
}
