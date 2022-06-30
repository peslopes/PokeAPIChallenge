//
//  ParserContract.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

protocol ParserContract {
    func parseData<T: Decodable>(from url: EndpointContract, completion: @escaping (Result<T, Error>) -> Void)
    
    func parseData<T: Decodable>(from url: String, completion: @escaping (Result<T, Error>) -> Void)
    func getRawData(from url: String, completion: @escaping (Result<Data, Error>) -> Void)
}
