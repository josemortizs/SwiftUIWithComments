//
//  ErrorAlertExample.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 6/11/23.
//
//  Origin: https://youtu.be/lncOFL3Qsns?si=UnHLMba6IrSThCAi

import SwiftUI

/*
    We declare the protocol that all data models that want to
    provide information to a possible alert must comply with.
 */
protocol AppAlert {
    var title: String { get }
    var subtitle: String? { get }
    var buttons: AnyView { get }
}

/*
    We define a View extension so we can call our function from
    any view.
 */
extension View {
    
    func showCustomAlert<T: AppAlert>(alert: Binding<T?>) -> some View {
        self
            .alert(alert.wrappedValue?.title ?? "Error", isPresented: Binding(value: alert), actions: {
                alert.wrappedValue?.buttons
            }, message: {
                if let subTitle = alert.wrappedValue?.subtitle {
                    Text(subTitle)
                }
            })
    }
}

struct ErrorAlertExample: View {
    
    @State private var alert: MyCustomAlert? = nil
    
    var body: some View {
        Button {
            saveData()
        } label: {
            Text("Show alert")
        }
        .showCustomAlert(alert: $alert)
        /*
         1. We can use showCustomAlert because it is inside ErrorAlertExample,
            which is of type View.
         2. We can pass, as an argument to the show Custom Alert function,
            our alert, of type MyCustomAlert, because it implements the
            AppAlert protocol.
         */
    }
    
    /*
        The LocalizedError protocol allows us to implement errorDescription,
        since MyCustomAlert is an Error implementation, making it appropriate
        to use the error.errorDescription convention
     */
    enum MyCustomAlert: Error, LocalizedError, AppAlert {
        
        case noInternetConnection(
            onOKPressed: () -> Void,
            onRetryPressed: () -> Void
        )
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

        var subtitle: String? {
            switch self {
                case .noInternetConnection: return "Please check your internet connection and try again."
                case .dataNotFound: return nil
                case .urlError(let error): return "Error: \(error.localizedDescription)"
            }
        }
        
        var buttons: AnyView {
            AnyView(getButtonsForAlert)
        }
        
        @ViewBuilder var getButtonsForAlert: some View {
            switch self {
            case .noInternetConnection(let onOkPressed, let onRetryPressed):
                Button("Ok") {
                    onOkPressed()
                }
                Button("Retry") {
                    onRetryPressed()
                }
            case .dataNotFound:
                Button("Retry") {
                    // Do something here, don't be lazy...
                }
            default:
                Button("Delete", role: .destructive) {
                    // Do something here, don't be lazy...
                }
            }
        }
    }
    
    private func saveData() {
        let isSuccessful: Bool = false
        
        if isSuccessful {
            // // Do something here, don't be lazy...
        } else {
            alert = .noInternetConnection(onOKPressed: {
                print("OK pressed")
            }, onRetryPressed: {
                print("Retry pressed")
            })
        }
    }
}

#Preview {
    ErrorAlertExample()
}
