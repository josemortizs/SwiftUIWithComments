//
//  DragGesture2.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 19/9/23.
//
// Example origin: https://youtu.be/O3QAI8Mxh8M?si=5SEXJ-ygg1ZDSlNe

import SwiftUI

struct DragGesture2View: View {
    
    @State private var startingOffsetY: CGFloat = UIScreen.main.bounds.height * 0.85
    @State private var currentDragOffsetY: CGFloat = 0
    @State private var endingOffSetY: CGFloat = 0
    
    var body: some View {
        ZStack {
            Color.green.ignoresSafeArea()
            
            MySignUpview()
                .offset(y: startingOffsetY)
                .offset(y: currentDragOffsetY)
                .offset(y: endingOffSetY)
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                currentDragOffsetY = value.translation.height
                            }
                        })
                        .onEnded({ value in
                            
                            if currentDragOffsetY < -150 {
                                withAnimation(.spring()) {
                                    endingOffSetY = -startingOffsetY
                                }
                            } else if endingOffSetY != 0 && currentDragOffsetY > 150 {
                                withAnimation(.spring()) {
                                    endingOffSetY = 0
                                }
                            }
                            
                            withAnimation(.spring()) {
                                currentDragOffsetY = 0

                            }
                        })
                )
        }
        .ignoresSafeArea(edges: .bottom)
    }
}

struct DragGesture2_Previews: PreviewProvider {
    static var previews: some View {
        DragGesture2View()
    }
}

struct MySignUpview: View {
    var body: some View {
        VStack(spacing: 20) {
            
            Image(systemName: "chevron.up")
                .padding(.top)
            
            Text("Sign up")
                .font(.headline)
                .fontWeight(.semibold)
            
            Image(systemName: "flame.fill")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
            
            Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum")
                .multilineTextAlignment(.center)
            
            Text("Crear una cuenta")
                .foregroundColor(.white)
                .font(.headline)
                .padding()
                .padding(.horizontal)
                .background(Color.black.cornerRadius(10))
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color.white)
        .cornerRadius(30)
    }
}
