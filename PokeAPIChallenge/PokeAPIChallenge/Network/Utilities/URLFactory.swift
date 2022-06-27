//
//  URLFactory.swift
//  PokeAPIChallenge
//
//  Created by Pedro Sobrosa on 27/06/22.
//

import Foundation

class URLFactory {
    static func makeURLRequester(baseURL: String, path: String = "", parameters: [String: Any] = [:]) -> URLRequest? {
        var parametersString = ""
        if !parameters.isEmpty {
            let parametersList: [String] = parameters.map { "\($0.key)=\($0.value)" }
            parametersString = parametersList.joined(separator: "&")
            parametersString = "?\(parametersString)"
        }
        
        guard let url = URL(string: "\(baseURL)\(path)\(parametersString)") else { return nil }
        return URLRequest(url: url)
    }
}
