//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Bruno Madeira on 30/09/2025.
//

import Foundation

class PokemonListViewModel {
    var pokemons: [PokemonDetail] = []

    var onPokemonsFetched: (([PokemonDetail]) -> Void)?
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }
    
    @MainActor
    func fetchPokemons(offset: Int, limit: Int) async {
        do {
            let result = try await repository.getPokemonListWithDetails(offset: offset, limit: limit)
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
