//
//  GeometryReader.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 4/10/23.
//

import SwiftUI

struct GeometryReaderOtherExample: View {
    var body: some View {
        GeometryReader { geometry in
            HStack(spacing: 0) {
                Rectangle()
                    .fill(Color.red)
                    .frame(width: geometry.size.width * 0.6666)
                
                Rectangle().fill(Color.blue)
            }
            ignoresSafeArea()}
    }
}

struct GeometryReaderOtherExample_Previews: PreviewProvider {
    static var previews: some View {
        GeometryReaderOtherExample()
    }
}
