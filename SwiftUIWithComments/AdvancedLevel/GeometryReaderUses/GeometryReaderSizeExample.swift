//
//  GeometryReaderSizeExample.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 3/10/23.
//
// origin: https://www.fivestars.blog/articles/swiftui-share-layout-information/

import SwiftUI

struct GeometryReaderSizeExample: View {
    var body: some View {
        Text("Hello, World!")
            .readSize { size in
                print("The size of this Text is: \(size)")
            }
    }
}



/*  --------------------------------------------------------------
    With this view extension we can get the size of any child view
    by using a simple view modifier.
    --------------------------------------------------------------
 */
extension View {
  func readSize(onChange: @escaping (CGSize) -> Void) -> some View {
    background(
      GeometryReader { geometryProxy in
        Color.clear
          .preference(key: SizePreferenceKey.self, value: geometryProxy.size)
      }
    )
    .onPreferenceChange(SizePreferenceKey.self, perform: onChange)
  }
}

struct SizePreferenceKey: PreferenceKey {
  static var defaultValue: CGSize = .zero
  static func reduce(value: inout CGSize, nextValue: () -> CGSize) {}
}

#Preview {
    GeometryReaderSizeExample()
}
