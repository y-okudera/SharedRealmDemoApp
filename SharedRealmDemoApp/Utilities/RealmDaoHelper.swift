//
//  RealmDaoHelper.swift
//  SharedRealmDemoApp
//
//  Created by Yuki Okudera on 2019/08/17.
//  Copyright © 2019 Yuki Okudera. All rights reserved.
//

import Foundation
import RealmSwift

final class RealmDaoHelper <T: RealmSwift.Object> {

    var realm: Realm

    init() {
        self.realm = Realm.sharedRealm()
    }

    // MARK: - Create a new primary key

    /// 新規主キー発行
    func newId() -> Int? {
        guard let key = T.primaryKey() else {
            print("primaryKey未設定")
            return nil
        }
        return (realm.objects(T.self).max(ofProperty: key) as Int? ?? 0) + 1
    }

    // MARK: - Add record

    /// レコード追加
    func add(d: T) {
        
        if RealmDaoHelper.isInWriteTransaction() {
            realm.add(d)
            return
        }
        
        do {
            try realm.write {
                realm.add(d)
            }
        } catch {
            print("Data registration error: \(error)")
        }
    }

    // MARK: - Update record

    /// T: RealmSwift.Object で primaryKey()が実装されている時のみ有効
    @discardableResult
    func update(d: T, block:(() -> Void)? = nil) -> Bool {
        
        if RealmDaoHelper.isInWriteTransaction() {
            block?()
            realm.add(d, update: .modified)
            return true
        }
        
        do {
            try realm.write {
                block?()
                realm.add(d, update: .modified)
            }
            return true
        } catch {
            print("Data update error: \(error)")
        }
        return false
    }

    // MARK: - Delete records

    /// レコード全削除
    func deleteAll() -> Bool {
        let objs = realm.objects(T.self)
        
        if RealmDaoHelper.isInWriteTransaction() {
            realm.delete(objs)
            return true
        }
        
        do {
            try realm.write {
                realm.delete(objs)
            }
            return true
        } catch {
            print("All data delete error: \(error)")
        }
        return false
    }

    /// レコード削除
    @discardableResult
    func delete(d: T) -> Bool {
        
        if RealmDaoHelper.isInWriteTransaction() {
            realm.delete(d)
            return true
        }
        
        do {
            try realm.write {
                realm.delete(d)
            }
            return true
        } catch {
            print("Data delete error: \(error)")
        }
        return false
    }

    // MARK: - Find records

    /// 全件取得（Results<T> type）
    func findAll() -> Results<T> {
        return realm.objects(T.self)
    }

    /// 全件取得（Array type）
    func findAllConvertedToArray() -> [T] {
        return Array(findAll())
    }

    /// 指定キーのレコードを取得
    func findById(id: AnyObject) -> T? {
        return realm.object(ofType: T.self, forPrimaryKey: id)
    }
}

extension RealmDaoHelper {
    
    static func isInWriteTransaction() -> Bool {
        return Realm.sharedRealm().isInWriteTransaction
    }
    
    static func transaction(block:(() -> Void)? = nil) {
        let realm = Realm.sharedRealm()
        realm.beginWrite()
        do {
            block?()
            try realm.commitWrite()
            
        } catch {
            print(error)
            realm.cancelWrite()
        }
    }
}
