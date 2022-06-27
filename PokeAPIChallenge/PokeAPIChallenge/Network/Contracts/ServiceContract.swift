//
//  ServiceContract.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

protocol ServiceContract {
    func fetch<T: Decodable>(endpoint: EndpointContract, completion: @escaping (Result<T, Error>) -> Void)
    
    func fetch<T: Decodable>(url: String, completion: @escaping (Result<T, Error>) -> Void)
}
