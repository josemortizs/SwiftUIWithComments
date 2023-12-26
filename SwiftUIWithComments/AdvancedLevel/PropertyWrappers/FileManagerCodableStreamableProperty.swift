//
//  GenericFileManagerPropertyPublisher.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 26/12/23.
//

import SwiftUI
import Combine

@available(iOS 16.0, *)
@propertyWrapper
struct FileManagerCodableStreamableProperty<T: Codable>: DynamicProperty {
    
    @State private var value: T?
    let key: String
    private let publisher: CurrentValueSubject<T?, Never>
    
    var wrappedValue: T? {
        get {
            value
        }
        nonmutating set {
            save(newValue: newValue)
        }
    }
    
    var projectedValue: CurrentValueSubject<T?, Never> {
        publisher
    }
    
    init(_ key: String) {
        self.key = key
        do {
            let url = FileManager.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)
            print("SUCCESS READ")
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            print("ERROR READ: \(error.localizedDescription)")
        }
    }
    
    init(_ key: KeyPath<FileManagerValues, FileManagerKeypath<T>>) {
        
        let keypath = FileManagerValues.shared[keyPath: key]
        let key = keypath.key
        
        self.key = key
        
        do {
            let url = FileManager.documentsPath(key: key)
            let data = try Data(contentsOf: url)
            let object = try JSONDecoder().decode(T.self, from: data)
            _value = State(wrappedValue: object)
            publisher = CurrentValueSubject(object)
            print("SUCCESS READ")
        } catch {
            _value = State(wrappedValue: nil)
            publisher = CurrentValueSubject(nil)
            print("ERROR READ: \(error.localizedDescription)")
        }
    }
    
    @available(iOS 16.0, *)
    private func save(newValue: T?) {
        do {
            let data = try JSONEncoder().encode(newValue)
            try data.write(to: FileManager.documentsPath(key: key))
            value = newValue
            publisher.send(newValue)
            print("Success saved")
        } catch {
            print(error.localizedDescription)
        }
    }
}

@available(iOS 16.0, *)
struct GenericFileManagerPropertyPublisher: View {
    
    @FileManagerCodableStreamableProperty(\.userProfile) private var userProfile
    
    var body: some View {
        VStack {
            Button {
                userProfile = User(name: "Draka Gil Ortiz", age: 6, isPremium: true)
            } label: {
                Text(userProfile?.name ?? "")
            }
        }
        .onReceive($userProfile) { newValue in
            print("Received new value of: \(newValue)")
        }
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        GenericFileManagerPropertyPublisher()
    } else {
        Text("iOS < 16.0")
    }
}
