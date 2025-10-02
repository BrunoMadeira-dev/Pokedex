//
//  PokemonRepository.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation


protocol PokemonRepository {
    func getPokemonList(offset: Int,limit: Int) async throws -> [Pokemon]
}
