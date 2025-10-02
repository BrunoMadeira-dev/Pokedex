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
    
    func getPokemonListWithDetails(offset: Int, limit: Int) async throws -> [PokemonDetail] {
        let list = try await getPokemonList(offset: offset, limit: limit)
        
        return try await withThrowingTaskGroup(of: PokemonDetail.self) { group in
            var details: [PokemonDetail] = []
            
            for pokemon in list {
                group.addTask {
                    let detailUrl = "https://pokeapi.co/api/v2/pokemon/\(pokemon.name)"
                    return try await self.apiClient.responseCall(
                        url: detailUrl,
                        responseType: PokemonDetail.self
                    )
                }
            }
            
            for try await detail in group {
                details.append(detail)
            }
            
            return details.sorted { $0.id < $1.id }
        }
    }
}
