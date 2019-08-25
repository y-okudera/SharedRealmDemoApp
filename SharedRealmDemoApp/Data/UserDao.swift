//
//  UserDao.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/25.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation
import RealmSwift

protocol UserDaoDelegate: class {
    /// Databaseエラーを検出
    func didCatchDBError(userDao: UserDao, error: Error)
}

final class UserDao {
    
    weak var delegate: (UserDaoDelegate & TaskDaoDelegate)?
    private var taskDao: TaskDao
    
    init() {
        taskDao = TaskDao()
        taskDao.delegate = delegate
    }
    
    // MARK: - ADD
    
    /// ユーザを新規登録する
    func add(user: UserEntity) {
        let dao = RealmDaoHelper<UserEntity>()
        let object = UserEntity(value: user)
        do {
            try dao.add(d: object)
        } catch {
            print("add(user: UserEntity) ERROR", error)
            delegate?.didCatchDBError(userDao: self, error: error)
        }
    }
    
    /// ユーザを新規登録する(複数)
    func add(users: [UserEntity]) {
        let dao = RealmDaoHelper<UserEntity>()
        var objects = [UserEntity]()
        users.forEach {
            let object = UserEntity(value: $0)
            objects.append(object)
        }
        
        do {
            try dao.add(objects: objects)
        } catch {
            print("add(users: [UserEntity]) ERROR", error)
            delegate?.didCatchDBError(userDao: self, error: error)
        }
    }
    
    // MARK: - DELETE
    
    /// 対象ユーザに紐づくタスクを全部削除する
    func deleteAllTasks(userId: Int) {
        guard let user = findById(userId: userId) else {
            return
        }
        
        do {
            try RealmDaoHelper.transaction { [weak self] in
                
                guard let weakSelf = self else {
                    return
                }
                // ユーザに紐づくタスクを削除
                let taskIds = Array(user.taskList).map { $0.taskId }
                weakSelf.taskDao.delete(taskIds: taskIds)
            }
        } catch {
            print("deleteAllTasks(userId: Int) ERROR", error)
            delegate?.didCatchDBError(userDao: self, error: error)
        }
    }
    
    /// 対象ユーザを削除する(ユーザに紐づくタスクは削除しない)
    func delete(userId: Int) {
        guard let user = findById(userId: userId) else {
            return
        }
        let dao = RealmDaoHelper<UserEntity>()
        
        do {
            try dao.delete(d: user)
        } catch {
            print("delete(userId: Int) ERROR", error)
            delegate?.didCatchDBError(userDao: self, error: error)
        }
    }
    
    // MARK: - UPDATE
    
    /// ユーザ情報を更新する
    func update(user: UserEntity) {
        let dao = RealmDaoHelper<UserEntity>()
        do {
            try dao.update(d: user)
        } catch {
            print("update(user: UserEntity) ERROR", error)
            delegate?.didCatchDBError(userDao: self, error: error)
        }
    }
    
    // MARK: - FIND
    
    /// userIdを指定して、ユーザ情報を取得する
    func findById(userId: Int) -> UserEntity? {
        let dao = RealmDaoHelper<UserEntity>()
        return dao.findById(id: userId)
    }
    
    /// userIdを複数指定して、ユーザ情報を取得する
    func findByIds(userIds: [Int]) -> Results<UserEntity>? {
        let dao = RealmDaoHelper<UserEntity>()
        return dao.findByIds(ids: userIds)
    }
}
