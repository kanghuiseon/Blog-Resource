//
//  Person.swift
//  DiffableDataSource
//
//  Created by 강희선 on 2021/11/21.
//

import UIKit
class Person: Hashable{
    let id = UUID()
    var name: String
    var age: Int
    init(name: String, age: Int){
        self.name = name
        self.age = age
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Person, rhs: Person) -> Bool {
        lhs.id == rhs.id
    }
}
