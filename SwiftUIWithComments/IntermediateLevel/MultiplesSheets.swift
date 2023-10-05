//
//  MultiplesSheets.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 5/10/23.
//
// origin: https://youtu.be/8rCtYoG9JIM?si=byaNXA3g-JjLKtse&t=791

import SwiftUI

/*  ----------------------------------------------------------------------
    This example does not work because when the sheet is loaded, at first,
    selectModel contains the randomModel created with "STARTING TITLE" and
    the subsequent assignment does not vary the content of this sheet.
    ----------------------------------------------------------------------
 */

struct MultiplesSheetsBad: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button1") {
                selectedModel = RandomModel(title: "ONE")
                showSheet.toggle()
            }
            
            Button("Button2") {
                selectedModel = RandomModel(title: "TWO")
                showSheet.toggle()
            }
        }
        .sheet(isPresented: $showSheet, content: {
            NextScreen(selectedModel: selectedModel)
        })
    }
}

/*  ----------------------------------------------------------------------
    This example does work, but sometimes we can't or don't want our child
    view to receive a bound property.
    ----------------------------------------------------------------------
 */

struct MultiplesSheetsBinding: View {
    
    @State var selectedModel: RandomModel = RandomModel(title: "STARTING TITLE")
    @State var showSheet: Bool = false
    
    var body: some View {
        VStack(spacing: 20) {
            Button("Button1") {
                selectedModel = RandomModel(title: "ONE")
                showSheet.toggle()
            }
            
            Button("Button2") {
                selectedModel = RandomModel(title: "TWO")
                showSheet.toggle()
            }
        }
        .sheet(isPresented: $showSheet, content: {
            NextScreenBinding(selectedModel: $selectedModel)
        })
    }
}

struct NextScreenBinding: View {
    
    @Binding var selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct NextScreen: View {
    
    let selectedModel: RandomModel
    
    var body: some View {
        Text(selectedModel.title)
            .font(.largeTitle)
    }
}

struct RandomModel: Identifiable {
    let id = UUID().uuidString
    let title: String
}


#Preview {
    MultiplesSheetsBinding()
}
