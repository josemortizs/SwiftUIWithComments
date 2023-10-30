//
//  CustomBinding.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 30/10/23.
//
//  Origin: https://youtu.be/K91rKH_O8BY?si=baG7boG6eIxisf3H

import SwiftUI

/*
    1. This is the generic way in which error alerts are usually displayed, 
       using one variable to store the error and another to activate/deactivate
       the alert, the modal, the full screen modal, etc...
    
    2. Through the extension, shown with comment 0, we add to Binding, when it is of type Bool,
       a constructor that accepts a generic, optional value, which returns TRUE when its wrappedvalue
       is null and when the boolean value is set to FALSE it sets said wrappedvalue to null again.
       With this extension we can use any optional value as a valid Binding for any sheet, alert,
       fullscreencover, etc. Without the need to use two variables.
 
    3. This alert is shown to show how we could do it without the extension, comment 0,
       so that we also know what this extension facilitates. This way we would also be able
       to display the alert with only one variable, errorWithoutExtension, but it is more verbose
       and less clean to read.
 */

// 0
extension Binding where Value == Bool {
    
    init<T>(value: Binding<T?>) {
        self.init {
            value.wrappedValue != nil
        } set: { newValue in
            if !newValue { value.wrappedValue = nil }
        }
    }
}

struct CustomBinding: View {
        
    @State private var errorTitle: String? = nil
    @State private var showError: Bool = false
    
    @State private var otherErrorTitle: String? = nil
    
    @State private var errorWithoutExtension: String? = nil
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Button(action: {
                errorTitle = "New error!"
                showError.toggle()
            }, label: {
                Text("This button will present an alert by using two property wrappers, errorTitle and showError")
            })
            
            Spacer()
            
            Button(action: {
                otherErrorTitle = "New otherError!!"
            }, label: {
                Text("While this button will only use otherErrorTitle")
            })
            
            Spacer()
            
            Button(action: {
                errorWithoutExtension = "error for explanation"
            }, label: {
                Text("This button will act exactly the same as the second button, I show it so you can compare the way of adding the binding to the alert constructor.")
            })
            
            Spacer()
        }
        // 1
        .alert(errorTitle ?? "", isPresented: $showError) {
            Text("OK")
        }
        // 2
        .alert(otherErrorTitle ?? "", isPresented: Binding(value: $otherErrorTitle)) {
            Text("Better")
        }
        // 3
        .alert(errorWithoutExtension ?? "", isPresented: Binding(get: {
            errorWithoutExtension != nil
        }, set: { newValue in
            if !newValue { errorWithoutExtension = nil }
        }), actions: {
            Text("Understood?")
        })
        .padding()
    }
}

#Preview {
    CustomBinding()
}
