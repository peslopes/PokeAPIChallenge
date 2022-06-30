//
//  Parser.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 29/06/22.
//

import Foundation

class Parser: ParserContract {
    
    private let requester: RequesterContract
    
    init(requester: RequesterContract = Requester()) {
        self.requester = requester
    }
    
    func parseData<T: Decodable>(from endpoint: EndpointContract,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        let api = PokeApi(endpoint: endpoint)
        requester.execute(api: api) { result in
            switch result {
            case .success(let data):
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func parseData<T: Decodable>(from url: String,
                                 completion: @escaping (Result<T, Error>) -> Void) {
        guard let urlRequest = URLFactory.makeURLRequester(baseURL: url) else {
            completion(.failure(RequesterError.invalidURL))
            return
        }
        requester.execute(urlRequest: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let object = try JSONDecoder().decode(T.self, from: data)
                    completion(.success(object))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func getRawData(from url: String,
                    completion: @escaping (Result<Data, Error>) -> Void) {
        guard let urlRequest = URLFactory.makeURLRequester(baseURL: url) else {
            completion(.failure(RequesterError.invalidURL))
            return
        }
        requester.execute(urlRequest: urlRequest, completion: completion)
    }
}
