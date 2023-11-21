//
//  PropertyWrapperExample.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 21/11/23.
//
//  Origin: https://youtu.be/2wzq6SQkSJE?si=xh3AkmoPGCwPyE2n&t=898

import SwiftUI

struct PropertyWrapperExample: View {
    
    @State private var title: String = "Starting title"
    
    var body: some View {
        VStack(spacing: 40) {
            
            Text(title).font(.largeTitle)
            
            Button("Click me 1") {
                if #available(iOS 16.0, *) {
                    setTitle(newValue: "title 1")
                } else {
                    // Fallback on earlier versions
                }
            }
            
            Button("Click me 2") {
                if #available(iOS 16.0, *) {
                    setTitle(newValue: "title 2")
                } else {
                    // Fallback on earlier versions
                }
            }
        }
        .onAppear(perform: {
            
        })
    }
    
    @available(iOS 16.0, *)
    private func setTitle(newValue: String) {
        title = newValue.uppercased()
        save(newValue: newValue)
    }
    
    @available(iOS 16.0, *)
    private var path: URL {
        FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)
            .first!
            .appending(path: "custom_title.txt")
    }
    
    @available(iOS 16.0, *)
    private func save(newValue: String) {
        do {
            try newValue.write(to: path, atomically: false, encoding: .utf8)
            print(NSHomeDirectory())
            print("Success saved")
        } catch {
            print(error.localizedDescription)
        }
    }
    
}

#Preview {
    PropertyWrapperExample()
}
