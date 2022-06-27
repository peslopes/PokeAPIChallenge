//
//  RequesterError.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

enum RequesterError: Error {
    case requestError(localizedDescription: String)
    case invalidURL
    case unknownError
}
