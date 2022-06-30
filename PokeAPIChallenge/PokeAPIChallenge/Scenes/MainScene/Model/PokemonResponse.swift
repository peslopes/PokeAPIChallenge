//
//  PokemonResponse.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

struct PokemonResponse: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Pokemon]?
}

struct Pokemon: Decodable {
    let name: String?
    let url: String?
}
