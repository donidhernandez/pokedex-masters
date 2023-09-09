//
//  PokemonListView.swift
//  Pokedex-Masters
//
//  Created by Doni on 9/9/23.
//

import SwiftUI

struct PokemonListView: View {
    
    @StateObject var pokemonVM = PokemonViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]

    
    var body: some View {
        NavigationStack {
            LazyVGrid(columns: columns) {
                ForEach(pokemonVM.pokemonsList, id: \.name) { pokemon in
                    PokemonCardView(name: pokemon.name)
                }
            }
            .task {
                await pokemonVM.getAllPokemon()
            }
            .navigationTitle("Pokemons")
        }
        
    }
}

struct PokemonListView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonListView()
    }
}
