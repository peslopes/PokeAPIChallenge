//
//  EndpointContract.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

protocol EndpointContract {
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any] { get }
}
