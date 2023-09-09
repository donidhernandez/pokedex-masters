//
//  PokemonApiResponse.swift
//  Pokedex-Masters
//
//  Created by Doni on 9/9/23.
//

import Foundation

struct PokemonAPIResponse: Codable {
    let count: Int
    let next: String?
    let previous: String?
    let results: [Result]
}

struct Result: Codable {
    let name: String
    let url: String
}
