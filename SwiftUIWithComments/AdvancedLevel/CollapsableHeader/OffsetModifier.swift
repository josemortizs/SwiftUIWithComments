//
//  OffsetModifier.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/23.
//

import SwiftUI

/// We will use this modifier to get the scrollview offset of the view
struct OffsetModifier: ViewModifier {
    
    @Binding var offset: CGFloat
    let named: String
    
    func body(content: Content) -> some View {
        content
            .overlay(
                GeometryReader(content: { proxy -> Color in
                    DispatchQueue.main.async {
                        self.offset = proxy.frame(in: .named(named)).minY
                    }
                    return Color.clear
                })
            )
    }
}

