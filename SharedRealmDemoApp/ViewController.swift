//
//  ViewController.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/23.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import RealmSwift
import UIKit

final class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSHomeDirectory()
        print(path)
        
        let task1 = TaskEntity(taskId: 1, title: "タスク1", limitDate: nil)
        let task2 = TaskEntity(taskId: 2, title: "タスク2", limitDate: Date(timeInterval: TimeInterval(60 * 60 * 24 * -7), since: Date()))
        let task3 = TaskEntity(taskId: 3, title: "タスク3", limitDate: Date(timeInterval: TimeInterval(60 * 60 * 24 * 7), since: Date()))
        let task4 = TaskEntity(taskId: 4, title: "タスク4", limitDate: Date(timeInterval: TimeInterval(60 * 60 * 24 * 10), since: Date()))
        let task5 = TaskEntity(taskId: 5, title: "タスク5", limitDate: Date(timeInterval: TimeInterval(60 * 60 * 24 * 14), since: Date()))
        let folder = FolderEntity(folderId: 1, title: "Testフォルダ", lastUpdated: Date(), taskList: [task1, task2, task3])
        self.createNewData(tasks: [task4, task5], folder: folder)
        
        
        FolderDao.deleteAllTasks(folderId: 1)
    }
    
    /// データ追加
    ///
    /// - Parameters:
    ///   - tasks: タスク情報（フォルダに紐づかないタスク）
    ///   - folder: フォルダ情報
    private func createNewData(tasks: [TaskEntity], folder: FolderEntity) {
        
        let realm = Realm.sharedRealm()
        realm.beginWrite()
        do {
            // FolderテーブルのCRUD処理
            FolderDao.add(entity: folder)
            
            // TaskテーブルのCRUD処理
            tasks.forEach {
                TaskDao.add(entity: $0)
            }
            
            try realm.commitWrite()
            
        } catch _ {
            realm.cancelWrite()
        }
    }
}
