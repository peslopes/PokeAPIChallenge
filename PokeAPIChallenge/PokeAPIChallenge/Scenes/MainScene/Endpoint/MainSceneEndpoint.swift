//
//  MainSceneEndpoint.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

enum MainSceneEndpoint {
    case getList(limit: Int, offset: Int)
}

// MARK: - EndpointContract
extension MainSceneEndpoint: EndpointContract {    
    var path: String {
        switch self {
        case .getList:
            return "/pokemon"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .getList:
            return .get
        }
    }
    
    var parameters: [String : Any] {
        switch self {
        case .getList(let limit, let offset):
            return ["limit": limit, "offset": offset]
        }
    }
}
