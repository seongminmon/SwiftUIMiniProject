//
//  LikedCoin.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/8/24.
//

import Foundation
import RealmSwift

class LikedCoin: Object {
    // Coin id를 기본키로 설정
    @Persisted(primaryKey: true) var id: String
    // 좋아요한 날짜
    @Persisted var date: Date
    
    convenience init(id: String) {
        self.init()
        self.id = id
        self.date = Date()
    }
}
