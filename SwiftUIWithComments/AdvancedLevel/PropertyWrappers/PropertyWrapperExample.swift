//
//  PropertyWrapperExample.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 21/11/23.
//
//  Origin: https://youtu.be/2wzq6SQkSJE?si=50CTDR6qYRqKcM-A&t=1975

import SwiftUI

@available(iOS 16.0, *)
extension FileManager {
    
    static func documentsPath() -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "custom_title.txt")
    }
}

@available(iOS 16.0, *)
struct FileManagerProperty: DynamicProperty {
    
    @State private var title: String
    
    var currentValue: String {
        title
    }
    
    init() {
        do {
            title = try String(contentsOf: FileManager.documentsPath())
        } catch {
            title = "Starting title"
            print("error: \(error.localizedDescription)")
        }
    }
    
    @available(iOS 16.0, *)
    func save(newValue: String) {
        do {
            try newValue.write(to: FileManager.documentsPath(), atomically: false, encoding: .utf8)
            title = newValue
            print("Success saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}

@available(iOS 16.0, *)
struct PropertyWrapperExample: View {
        
    var fileManagerProperty = FileManagerProperty()
    
    var body: some View {
        VStack(spacing: 40) {
            
            Text(fileManagerProperty.currentValue).font(.largeTitle)
            
            Button("Click me 1") {
                fileManagerProperty.save(newValue: "title 1")
                print("Succes read")
            }
            
            Button("Click me 2") {
                fileManagerProperty.save(newValue: "title 2")
                print("Succes read")
            }
        }
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        PropertyWrapperExample()
    } else {
        Text("iOS < 16.0...")
    }
}
