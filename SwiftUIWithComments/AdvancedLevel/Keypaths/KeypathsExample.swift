//
//  KeypathsExample.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 13/11/23.
//
//  Origin: https://youtu.be/FmjG6mG-GIA?si=PZW4C-5_nGr0L5Uv&t=846

import SwiftUI

// Structure created to illustrate the example
struct MyDataModel {
    let id = UUID().uuidString
    let title: String
    let count: Int
    let date: Date
}

/*
    With this extension we have an approach to how we could create our own
    custom functions to sort an array, in this case of the MyDataModel type.
    Obviously this first extension is very little useful as it is coupled
    to the MyDataModel data model...
 */
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

/*
    This other extension would already be usable in any project, since it works
    on generic data whose only requirement is that its keypaths be of
    a "Comparable" data type
 */
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
    
    mutating func sortByKeyPath<T: Comparable>(_ keyPath: KeyPath<Element, T>, ascending: Bool = true) {
        self.sort { item1, item2 in
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
            
            /*
                Some examples of use of each of the functions created in the
                extensions, so that you can see the progression and how their
                use is becoming increasingly generic.
             */
            
            let array = [
                MyDataModel(title: "Three", count: 3, date: .distantFuture),
                MyDataModel(title: "One", count: 1, date: .now),
                MyDataModel(title: "Two", count: 2, date: .distantPast)
            ]
            
            _ = array.customSorted()
            _ = array.customSortedKeypath(keyPath: \.count)
            _ = array.customSortedMoreGeneric(keyPath: \.date)
            _ = array.sortedByKeyPath(\.title)
            
            var exampleSort = array
            exampleSort.sortByKeyPath(\.date)
            
            dataArray = exampleSort
        })
    }
}

#Preview {
    KeypathsExample()
}
