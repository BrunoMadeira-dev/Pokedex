//
//  PokemonDetailViewModel.swift
//  Pokedex
//
//  Created by Bruno Madeira on 02/10/2025.
//

import Foundation
import UIKit

class PokemonDetailViewModel {
    let pokemon: PokemonDetail
    let image: UIImage

    init(pokemon: PokemonDetail, image: UIImage) {
        self.pokemon = pokemon
        self.image = image
    }
    
    struct PokemonDetailItem {
        let title: String
        let value: String
    }
    
    var detailItems: [PokemonDetailItem] {
        return [
            PokemonDetailItem(title: "Name:", value: pokemon.name.capitalized),
            PokemonDetailItem(title: "Height:", value: String(pokemon.height)),
            PokemonDetailItem(title: "Weight:", value: String(pokemon.weight)),
            PokemonDetailItem(
                title: "Type:",
                value: pokemon.types.map { $0.type.name }.joined(separator: ", ")
            ),
            PokemonDetailItem(
                title: "Base Stats:",
                value: pokemon.stats
                    .map { "\n\($0.stat.name): \($0.base_stat)" }
                    .joined(separator: ", ")
            ),
            PokemonDetailItem(
                title: "Moves:",
                value: pokemon.moves.prefix(5).map { $0.move.name }.joined(separator: ", ")
            )
        ]
    }
    
    func toggleFavorite() {
        if FavoritePokemonManager.shared.isFavorite(pokemonId: pokemon.id) {
            FavoritePokemonManager.shared.removeFavorite(pokemonId: pokemon.id)
        } else {
            FavoritePokemonManager.shared.addFavorite(pokemon: pokemon)
        }
    }
    
    func isFavorite() -> Bool {
        FavoritePokemonManager.shared.isFavorite(pokemonId: pokemon.id)
    }
}
