//
//  Pokemones.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 09/02/23.
//

import Foundation
import RealmSwift

class Pokemones: Object {
    @objc dynamic var elemento: String = ""
    @objc dynamic var color: String = ""
    let pokemons = List<Pokemon>()
}


