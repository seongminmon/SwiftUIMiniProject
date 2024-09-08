//
//  RealmRepository.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/8/24.
//

import Foundation
import RealmSwift

final class RealmRepository {
    static let shared = RealmRepository()
    private var realm: Realm
    
    private init() {
        do {
            realm = try Realm()
        } catch let error as NSError {
            fatalError("Realm 초기화 실패: \(error.localizedDescription)")
        }
    }
    
    func makeNewRealm() {
        do {
            realm = try Realm()
        } catch let error as NSError {
            fatalError("Realm 초기화 실패: \(error.localizedDescription)")
        }
    }
    
    var fileURL: URL? {
        return realm.configuration.fileURL
    }
    
    var schemaVersion: UInt64? {
        guard let fileURL = fileURL else { return nil }
        return try? schemaVersionAtURL(fileURL)
    }
    
    // MARK: - Create
    func addItem(_ item: LikedCoin) {
        makeNewRealm()
        do {
            try realm.write {
                realm.add(item)
                print("Realm Create!")
            }
        } catch {
            print("Realm Create Failed")
        }
    }
    
    // MARK: - Read
    func fetchAll() -> [LikedCoin] {
        makeNewRealm()
        let value = realm.objects(LikedCoin.self)
            .sorted(byKeyPath: "date", ascending: false) // 최신순
        return Array(value)
    }
    
    func fetchItem(_ id: String) -> LikedCoin? {
        makeNewRealm()
        return realm.object(ofType: LikedCoin.self, forPrimaryKey: id)
    }
    
    // MARK: - Update
    func updateItem(_ item: LikedCoin) {
        //
    }
    
    // MARK: - Delete
    func deleteItem(_ id: String) {
        makeNewRealm()
        if let item = fetchItem(id) {
            do {
                try realm.write {
                    realm.delete(item)
                    print("Realm Delete!")
                }
            } catch {
                print("Realm Delete Failed")
            }
        }
    }
    
    func deleteAll() {
        makeNewRealm()
        do {
            try realm.write {
                let photos = realm.objects(LikedCoin.self)
                realm.delete(photos)
                print("Realm Delete All!")
            }
        } catch {
            print("Realm Delete All Failed")
        }
    }
}
