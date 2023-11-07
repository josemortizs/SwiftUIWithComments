//
//  ErrorAlertExample.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 6/11/23.
//
//  Origin: https://youtu.be/lncOFL3Qsns?si=UnHLMba6IrSThCAi
//  https://youtu.be/lncOFL3Qsns?si=eRjKENNwuwG7CjQG&t=1556

import SwiftUI

struct ErrorAlertExample: View {
    
    // @State private var error: Error? = nil
    @State private var alert: MyCustomAlert? = nil
    
    var body: some View {
        Button {
            saveData()
        } label: {
            Text("Click me")
        }
        .alert(alert?.title ?? "Error", isPresented: Binding(value: $alert), actions: {
            alert?.getButtonsForAlert(onOkPressed: {
                // Logic onKeyPressed
            })
        }, message: {
            if let subTitle = alert?.subTitle {
                Text(subTitle)
            }
        })
    }
    
    // enum MyCustomError: Error, LocalizedError {
        
    //     case noInternetConnection
    //     case dataNotFound
    //     case urlError(error: Error)
        
    //     var errorDescription: String? {
    //         switch self {
    //         case .noInternetConnection:
    //             return "Please check your internet connection and try again."
    //         case .dataNotFound:
    //             return "There was an error loading data. Please try again!"
    //         case .urlError(let error):
    //             return "Error: \(error.localizedDescription)"
    //         }
    //     }
    // }
    
    enum MyCustomAlert: Error, LocalizedError {
        
        case noInternetConnection
        case dataNotFound
        case urlError(error: Error)
        
        var errorDescription: String? {
            switch self {
            case .noInternetConnection:
                return "Please check your internet connection and try again."
            case .dataNotFound:
                return "There was an error loading data. Please try again!"
            case .urlError(let error):
                return "Error: \(error.localizedDescription)"
            }
        }

        var title: String {
            switch self {
                case .noInternetConnection: return "No internet connection"
                case .dataNotFound: return "No data"
                case .urlError: return "URLError"
            }
        }

        var subTitle: String? {
            switch self {
                case .noInternetConnection: return "Please check your internet connection and try again."
                case .dataNotFound: return nil
                case .urlError(let error): return "Error: \(error.localizedDescription)"
            }
        }
        
        @ViewBuilder
        func getButtonsForAlert(
            onOkPressed: @escaping () -> Void
        ) -> some View {
            switch self {
            case .noInternetConnection:
                Button("Ok") {
                    onOkPressed()
                }
            case .dataNotFound:
                Button("Retry") {
                    
                }
            default:
                Button("Delete", role: .destructive) {
                    
                }
            }
        }
    }
    
    private func saveData() {
        let isSuccessful: Bool = false
        
        if isSuccessful {
            // do something
        } else {
            let alert: MyCustomAlert = .dataNotFound
            self.alert = alert
        }
    }
}

#Preview {
    ErrorAlertExample()
}
