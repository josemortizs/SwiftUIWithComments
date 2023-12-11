//
//  GenericFilePropertyManager.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 11/12/23.
//

import SwiftUI

@available(iOS 16.0, *)
@propertyWrapper
struct GenericFileManagerProperty: DynamicProperty {
    
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

struct GenericFilePropertyManager: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    GenericFilePropertyManager()
}
