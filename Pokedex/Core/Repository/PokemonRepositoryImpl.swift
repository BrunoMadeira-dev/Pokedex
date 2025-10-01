//
//  PokemonRepositoryImpl.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation

class PokemonRepositoryImpl: PokemonRepository {
    
   // private let repository: PokemonRepository
    @Published var pokemons: [Pokemon] = []
    
    private let apiClient: NetworkingCall
    
    init(apiClient: NetworkingCall) {
        self.apiClient = apiClient
    }
    
    func getPokemonList(page: Int) async throws -> [Pokemon] {
            let limit = 20
            let offset = (page - 1) * limit
            let url = "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)"
            
            // Chamada async/await correta
            let response: PokemonListResponse = try await apiClient.responseCall(
                url: url,
                responseType: PokemonListResponse.self
            )
            
           return response.results
        }
}
