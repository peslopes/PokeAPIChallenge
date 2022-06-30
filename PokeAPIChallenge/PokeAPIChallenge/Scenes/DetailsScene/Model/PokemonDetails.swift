//
//  DetailSceneService.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 29/06/22.
//

import Foundation

enum PokemonDetailsKeys: CaseIterable {
    case name
    case height
    case weight
    case abilities
    case forms
    case moves
    
    var toString: String {
        switch self {
            
        case .name:
            return "Name"
        case .height:
            return "Height"
        case .weight:
            return "Weight"
        case .abilities:
            return "Abilities"
        case .forms:
            return "Forms"
        case .moves:
            return "Moves"
        }
    }
    
    var id: Int {
        switch self {
        case .name:
            return 0
        case .height:
            return 1
        case .weight:
            return 2
        case .abilities:
            return 3
        case .forms:
            return 4
        case .moves:
            return 5
        }
    }
}

struct PokemonDetails: Decodable {
    private let name: String?
    private let abilities: [Ability]?
    private let forms: [Item]?
    private let height: Int?
    private let moves: [Move]?
    private let weight: Int?
    let sprites: PokemonSprites?
    
    var detailsDictionary: [PokemonDetailsKeys: Any] {
        var dictionary: [PokemonDetailsKeys: Any] = [:]
        PokemonDetailsKeys.allCases.forEach {
            switch $0 {
            case .name:
                dictionary[.name] = name
            case .abilities:
                dictionary[.abilities] = abilities?.compactMap { $0.ability?.name }
            case .forms:
                dictionary[.forms] = forms?.compactMap { $0.name }
            case .height:
                dictionary[.height] = height
            case .moves:
                dictionary[.moves] = moves?.compactMap { $0.move?.name }
            case .weight:
                dictionary[.weight] = weight
            }
        }
        
        return dictionary
    }
}

struct Ability: Decodable {
    let ability: Item?
}

struct Move: Decodable {
    let move: Item?
}

struct Item: Decodable {
    let name: String?
}
