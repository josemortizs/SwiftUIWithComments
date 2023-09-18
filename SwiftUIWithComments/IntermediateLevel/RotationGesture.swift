//
//  RotationGesture.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 18/9/23.
//
// Example origin: https://www.youtube.com/watch?v=vSvhdwy_8Lk&list=PLwvDm4VfkdpiagxAXCT33Rkwnc5IVhTar&index=4&pp=iAQB

import SwiftUI

struct RotationGestureView: View {
    
    @State private var angle: Angle = .zero
    
    var body: some View {
        Text("Hello, World!")
            .font(.largeTitle)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(50)
            .background(Color.blue.cornerRadius(10))
            .rotationEffect(angle)
            .gesture(
                RotationGesture()
                    .onChanged({ angle in
                        /*
                         Se ejecutará este closure cuando rotes la vista
                        */
                        self.angle = angle
                    })
                    .onEnded({ _ in
                        /*
                         Se ejecutará este closure cuando el usuario deje de rotar la vista
                        */
                        withAnimation(.spring()) {
                            self.angle = .zero
                        }
                    })
            )
    }
}

struct RotationGesture_Previews: PreviewProvider {
    static var previews: some View {
        RotationGestureView()
    }
}
