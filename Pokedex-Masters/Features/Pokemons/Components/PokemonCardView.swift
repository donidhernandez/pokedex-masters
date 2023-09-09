//
//  PokemonCardView.swift
//  Pokedex-Masters
//
//  Created by Doni on 9/9/23.
//

import SwiftUI

struct PokemonCardView: View {
    
    @StateObject var pokemonVM = PokemonViewModel()
    var name: String
    
    var body: some View {
        Text(name)
    }
}

struct PokemonCardView_Previews: PreviewProvider {
    static var previews: some View {
        PokemonCardView(name: "pikachu")
    }
}
