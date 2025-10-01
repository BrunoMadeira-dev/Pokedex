//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation


protocol PokemonRepository {
    func getPokemonList(page: Int) async throws -> [Pokemon]
}
