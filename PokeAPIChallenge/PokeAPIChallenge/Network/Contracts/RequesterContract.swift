//
//  RequesterContract.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

protocol RequesterContract {
    func execute(api: ApiContract, completion: @escaping (Result<Data, Error>) -> Void)
    func execute(urlRequest: URLRequest, completion: @escaping (Result<Data, Error>) -> Void)
}
