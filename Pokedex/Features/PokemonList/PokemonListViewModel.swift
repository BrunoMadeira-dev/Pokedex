//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Bruno Madeira on 30/09/2025.
//

import Foundation

class PokemonListViewModel {
    var pokemons: [Pokemon] = []

    var onPokemonsFetched: (([Pokemon]) -> Void)?
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    @MainActor
    func fetchPokemons(offset: Int, limit: Int) async {
        do {
            let result = try await repository.getPokemonList(offset: offset, limit: limit)
            if offset == 0 {
                pokemons = result
            } else {
                pokemons.append(contentsOf: result)
            }
            onPokemonsFetched?(pokemons)
        } catch {
            print("Error on fetch pokemons: \(error)")
        }
    }
}
