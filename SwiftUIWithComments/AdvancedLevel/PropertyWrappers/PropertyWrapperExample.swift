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
    
    static func documentsPath(key: String) -> URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "\(key).txt")
    }
}

@available(iOS 16.0, *)
@propertyWrapper
struct FileManagerProperty: DynamicProperty {
    
    @State private var string: String
    let key: String
    
    var wrappedValue: String {
        get {
            string
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<String> {
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }
    
    init(wrappedValue: String, _ key: String) {
        self.key = key
        do {
            string = try String(contentsOf: FileManager.documentsPath(key: key))
        } catch {
            string = wrappedValue
            print("error: \(error.localizedDescription)")
        }
    }
    
    @available(iOS 16.0, *)
    func save(newValue: String) {
        do {
            try newValue.write(to: FileManager.documentsPath(key: key), atomically: false, encoding: .utf8)
            string = newValue
            print("Success saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}

@available(iOS 16.0, *)
struct PropertyWrapperExample: View {
        
    @FileManagerProperty("custom_title_1") private var title: String = ""
    @FileManagerProperty("custom_title_2") private var title2: String = ""

    @State private var subtitle: String = "Subtitel"
    
    var body: some View {
        VStack(spacing: 40) {
            
            Text(title).font(.largeTitle)
            Text(title2).font(.largeTitle)

            PropertyWrapperChildView(subtitle: $title)
            
            Button("Click me 1") {
                title = "title 1"
                print("Succes read")
            }
            
            Button("Click me 2") {
                title = "title 2"
                print("Succes read")
            }
        }
    }
}

struct PropertyWrapperChildView: View {
    
    @Binding var subtitle: String
    
    var body: some View {
        Button(action: {
            subtitle = "Another title!!!"
        }, label: {
            Text(subtitle).font(.largeTitle)
        })
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        PropertyWrapperExample()
    } else {
        Text("iOS < 16.0...")
    }
}

