//
//  SwiftUIWithCommentsApp.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 13/9/23.
//

import SwiftUI

@main
struct SwiftUIWithCommentsApp: App {
    var body: some Scene {
        WindowGroup {
            if #available(iOS 16.0, *) {
                ExampleMVVMPropertyWrappers()
            } else {
                Text("iOS < 16.0")
            }
        }
    }
}
