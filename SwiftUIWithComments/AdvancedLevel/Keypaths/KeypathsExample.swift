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
    
    func customSorted() -> [Element] {
        self.sorted { item1, item2 in
            item1.count < item2.count
        }
    }
    
    func customSortedKeypath(keyPath: KeyPath<MyDataModel, Int>) -> [Element] {
        self.sorted { item1, item2 in
            item1[keyPath: keyPath] < item2[keyPath: keyPath]
        }
    }
    
    func customSortedMoreGeneric<T: Comparable>(keyPath: KeyPath<MyDataModel, T>) -> [Element] {
        self.sorted { item1, item2 in
            item1[keyPath: keyPath] < item2[keyPath: keyPath]
        }
    }
}

extension Array {
    
    func sortedByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) -> [Element] {
        self.sorted { item1, item2 in
            let value1 = item1[keyPath: keyPath]
            let value2 = item2[keyPath: keyPath]
            
            return ascending
            ? value1 < value2
            : value1 > value2
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
            let otherArray = array.customSortedKeypath(keyPath: \.count)
            let arraySortedByDate = array.customSortedMoreGeneric(keyPath: \.date)
            let arraySortedGeneric = array.sortedByKeyPath(\.title)
            
            dataArray = arraySortedGeneric
        })
    }
}

#Preview {
    KeypathsExample()
}
