//
//  PropertyWrappers2Example.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 11/12/23.
//

import SwiftUI

@propertyWrapper
struct Capitalized: DynamicProperty {
    
    @State private var value: String
    
    var wrappedValue: String {
        get {
            value
        }
        nonmutating set {
            value = newValue.capitalized
        }
    }
    
    var projectedValue: Binding<String> {
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.capitalized
    }
}

@propertyWrapper
struct Uppercased: DynamicProperty {
    
    @State private var value: String
    
    var wrappedValue: String {
        get {
            value
        }
        nonmutating set {
            value = newValue.uppercased()
        }
    }
    
    var projectedValue: Binding<String> {
        Binding {
            wrappedValue
        } set: { newValue in
            wrappedValue = newValue
        }

    }
    
    init(wrappedValue: String) {
        self.value = wrappedValue.uppercased()
    }
}

struct PropertyWrappers2Example: View {
    
    @Uppercased private var title: String = "Hello, world!"
    
    var body: some View {
        VStack {
            Text(title)
            TextField("Binding...", text: $title)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    PropertyWrappers2Example()
}
