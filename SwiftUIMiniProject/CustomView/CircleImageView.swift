//
//  CircleImageView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/8/24.
//

import SwiftUI

struct CircleImageView: View {
    
    let url: String?
    
    var body: some View {
        AsyncImage(url: URL(string: url ?? "")) { data in
            switch data {
            case .empty:
                ProgressView()
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fill)
            case .failure(_):
                Image(systemName: "star")
            @unknown default:
                Image(systemName: "star")
            }
        }
        .frame(width: 50, height: 50)
        .clipShape(Circle())
    }
}
