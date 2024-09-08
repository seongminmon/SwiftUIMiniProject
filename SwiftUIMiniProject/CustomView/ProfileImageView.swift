//
//  ProfileImageView.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/8/24.
//

import SwiftUI

struct ProfileImageView: View {
    var body: some View {
        Image(systemName: "person")
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(8)
            .clipShape(Circle())
            .frame(width: 40, height: 40)
            .foregroundStyle(.black)
            .overlay(Circle().stroke(.purple, lineWidth: 3))
    }
}
