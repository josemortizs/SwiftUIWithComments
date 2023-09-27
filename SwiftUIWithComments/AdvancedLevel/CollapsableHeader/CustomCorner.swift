//
//  CustomCorner.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/23.
//

import SwiftUI

struct CustomCorner: Shape {
    var corners: UIRectCorner = []
    var radius: CGFloat = 0
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
