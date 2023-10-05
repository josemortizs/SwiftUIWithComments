//
//  GeometryReaderOffsetExample.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 5/10/23.
//
// origin: https://www.fivestars.blog/articles/scrollview-offset/

import SwiftUI

/*  --------------------------------------------------------------
    Example of use: ScrollViewOffset
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

#Preview {
    GeometryReaderOffsetExample()
}
