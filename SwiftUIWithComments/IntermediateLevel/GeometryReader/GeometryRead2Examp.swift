//
//  GeometryRead2Examp.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 4/10/23.
//

import SwiftUI

struct GeometryRead2Examp: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(0..<20) { index in
                    GeometryReader { geometry in
                        RoundedRectangle(cornerRadius: 20)
                            .rotation3DEffect(
                                Angle(degrees: getPercentage(geo: geometry) * 30),
                                axis: (x: 0.0, y: 1.0, z: 0.0)
                            )
                    }
                    .frame(width: 300, height: 250)
                    .padding()
                }
            }
        }
    }
    
    func getPercentage(geo: GeometryProxy) -> Double {
        // Get center of screen
        let maxDistance = UIScreen.main.bounds.width / 2
        // Get the current center coordinate of the rectangle
        let currentX = geo.frame(in: .global).midX
            
        return Double(1 - (currentX / maxDistance))
    }
}

#Preview {
    GeometryRead2Examp()
}
