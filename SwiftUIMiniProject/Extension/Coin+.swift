//
//  Coin+.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/8/24.
//

import Foundation

extension Coin {
    func toLikedCoin() -> LikedCoin {
        return LikedCoin(id: self.id)
    }
}
