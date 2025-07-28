//
//  NLPDIContainer.swift
//  NLP
//
//  Created by Ted on 7/27/25.
//
import SwiftUI
import Combine

final class NLPDIContainer {
    static var shared: NLPDIContainer = NLPDIContainer()
    
    @StateObject var coordinator: Coordinator = Coordinator()
    @StateObject var dialogManager: DialogManager = DialogManager()
    
    var dependencies: [String: Any] = [:]
    
    private init() { }
    
    func register<T>(type: T.Type, dependency: Any) {
        let key = String(describing: type)
        dependencies[key] = dependency
    }
    
    func resolve<T>(_ type: T.Type) -> T? {
        let key = String(describing: type)
        return dependencies[key] as? T
    }
}
