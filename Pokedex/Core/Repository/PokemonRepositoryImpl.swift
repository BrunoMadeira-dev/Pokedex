//
//  PokemonRepositoryImpl.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation

class PokemonRepositoryImpl: PokemonRepository {
    @Published var pokemons: [Pokemon] = []
    
    private let apiClient: NetworkingCall
    
    init(apiClient: NetworkingCall) {
        self.apiClient = apiClient
    }
    
    func getPokemonList(offset: Int = 0,limit: Int = 20) async throws -> [Pokemon] {

        let url = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
        let response: PokemonListResponse = try await apiClient.responseCall(
            url: url,
            responseType: PokemonListResponse.self
        )
        return response.results
    }
}
