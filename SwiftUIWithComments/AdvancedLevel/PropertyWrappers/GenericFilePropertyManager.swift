//
//  GenericFilePropertyManager.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 11/12/23.
//

import SwiftUI

@available(iOS 16.0, *)
@propertyWrapper
struct GenericFileManagerProperty<T: Codable>: DynamicProperty {
    
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

struct User: Codable {
    let name: String
    let age: Int
    let isPremium: Bool
}

@available(iOS 16.0, *)
struct GenericFilePropertyManager: View {
    
    @GenericFileManagerProperty("user_profile") private var userProfile: User?
    
    var body: some View {
        VStack(spacing: 40) {
            Text("Hello, \(userProfile?.name ?? "no_user_name")!")
            
            SomeBindingView(userProfile: $userProfile)

        }
        .onAppear(perform: {
            print(NSHomeDirectory())
        })
    }
}

struct SomeBindingView: View {
    
    @Binding var userProfile: User?
    
    var body: some View {
        Button(action: {
            userProfile = User(name: "Pepe Ortiz Sánchez", age: 36, isPremium: true)
        }, label: {
            Text("Change user...")
        })
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        GenericFilePropertyManager()
    } else {
        Text("")
    }
}
