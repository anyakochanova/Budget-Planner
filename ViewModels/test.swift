//
//  test.swift
//  Budget
//
//  Created by Anna Kochanova on 07.04.2026.
//

import Foundation

class A {
    var b: B?
    deinit { print("A deinit") }
}

class B {
    weak var a: A?
    deinit { print("B deinit") }
}

var a: A? = A()
var b: B? = B()

a?.b = b
b?.a = a

a = nil
b = nil
