//
//  ErrorAlertExample.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 6/11/23.
//

import SwiftUI

struct ErrorAlertExample: View {
    
    @State private var error: Error? = nil
    
    var body: some View {
        Button {
            saveData()
        } label: {
            Text("Click me")
        }
        .alert(error?.localizedDescription ?? "Error", isPresented: Binding(value: $error)) {
            Button("OK") {
                
            }
        }
    }
    
    enum MyCustomError: Error, LocalizedError {
        
        case noInternetConnection
        case dataNotFound
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your internet connection and try again."
            case .dataNotFound:
                return "There was an error loading data. Please try again!"
            }
        }
    }
    
    private func saveData() {
        let isSuccessful: Bool = false
        
        if isSuccessful {
            // do something
        } else {
            let myError: Error = MyCustomError.noInternetConnection
            error = myError
        }
    }
}

#Preview {
    ErrorAlertExample()
}
