//
//  View+.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/8/24.
//

import SwiftUI

extension View {
    func navigationBar(
        @ViewBuilder leading: () -> some View,
        @ViewBuilder trailing: () -> some View
    ) -> some View {
        modifier(NavigationBarWrapper(leading: leading, trailing: trailing))
    }
}
