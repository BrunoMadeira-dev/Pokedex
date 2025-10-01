//
//  PokemonListViewModel.swift
//  Pokedex
//
//  Created by Bruno Madeira on 30/09/2025.
//

import Foundation

class PokemonListViewModel {
//    var pokemons: [Pokemon] = []
//    
//    // Closure para informar a View de atualizações
//    var onDataFetched: (([Pokemon]) -> Void)?
//    var onError: ((Error) -> Void)?
    
    var onPokemonsFetched: (([Pokemon]) -> Void)?
    private let repository: PokemonRepository
    
    init(repository: PokemonRepository) {
        self.repository = repository
    }

//    func fetchPokemons() {
//        Task {
//            do {
//                let url = "https://pokeapi.co/api/v2/pokemon?limit=20"
//                let response: PokemonListResponse = try await NetworkingCall.shared.responseCall(url: url, responseType: PokemonListResponse.self)
//                
//                self.pokemons = response.results
//                print("Pokémons:", response.results) // imprime no console
//                
//                // Notifica a view
//                DispatchQueue.main.async {
//                    self.onDataFetched?(response.results)
//                }
//                
//            } catch {
//                print("Erro:", error)
//                DispatchQueue.main.async {
//                    self.onError?(error)
//                }
//            }
//        }
//    }
    
    @MainActor
    func fetchPokemons() async {
        do {
            let result = try await repository.getPokemonList(page: 1)
            //let names = result.map { $0.name }
            //print(names)
            onPokemonsFetched?(result)
        } catch {
            print("Erro ao buscar pokemons: \(error)")
        }
    }
}
