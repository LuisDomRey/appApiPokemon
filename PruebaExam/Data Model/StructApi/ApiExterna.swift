//
//  ApiExterna.swift
//  PruebaExam
//
//  Created by Develop MX iOS on 14/02/23.
//

import Foundation

struct ApiExterna: Decodable, Identifiable{
    let id: Int
    let name: String
    let attack: Int
    let defense: Int
    let imageUrl: String
    let type: String
}
