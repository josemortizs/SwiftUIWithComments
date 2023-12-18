//
//  GenericFileManagerPropertyKeyPatch.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 18/12/23.
//

import SwiftUI

struct FileManagerValues {
    static let shared = FileManagerValues()
    private init() { }
    
    let userProfile = "user_profile"
}

// TODO: Pendiente de modificar
@available(iOS 16.0, *)
@propertyWrapper
struct GenericFileManagerPropertyKeyPath<T: Codable>: DynamicProperty {
    
    @State private var value: T?
    let key: String
    
    var wrappedValue: T? {
        get {
            value
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: Binding<T?> {
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }
    
    init(_ key: String) {
        self.key = key
        do {
            let url = FileManager.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            print("SUCCESS READ")
        } catch {
            _value = State(wrappedValue: nil)
            print("ERROR READ: \(error.localizedDescription)")
        }
    }
    
    @available(iOS 16.0, *)
    func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentsPath(key: key))
            value = newValue
            print("Success saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}

struct GenericFileManagerPropertyKeyPatch_ExampleUse: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    GenericFileManagerPropertyKeyPatch_ExampleUse()
}
