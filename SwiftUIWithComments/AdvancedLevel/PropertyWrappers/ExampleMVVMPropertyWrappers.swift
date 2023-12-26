//
//  ExampleMVVMPropertyWrappers.swift
//  SwiftUIWithComments
//
//  Created by Jose Manuel Ortiz Sanchez on 11/12/23.
//


import SwiftUI
import Combine

// Review this!!

@propertyWrapper
public struct MyPublished<Value> {
    
    private var publisher: Publisher
    
    public var wrappedValue: Value {
        willSet {  // Before modifying wrappedValue
            publisher.subject.send(newValue)
            print("newValue: \(newValue)")
        }
    }
    
    public var projectedValue: Publisher {
        publisher
    }
    
    public init(wrappedValue: Value) {
        self.wrappedValue = wrappedValue
        publisher = Publisher(wrappedValue)
    }
    
    public static subscript<OuterSelf: ObservableObject>(
        _enclosingInstance observed: OuterSelf,
        wrapped wrappedKeyPath: ReferenceWritableKeyPath<OuterSelf, Value>,
        storage storageKeyPath: ReferenceWritableKeyPath<OuterSelf, Self>
    ) -> Value {
        get {
            observed[keyPath: storageKeyPath].wrappedValue
        }
        set {
            if let subject = observed.objectWillChange as? ObservableObjectPublisher {
                subject.send() // Before modifying wrappedValue
                observed[keyPath: storageKeyPath].wrappedValue = newValue
            }
        }
    }
    
    public struct Publisher: Combine.Publisher {
        public typealias Output = Value
        public typealias Failure = Never
        var subject: CurrentValueSubject<Value, Never> // PassthroughSubject will lack the call of initial assignment
        public func receive<S>(subscriber: S) where S: Subscriber, Self.Failure == S.Failure, Self.Output == S.Input {
            subject.subscribe(subscriber)
        }
        init(_ output: Output) {
            subject = .init(output)
        }
    }
}

@available(iOS 16.0, *)
final class ExampleMVVMPropertyWrappersViewModel: ObservableObject {
    @MyPublished var name: String = "Alberto Ortiz"
    @FileManagerCodableStreamableProperty(\.userProfile) var userProfile
    
    init() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            self.name = "José Manuel Ortiz Sánchez"
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) {
            self.userProfile = User(name: "Zeus", age: 12, isPremium: true)
        }
    }
}

@available(iOS 16.0, *)
struct ExampleMVVMPropertyWrappers: View {
    
    @StateObject var viewmodel = ExampleMVVMPropertyWrappersViewModel()
    
    var body: some View {
        VStack {
            Text(viewmodel.name)
            Text(viewmodel.userProfile?.name ?? "") // no refresh
        }
    }
}

#Preview {
    if #available(iOS 16.0, *) {
        ExampleMVVMPropertyWrappers()
    } else {
        Text("iOS < 16.0")
    }
}
