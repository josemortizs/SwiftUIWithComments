//
//  KeypathsExample.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 13/11/23.
//
//  Origin: https://youtu.be/FmjG6mG-GIA?si=PZW4C-5_nGr0L5Uv&t=846

import SwiftUI

struct MyDataModel {
    let id = UUID().uuidString
    let title: String
    let count: Int
    let date: Date
}

extension Array where Element == MyDataModel {
    
    func customSorted() -> [MyDataModel] {
        self.sorted { item1, item2 in
            item1.count < item2.count
        }
    }
}

struct KeypathsExample: View {
    
    @AppStorage("user_count") var userCount: Int = 0
    @State private var dataArray: [MyDataModel] = []
    
    var body: some View {
        List {
            ForEach(dataArray, id: \.id) { data in
                VStack(alignment: .leading) {
                    Text(data.id)
                    Text(data.title)
                    Text(data.count.description)
                    Text(data.date.description)
                }
                .font(.headline)
            }
        }
        .onAppear(perform: {
            let array = [
                MyDataModel(title: "Three", count: 3, date: .distantFuture),
                MyDataModel(title: "One", count: 1, date: .now),
                MyDataModel(title: "Two", count: 2, date: .distantPast)
            ]
            
            let newArray = array.customSorted()
            
            dataArray = newArray
        })
    }
}

#Preview {
    KeypathsExample()
}
