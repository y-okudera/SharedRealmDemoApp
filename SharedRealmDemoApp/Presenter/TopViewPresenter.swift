//
//  TopViewPresenter.swift
//  SharedRealmDemoApp
//
//  Created by YukiOkudera on 2019/08/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

protocol TopViewPresentation: class {
    func createDummyData()
    func raiseError()
    func deleteAllTasks(folderId: Int)
    func delete(folderId: Int)
}

final class TopViewPresenter {

    private weak var view: TopView?
    private let folderDao = FolderDao()
    private let taskDao = TaskDao()

    init(view: TopView) {
        self.view = view

        folderDao.delegate = self
        taskDao.delegate = self
    }
}

extension TopViewPresenter: TopViewPresentation {

    /// データ追加(ダミーデータ)
    func createDummyData() {

        guard let startTaskId = RealmDaoHelper<TaskEntity>().newId() else {
            return
        }
        var tasks = [TaskEntity]()
        for id in startTaskId ... startTaskId + 9 {
            let task = TaskEntity(taskId: id, title: "タスク\(id)", limitDate: Date())
            tasks.append(task)
        }

        guard let newFolderId = RealmDaoHelper<FolderEntity>().newId() else {
            return
        }
        let folder = FolderEntity(folderId: newFolderId, title: "フォルダ\(newFolderId)", lastUpdated: Date(), taskList: tasks)

        // Realmにデータを登録する
        folderDao.add(entity: folder)
    }

    /// エラーを発生させる(エラー時の動作確認)
    func raiseError() {

        var tasks = [TaskEntity]()
        let task = TaskEntity(taskId: 1, title: "タスク1", limitDate: Date())
        tasks.append(task)

        let folder = FolderEntity(folderId: 1, title: "フォルダ1", lastUpdated: Date(), taskList: tasks)

        // Realmにデータを登録する
        folderDao.add(entity: folder)

        // Realmにデータを登録する(primary key重複発生)
        folderDao.add(entity: folder)
    }

    /// 指定フォルダ内のタスクを全部削除する(フォルダは削除しない)
    ///
    /// フォルダの更新日を現在の日付で更新する
    func deleteAllTasks(folderId: Int) {
        folderDao.deleteAllTasks(folderId: folderId)
    }

    /// 指定フォルダを削除する(フォルダ内のタスクは削除しない)
    func delete(folderId: Int) {
        folderDao.delete(folderId: folderId)
    }
}

extension TopViewPresenter: FolderDaoDelegate {
    func caughtError(folderDao: FolderDao, error: Error) {
        view?.showAlert(title: "エラー", message: "フォルダ情報の更新に失敗しました。")
    }
}

extension TopViewPresenter: TaskDaoDelegate {
    func caughtError(taskDao: TaskDao, error: Error) {
        view?.showAlert(title: "エラー", message: "タスク情報の更新に失敗しました。")
    }
}
