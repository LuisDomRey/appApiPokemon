//
//  Pokemon.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 09/02/23.
//

import Foundation
import RealmSwift

class Pokemon: Object {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String = ""
    @objc dynamic var attack: Int = 0
    @objc dynamic var defense: Int = 0
    @objc dynamic var imageUrl: String = ""
    @objc dynamic var type: String = ""

}
