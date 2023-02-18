//
//  PokemonData.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 09/02/23.
//

import Foundation

struct PokemonData: Codable {
    let name: String
    let pokemon_species: [Pokemon_Species]
}

struct Pokemon_Species: Codable {
    let name: String
}

//estructura de la imagen
struct Sprites: Decodable {
    let front_default: String
    let front_shiny: String
}

//estructura para obtener la especie [0]
//struct Egg_groups: Codable {
//    let name: String
////    let groupName: String
//    let pokemon_species: [Pokemon_Species]
    
//    enum CodingKeys: String, CodingKey {
//        case groupName = "name"
//    }
//}

