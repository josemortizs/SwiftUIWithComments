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

@available(iOS 16.0, *)
struct PropertyWrappers2Example: View {
    
    @Uppercased private var title: String = "Hello, world!"
    @FileManagerProperty("user_profile") private var userProfile: String = "Test"
    
    var body: some View {
        VStack {
            Text(title)
            TextField("Binding...", text: $title)
                .multilineTextAlignment(.center)
        }
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        PropertyWrappers2Example()
    } else {
        Text("")
    }
}
