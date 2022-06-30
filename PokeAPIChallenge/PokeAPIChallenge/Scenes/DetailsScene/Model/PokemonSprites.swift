//
//  PokemonSprites.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 29/06/22.
//

import Foundation

struct PokemonSprites: Decodable {
    private let back_default: String?
    private let back_shiny: String?
    private let front_default: String?
    private let front_shiny: String?
    
    var sprites: [String] {
        return [back_default, front_default, front_shiny, back_shiny].compactMap { $0 }
    }
}
