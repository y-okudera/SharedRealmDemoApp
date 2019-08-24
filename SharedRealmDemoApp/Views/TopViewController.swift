//
//  TopViewController.swift
//  SharedRealmDemoApp
//
//  Created by YukiOkudera on 2019/08/24.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import UIKit

protocol TopView: class {
    func showAlert(title: String, message: String)
}

final class TopViewController: UIViewController {
    
    lazy var presenter: TopViewPresentation! = TopViewPresenter(view: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let path = NSHomeDirectory()
        print("HomeDirectory:", path)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        // ダミーデータを登録
        presenter.createDummyData()
        
        // Realmのエラーを発生させる
//        presenter.raiseError()

        // folderIdが1のフォルダ内のタスクを全部削除する(フォルダは削除しない)
        // フォルダの更新日を現在の日付で更新する
        presenter.deleteAllTasks(folderId: 1)

        // folderIdが1のフォルダを削除する(フォルダ内のタスクは削除しない)
//        presenter.delete(folderId: 1)
    }
}

extension TopViewController: TopView {
    func showAlert(title: String, message: String) {
        UIAlertController.alert(on: self, title: title, message: message)
    }
}
