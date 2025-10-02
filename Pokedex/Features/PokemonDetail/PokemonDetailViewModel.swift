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
}
