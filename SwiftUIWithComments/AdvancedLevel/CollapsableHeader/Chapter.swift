//
//  Chapter.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 27/9/23.
//

import SwiftUI

struct Chapter: Identifiable {
    var id: String = UUID().uuidString
    var color: Color
    var title: String
    var description: String
}

let chaptersSwiftBook: [Chapter] = [
    Chapter(color: .blue, title: "Introducción a Swift", description: "Conceptos básicos de Swift y su historia."),
    Chapter(color: .green, title: "Variables y Constantes", description: "Declaración y uso de variables y constantes."),
    Chapter(color: .orange, title: "Estructuras de Control", description: "If, switch, loops y control de flujo."),
    Chapter(color: .purple, title: "Funciones", description: "Definición y llamada a funciones en Swift."),
    Chapter(color: .red, title: "Clases y Objetos", description: "Conceptos de programación orientada a objetos en Swift."),
    Chapter(color: .gray, title: "Optionals", description: "Uso de optionals para manejar valores nulos."),
    Chapter(color: .pink, title: "Colecciones", description: "Trabajar con arrays, dictionaries y sets."),
    Chapter(color: .blue, title: "Closures", description: "Entender y utilizar closures en Swift."),
    Chapter(color: .green, title: "Protocolos", description: "Declaración e implementación de protocolos."),
    Chapter(color: .orange, title: "Manejo de Errores", description: "Tratar y propagar errores en Swift."),
    Chapter(color: .purple, title: "Concurrency", description: "Manejo de concurrencia y tareas asíncronas."),
    Chapter(color: .red, title: "Interfaz de Usuario", description: "Desarrollo de interfaces de usuario con SwiftUI."),
    Chapter(color: .gray, title: "Persistencia de Datos", description: "Almacenamiento y recuperación de datos.")
]

struct ChapterCardView: View {
    
    let chapter: Chapter
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .foregroundColor(chapter.color)
                .padding(.horizontal)
            
            VStack(alignment: .leading, spacing: 10) {
                Text(chapter.title)
                    .font(.title)
                    .foregroundColor(.white)
                
                Text(chapter.description)
                    .foregroundColor(.white)
            }
            .padding(.horizontal)
        }
        .frame(width: UIScreen.main.bounds.width, height: 100)
    }
}
