//
//  PersonCollectionViewCell.swift
//  DiffableDataSource
//
//  Created by 강희선 on 2021/11/21.
//

import UIKit

class PersonCollectionViewCell: UICollectionViewCell {
    @IBOutlet var name: UILabel!
    
    var person: Person?{
        didSet{
            name.text = person?.name
        }
    }
}
