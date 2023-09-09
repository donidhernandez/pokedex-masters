//
//  PokemonsViewModel.swift
//  Pokedex-Masters
//
//  Created by Doni on 9/9/23.
//

import Foundation

final class PokemonViewModel: ObservableObject {
    @Published private(set) var pokemonsList: [Result] = []
    @Published private(set) var error: NetworkManager.NetworkError?
    @Published var hasError = false
    
    private(set) var page: Int = 1
    
    private let networkManager: NetworkManagerProtocol!
    
    init(networkManager: NetworkManagerProtocol! = NetworkManager.shared) {
        self.networkManager = networkManager
    }
    
    @MainActor
    func getAllPokemon() async {
        do {
            let response = try await networkManager.request(session: .shared, .allPokemon(page: page), type: PokemonAPIResponse.self)
            pokemonsList = response.results
        } catch {
            self.hasError = true
            if let networkError = error as? NetworkManager.NetworkError {
                self.error = networkError
            } else {
                self.error = .custom(error: error)
            }
        }
    }
}
