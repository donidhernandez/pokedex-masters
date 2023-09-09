//
//  Endpoint.swift
//  Pokedex-Masters
//
//  Created by Doni on 9/9/23.
//

import Foundation

enum Endpoint {
    case allPokemon(page: Int)
    case pokemonDetails(name: String)
}

extension Endpoint {
    var host: String { "pokeapi.co" }
    var basePath: String { "/api/v2" }
    
    var path: String {
        switch self {
            case .allPokemon:
                return "\(basePath)/pokemon"
            case .pokemonDetails(let name):
                return "\(basePath)/pokemon/\(name)"
        }
    }
    
    var queryItems: [String: String]? {
        switch self {
            case .allPokemon(let page):
                return ["page": "\(page)"]
            default:
                return nil
        }
    }
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        var requestQueryItems = [URLQueryItem]()
        
        queryItems?.forEach({ item in
            requestQueryItems.append(URLQueryItem(name: item.key, value: item.value))
        })
        
        urlComponents.queryItems = requestQueryItems
        
        return urlComponents.url
    }
}
