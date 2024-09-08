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
    private init() {}
    
    private let realm = try! Realm()
    
    var fileURL: URL? {
        return realm.configuration.fileURL
    }
    
    var schemaVersion: UInt64? {
        guard let fileURL = fileURL else { return nil }
        return try? schemaVersionAtURL(fileURL)
    }
    
    // MARK: - Create
    func addItem(_ item: LikedCoin) {
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
        let value = realm.objects(LikedCoin.self)
            .sorted(byKeyPath: "date", ascending: false) // 최신순
        return Array(value)
    }
    
    func fetchItem(_ id: String) -> LikedCoin? {
        return realm.object(ofType: LikedCoin.self, forPrimaryKey: id)
    }
    
    // MARK: - Update
    func updateItem(_ item: LikedCoin) {
        //
    }
    
    // MARK: - Delete
    func deleteItem(_ id: String) {
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
