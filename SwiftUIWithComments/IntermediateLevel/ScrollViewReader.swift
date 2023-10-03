//
//  ScrollViewReader.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 3/10/23.
//

import SwiftUI

struct ScrollViewReaderExample: View {
    
    @State private var scrollToIndex: Int = 0
    @State private var textFieldText: String = ""
    
    var body: some View {
        VStack {
            
            TextField("Enter a # here...", text: $textFieldText)
                .frame(height: 55)
                .border(Color.gray)
                .padding(.horizontal)
                .keyboardType(.numberPad)
                .multilineTextAlignment(.center)
            
            Button("SCROLL NOW") {
                withAnimation(.easeIn(duration: 2)) {
                    if let index = Int(textFieldText) {
                        scrollToIndex = index
                    }
                }
            }
            
            ScrollView {
                ScrollViewReader { proxy in
                    ForEach(0..<50) { index in
                        Text("This is item #\(index)")
                            .font(.headline)
                            .frame(height: 200)
                            .frame(maxWidth: .infinity)
                            .background(.white)
                            .cornerRadius(10)
                            .shadow(radius: 10)
                            .padding()
                            .id(index)
                    }
                    .onChange(of: scrollToIndex) { scrollToIndex in
                        withAnimation(.spring()) {
                            proxy.scrollTo(scrollToIndex)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ScrollViewReaderExample()
}
