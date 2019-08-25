//
//  FolderDao.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/23.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation

protocol FolderDaoDelegate: class {
    func caughtError(folderDao: FolderDao, error: Error)
}

final class FolderDao {

    weak var delegate: (FolderDaoDelegate & TaskDaoDelegate)?
    private var taskDao: TaskDao

    init() {
        taskDao = TaskDao()
        taskDao.delegate = delegate
    }

    /// フォルダを新規登録する
    func add(entity: FolderEntity) {
        let dao = RealmDaoHelper<FolderEntity>()
        let object = FolderEntity(value: entity)
        do {
            try dao.add(d: object)
        } catch {
            print("add(entity: FolderEntity)", error)
            delegate?.caughtError(folderDao: self, error: error)
        }
    }

    /// 対象フォルダ内のタスクを全部削除する
    ///
    /// フォルダの更新日を現在の日付で更新する
    func deleteAllTasks(folderId: Int) {
        
        guard let folder = findById(folderId: folderId) else {
            return
        }

        do {
            try RealmDaoHelper.transaction { [weak self] in

                guard let weakSelf = self else {
                    return
                }
                // フォルダ内のタスクを削除
                let taskIds = Array(folder.taskList).map { $0.taskId }
                weakSelf.taskDao.delete(taskIds: taskIds)

                let now = Date()
                // フォルダを更新
                let updatedFolder = FolderEntity(
                    folderId: folder.folderId,
                    title: folder.title,
                    lastUpdated: now,
                    taskList: []
                )
                weakSelf.update(entity: updatedFolder)
            }
        } catch {
            print("deleteAllTasks(folderId: Int)", error)
            delegate?.caughtError(folderDao: self, error: error)
        }
    }

    /// 対象フォルダを削除する(フォルダ内のタスクは削除しない)
    func delete(folderId: Int) {
        guard let folder = findById(folderId: folderId) else {
            return
        }
        let dao = RealmDaoHelper<FolderEntity>()

        do {
            try dao.delete(d: folder)
        } catch {
            print("delete(folderId: Int)", error)
            delegate?.caughtError(folderDao: self, error: error)
        }
    }

    /// フォルダ情報を更新する
    func update(entity: FolderEntity) {
        let dao = RealmDaoHelper<FolderEntity>()
        do {
            try dao.update(d: entity)
        } catch {
            print("update(entity: FolderEntity)", error)
            delegate?.caughtError(folderDao: self, error: error)
        }
    }

    /// folderIdを指定して、フォルダ情報を取得する
    func findById(folderId: Int) -> FolderEntity? {
        let dao = RealmDaoHelper<FolderEntity>()
        return dao.findById(id: folderId)
    }
}
