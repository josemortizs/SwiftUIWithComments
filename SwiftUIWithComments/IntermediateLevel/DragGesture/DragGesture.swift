//
//  DragGesture.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 18/9/23.
//
// Example origin: https://youtu.be/O3QAI8Mxh8M?si=5SEXJ-ygg1ZDSlNe

import SwiftUI

struct DragGestureView: View {
    
    @State private var offset: CGSize = .zero
    
    var body: some View {
        ZStack {
            
            VStack {
                Text("width: \(offset.width)")
                Spacer()
            }
            
            RoundedRectangle(cornerRadius: 20)
                .frame(width: 300, height: 500)
                .offset(offset)
                .scaleEffect(getScaleAmount())
                .rotationEffect(Angle(degrees: getRotationAmount()))
                .gesture(
                    DragGesture()
                        .onChanged({ value in
                            withAnimation(.spring()) {
                                offset = value.translation
                            }
                        })
                        .onEnded({ _ in
                            withAnimation(.spring()) {
                                offset = .zero
                            }
                        })
            )
        }
    }
    
    /*
        abs() para obtener el valor absoluto de width, importante porque
        offset.width podría ser negativo en -175 y en ese caso el valor
        que necesitaríamos sería 175...
     */

    private func getScaleAmount() -> CGFloat {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = abs(offset.width)
        let percentage = currentAmount / max
        
        return 1.0 - min(percentage, 0.5) * 0.5
    }
    
    /*
        Ambas funciones se llaman al actualizarse la view, y
        esta se actualiza cada vez que cambia el valor de offset
        que es de tipo State.
        
     */
    
    private func getRotationAmount() -> Double {
        let max = UIScreen.main.bounds.width / 2
        let currentAmount = offset.width
        let percentage = currentAmount / max
        let percentageAsDouble = Double(percentage)
        let maxAngle: Double = 10
        
        return percentageAsDouble * maxAngle
    }
}

struct DragGesture_Previews: PreviewProvider {
    static var previews: some View {
        DragGestureView()
    }
}
