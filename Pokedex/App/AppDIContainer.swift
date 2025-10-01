//
//  AppDIContainer.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation
import UIKit

final class AppDIContainer {
// MARK: - Core services
    
    lazy var apiClient: NetworkingCall = {
        return NetworkingCall()
    }()

    lazy var pokemonRepository: PokemonRepository = {
        PokemonRepositoryImpl(apiClient: apiClient)
    }()

}
