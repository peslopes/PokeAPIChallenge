//
//  ApiContract.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

protocol ApiContract {
    var baseURL: String { get }
    var endpoint: EndpointContract { get }
}
