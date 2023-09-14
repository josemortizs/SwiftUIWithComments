//
//  MagnificationGesture.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 14/9/23.
//
// Example origin: https://youtu.be/RkfJoNzfJ8w?si=YABEFS_tCnEgt4D5

import SwiftUI

struct MagnificationGestureExampleView: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        VStack(spacing: 10) {
            HStack {
                Circle().frame(width: 35, height: 35)
                Text("Example Magnitifaction")
                Spacer()
                Image(systemName: "ellipsis")
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 300)
                .scaleEffect(1 + currentAmount)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            /*
                                Uso sencillo, closure para inyectar el comportamiento a realizar
                                cuando se detecte el gesto de magnificación.
                            */
                            currentAmount = value - 1
                        }
                        .onEnded { _ in
                            /*
                                Closure a inyectar con la funcionalidad a realizar cuando finalice
                                el gesto de magnificar.
                            */
                            withAnimation(.spring()) {
                                currentAmount = 0
                            }
                        }
                )
            HStack {
                Image(systemName: "heart.fill")
                Image(systemName: "text.bubble.fill")
                Spacer()
            }
            .padding(.horizontal)
            .font(.headline)
            Text("Ejemplo del gesto MagnificationGesture")
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
        }
    }
}

struct MagnificationGestureView: View {
    
    @State var currentAmount: CGFloat = 0
    @State var lastAmount: CGFloat = 0
    
    var body: some View {
        Text("Hello, World!")
            .font(.title)
            .padding(40)
            .background(Color.red.cornerRadius(10))
            .scaleEffect(1 + currentAmount + lastAmount)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        currentAmount = value - 1
                    }
                    .onEnded { value in
                        lastAmount += currentAmount
                        currentAmount = 0
                    }
            )
    }
}

struct MagnificationGesture_Previews: PreviewProvider {
    static var previews: some View {
        MagnificationGestureExampleView()
    }
}
