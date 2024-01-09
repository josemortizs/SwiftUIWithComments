//
//  OtherExampleWrapper.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 9/1/24.
//

import SwiftUI
import Combine

struct CustomProjectedValue<T: Codable> {
    let binding: Binding<T?>
    let publisher: CurrentValueSubject<T?, Never>
    
    var stream: AsyncPublisher<CurrentValueSubject<T?, Never>> {
        publisher.values
    }
}

@available(iOS 16.0, *)
@propertyWrapper
struct FileManagerCodableStreamablePropertyWithProjectedValue<T: Codable>: DynamicProperty {
    
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
        
    var projectedValue: CustomProjectedValue<T> {
        CustomProjectedValue(
            binding: Binding(
                get: { wrappedValue },
                set: { wrappedValue = $0 }
            ),
            publisher: publisher
        )
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

struct OtherExampleWrapper: View {
    var body: some View {
        Text("Hello, World!")
    }
}

#Preview {
    OtherExampleWrapper()
}
