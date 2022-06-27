//
//  MainSceneService.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

class MainSceneService: ServiceContract {
    
    private let requester: RequesterContract
    
    init(requester: RequesterContract = Requester()) {
        self.requester = requester
    }
    
    func fetch<T: Decodable>(endpoint: EndpointContract,
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
    
    func fetch<T: Decodable>(url: String,
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
}
