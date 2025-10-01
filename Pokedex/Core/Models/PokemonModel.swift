//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation


class PokemonListResponse: Codable {
    let results: [Pokemon]
}

class Pokemon: Codable {
    let name: String
    let url: String
}
