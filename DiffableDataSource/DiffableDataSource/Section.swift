//
//  Section.swift
//  DiffableDataSource
//
//  Created by 강희선 on 2021/11/21.
//

import UIKit
class Section: Hashable{
    let id = UUID()
    var title: String
    var people: [Person]
    init(title: String, people: [Person]){
        self.title = title
        self.people = people
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    static func == (lhs: Section, rhs: Section) -> Bool {
        lhs.id == rhs.id
    }
}


extension Section{
    static var sections: [Section] = [
        Section(title: "intj", people: [
            Person(name: "Kang Hee Seon", age: 26),
            Person(name: "Kim Eun Hae", age: 21)
        ]),
        Section(title: "estp", people: [
            Person(name: "Choi Hong Gyu", age: 32)
        ]),
        Section(title: "istp", people: [
            Person(name: "Choi Soo", age: 16),
            Person(name: "Kim Jung Wook", age: 27),
            Person(name: "Kim Dae Hyuck", age: 12)
        ]),
        Section(title: "entj", people: [
            Person(name: "Baek Eun Soo", age: 42)
        ])
    ]
}
