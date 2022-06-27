//
//  PokeApi.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

struct PokeApi: ApiContract {
    var baseURL: String
    
    var endpoint: EndpointContract
    
    init(baseURL: String = "https://pokeapi.co/api/v2", endpoint: EndpointContract) {
        self.baseURL = baseURL
        self.endpoint = endpoint
    }
}
