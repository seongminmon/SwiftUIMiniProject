//
//  NavigationBarWrapper.swift
//  SwiftUIMiniProject
//
//  Created by 김성민 on 9/9/24.
//

import SwiftUI

struct NavigationBarWrapper<Leading: View, Trailing: View>: ViewModifier {
    
    let leading: Leading
    let trailing: Trailing
    
    init(
        @ViewBuilder leading: () -> Leading,
        @ViewBuilder trailing: () -> Trailing
    ) {
        self.leading = leading()
        self.trailing = trailing()
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 14.0, *) {
            content
                .toolbar {
                    ToolbarItem(placement: .topBarLeading, content: { leading })
                    ToolbarItem(placement: .topBarTrailing, content: { trailing })
                }
        } else {
            content
                .navigationBarItems(leading: leading, trailing: trailing)
        }
    }
}
