//
//  Requester.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

class Requester: RequesterContract {
    let session: URLSession
        
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func execute(api: ApiContract,
                 completion: @escaping (Result<Data, Error>) -> Void) {
        
        guard var urlRequest = URLFactory.makeURLRequester(baseURL: api.baseURL,
                                                           path: api.endpoint.path,
                                                           parameters: api.endpoint.parameters) else {
            completion(.failure(RequesterError.invalidURL))
            return
        }
        
        urlRequest.httpMethod = api.endpoint.method.rawValue
        
        execute(urlRequest: urlRequest, completion: completion)
        
    }
    
    func execute(urlRequest: URLRequest,
                 completion: @escaping (Result<Data, Error>) -> Void) {
        session.dataTask(with: urlRequest) { data, response, error in
            guard error == nil else {
                completion(.failure(RequesterError.requestError(localizedDescription: error?.localizedDescription ?? "")))
                return
            }
            guard let data = data else {
                completion(.failure(RequesterError.unknownError))
                return
            }
            completion(.success(data))
        }.resume()
    }
}
