//
//  GeometryReaderOffsetExample.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 5/10/23.
//
// origin: https://www.fivestars.blog/articles/scrollview-offset/

import SwiftUI

/*  --------------------------------------------------------------
    With this view we can know what offset is being applied in a
    ScrollViewReader and operate based on it.
    --------------------------------------------------------------
 */

struct GeometryReaderOffsetExample: View {
        
    var body: some View {
        ScrollViewOffset {
            HStack(alignment: .center) {
                ForEach(0..<3) { item in
                    Text("\(item)")
                        .frame(width: UIScreen.main.bounds.width, height: /*@START_MENU_TOKEN@*/100/*@END_MENU_TOKEN@*/, alignment: .center)
                        .overlay(
                            RoundedRectangle(cornerRadius: 16)
                                .stroke(.blue, lineWidth: 4)
                        )
                }
            }
            .frame(height: 200)
        } onOffsetChange: { offset in
            print("offset: \(offset.description)")
        }
    }
}

/*  --------------------------------------------------------------
    With this view we can know what offset is being applied in a
    ScrollViewReader and operate based on it.
    --------------------------------------------------------------
 */

struct ScrollViewOffset<Content: View>: View {
    let content: () -> Content
    let onOffsetChange: (CGFloat) -> Void
    var coordinateSpace: String
    
    init(
        @ViewBuilder content: @escaping () -> Content,
        onOffsetChange: @escaping (CGFloat) -> Void
    ) {
        self.content = content
        self.onOffsetChange = onOffsetChange
        self.coordinateSpace = "frameLayer"
    }
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            offsetReader
            content()
        }
        .coordinateSpace(name: coordinateSpace)
        .onPreferenceChange(OffsetPreferenceKey.self, perform: onOffsetChange)
    }
    
    var offsetReader: some View {
        GeometryReader { proxy in
            Color.clear
                .preference(
                    key: OffsetPreferenceKey.self,
                    value: proxy.frame(in: .named(coordinateSpace)).maxX
                )
        }
        .frame(height: 0)
    }
    
    func coordinateSpace(_ coordinateSpace: String) -> ScrollViewOffset {
        var view = self
        view.coordinateSpace = coordinateSpace
        return view
    }
}

private struct OffsetPreferenceKey: PreferenceKey {
    static var defaultValue: CGFloat = .zero
    static func reduce(value: inout CGFloat, nextValue: () -> CGFloat) {}
}

#Preview {
    GeometryReaderOffsetExample()
}
