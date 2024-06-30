//
//  Resolver.swift
//  SudokuSolver
//
//  Created by Bohdan Savych on 29/5/22.
//

import Foundation

enum DIScope {
  case singleton
  case new
}

protocol DIRegistrator {
    func register<Element>(object: @escaping () -> Element, in scope: DIScope)
    func register<Element, Param1>(object: @escaping (Param1) -> Element, in scope: DIScope)
    func register<Element, Param1, Param2>(object: @escaping (Param1, Param2) -> Element, in scope: DIScope)
    func register<Element, Param1, Param2, Param3>(object: @escaping (Param1, Param2, Param3) -> Element, in scope: DIScope)
}

protocol DIResolver {
    func resolve<Element>(type: Element.Type) -> Element
    func resolve<Element, Param1>(type: Element.Type, param: Param1) -> Element
    func resolve<Element, Param1, Param2>(type: Element.Type, params: (Param1, Param2)) -> Element
    func resolve<Element, Param1, Param2, Param3>(type: Element.Type, params: (Param1, Param2, Param3)) -> Element
}

typealias DIProtocol = DIRegistrator & DIResolver
 
final class DI: DIProtocol {
  private lazy var singletons = [String: Any]()
  private lazy var functions = [String: Any]()
  private lazy var scopes = [String: DIScope]()
  
  // MARK: - Register
  
  func register<Element>(object: @escaping () -> Element, in scope: DIScope) {
    let string = String(reflecting: Element.self)
    self.register(object, id: string, scope: scope)
  }
  
  func register<Element, Param1>(object:  @escaping (Param1) -> Element, in scope: DIScope) {
    let string = String(reflecting: Element.self)
    self.register(object, id: string, scope: scope)

  }
  
  func register<Element, Param1, Param2>(object:  @escaping (Param1, Param2) -> Element, in scope: DIScope) {
    let string = String(reflecting: Element.self)
    self.register(object, id: string, scope: scope)
  }
  
  func register<Element, Param1, Param2, Param3>(object: @escaping (Param1, Param2, Param3) -> Element, in scope: DIScope) {
    let string = String(reflecting: Element.self)
    self.register(object, id: string, scope: scope)
  }

//    func register<Element, each Param>(object: @escaping (repeat each Param) -> Element, in scope: DIScope) {
//        let string = String(reflecting: Element.self)
//        self.register(object, id: string, scope: scope)
//    }

  private func register(_ obj: Any, id: String, scope: DIScope) {
    self.scopes[id] = scope
    self.functions[id] = obj
  }
  
  // MARK: - Resolve
  
  
  func resolve<Element>(type: Element.Type) -> Element {
    let string = String(reflecting: Element.self)
    guard let scope = self.scopes[string] else {
      fatalError("The object of type \(string) is not registered")
    }
    
    switch scope {
    case .new:
      let f = self.functions[string] as! () -> Element
      return f()
    case .singleton:
      if let obj = singletons[string] as? Element {
        return obj
      } else {
        let f = self.functions[string] as! () -> Element
        let obj = f()
        singletons[string] = obj
        return obj
      }
    }
  }
  
  func resolve<Element, Param1>(type: Element.Type, param: Param1) -> Element {
    let string = String(reflecting: Element.self)
    guard let scope = self.scopes[string] else {
      fatalError("The object of type \(string) is not registered")
    }
    
    switch scope {
    case .new:
      let f = self.functions[string] as! (Param1) -> Element
      return f(param)
    case .singleton:
      if let obj = singletons[string] as? Element {
        return obj
      } else {
        let f = self.functions[string] as! (Param1) -> Element
        let obj = f(param)
        singletons[string] = obj
        return obj
      }
    }
  }
  
  func resolve<Element, Param1, Param2>(type: Element.Type, params: (Param1, Param2)) -> Element {
    let string = String(reflecting: Element.self)
    guard let scope = self.scopes[string] else {
      fatalError("The object of type \(string) is not registered")
    }
    
    switch scope {
    case .new:
      let f = self.functions[string] as! (Param1, Param2) -> Element
      return f(params.0, params.1)
    case .singleton:
      if let obj = singletons[string] as? Element {
        return obj
      } else {
        let f = self.functions[string] as! (Param1, Param2) -> Element
        let obj = f(params.0, params.1)
        singletons[string] = obj
        return obj
      }
    }
  }
  
  func resolve<Element, Param1, Param2, Param3>(type: Element.Type, params: (Param1, Param2, Param3)) -> Element {
    let string = String(reflecting: Element.self)
    guard let scope = self.scopes[string] else {
      fatalError("The object of type \(string) is not registered")
    }
    
    switch scope {
    case .new:
      let f = self.functions[string] as! (Param1, Param2, Param3) -> Element
      return f(params.0, params.1, params.2)
    case .singleton:
      if let obj = singletons[string] as? Element {
        return obj
      } else {
        let f = self.functions[string] as! (Param1, Param2, Param3) -> Element
        let obj = f(params.0, params.1, params.2)
        singletons[string] = obj
        return obj
      }
    }
  }
}
