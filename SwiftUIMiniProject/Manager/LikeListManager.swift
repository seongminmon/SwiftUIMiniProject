//
//  LikeListManager.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/8/24.
//

import SwiftUI

final class LikeListManager: ObservableObject {
    @AppStorage("likeList") private var likeListData: String = "[]"

    @Published var likeList: [String] = []

    init() {
        loadArray()
    }

    func addItem(_ item: String) {
        likeList.append(item)
        saveArray()
        print("추가: \(likeList)")
    }

    func removeItem(id: String) {
        if let index = likeList.firstIndex(of: id) {
            likeList.remove(at: index)
            saveArray()
            print("삭제: \(likeList)")
        }
    }

    private func saveArray() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(likeList) {
            likeListData = String(data: encoded, encoding: .utf8) ?? "[]"
        }
    }

    private func loadArray() {
        let decoder = JSONDecoder()
        if let data = likeListData.data(using: .utf8),
           let decodedData = try? decoder.decode([String].self, from: data) {
            likeList = decodedData
        } else {
            likeList = []
        }
    }
}
