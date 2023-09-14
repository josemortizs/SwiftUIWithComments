//
//  LongPressGesture.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 13/9/23.
//
// Example origin: https://youtu.be/Ioux-yqewNs?si=Tr7V8ffiQ20Z01QV

import SwiftUI

struct LongPressGesture: View {
    
    @State var active: Bool = false
    
    var body: some View {
        Text(active ? "ACTIVE" : "INACTIVE")
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
            .background(active ? Color.green : Color.gray)
            .cornerRadius(10)
            .onLongPressGesture(minimumDuration: 3, maximumDistance: 1) {
                active.toggle()
            }
            /*  El valor minimumDuration es claro: cuánto has de mantener pulsada la vista
                antes de que se "lance" el evento.
                maximumDistance establece la distancia máxima que el dedo, cursor, etc, puede
                moverse durante la pulsación mantenida antes de que la acción sea cancelada.
             */
    }
}

struct DefaultLongPressGesture: View {
    
    @State var active: Bool = false
    
    var body: some View {
        Text(active ? "ACTIVE" : "INACTIVE")
            .padding(EdgeInsets(top: 20, leading: 30, bottom: 20, trailing: 30))
            .background(active ? Color.green : Color.gray)
            .cornerRadius(10)
            .onLongPressGesture {
                active.toggle()
            }
            /* Valores por defecto de onLongPressGesture:
               minimumDuration: Double = 0.5, maximumDistance: CGFloat = 10
            */
            
    }
}

struct ExampleLongPressGesture: View {
    
    @State var buttonIsBeingPressed: Bool = false
    @State var isSuccess: Bool = false
    
    var body: some View {
        VStack {
            Rectangle()
                .fill(isSuccess ? Color.green : Color.blue)
                .frame(maxWidth: buttonIsBeingPressed ? .infinity : 0)
                .frame(height: 55)
                .frame(maxWidth: .infinity, alignment: .leading)
                .background(Color.gray)
            
            HStack {
                Text("Tap para rellenar...")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onLongPressGesture(minimumDuration: 1.0, maximumDistance: 50, perform: {
                        /*  Se lanzaría al finalizar la duración -> 1.0 segundos
                            y ejecutará la animación correspondiente.
                        */
                        withAnimation(.easeInOut) {
                            isSuccess = true
                        }
                    }, onPressingChanged: { isPressing in
                        /* Se lanzaría dos veces:
                            1. Al principio, donde isPressing es verdadero
                            2. Al final, cuando deja de serlo
                            Output:
                            El botón está presionado = true
                            El botón está presionado = false
                            
                            La acción animada cambia buttonIsBeingPressed a true y
                            "rellena" la barra.
                         
                            Si se cancela antes de terminar, mediante animación, vuelve a 0
                            el valor de: .frame(maxWidth: buttonIsBeingPressed ? .infinity : 0)
                         */
                        print("El botón está presionado = \(isPressing.description)")
                        
                        if isPressing {
                            withAnimation(.easeInOut(duration: 1.0)) {
                                buttonIsBeingPressed = true
                            }
                        } else {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                if isSuccess == false {
                                    withAnimation(.easeInOut) {
                                        buttonIsBeingPressed = false
                                    }
                                }
                            }
                        }
                    })
                
                Text("Resetear...")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.black)
                    .cornerRadius(10)
                    .onTapGesture {
                        buttonIsBeingPressed = false
                        isSuccess = false
                    }
            }
            .padding()
        }
    }
}

struct LongPressGesture_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 32) {
            Spacer()
            LongPressGesture()
            DefaultLongPressGesture()
            Spacer()
            ExampleLongPressGesture()
            Spacer()
        }
    }
}
