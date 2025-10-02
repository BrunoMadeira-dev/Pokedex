//
//  PokemonListCoordinator.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation
import UIKit

import UIKit

final class PokemonListCoordinator: Coordinator {

    var navigationController: UINavigationController
    private let diContainer: AppDIContainer

        init(navigationController: UINavigationController, diContainer: AppDIContainer) {
            self.navigationController = navigationController
            self.diContainer = diContainer
        }
    
    func start() {
        
        let storyboard = UIStoryboard(name: "PokemonListViewController", bundle: nil) // o nome do .storyboard sem extensão
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "PokemonListViewController"
        ) as? PokemonListViewController else {
            fatalError("PokemonListViewController não encontrado no storyboard")
        }
//        let viewModel = PokemonListViewModel(repository: diContainer.pokemonRepository)
//        let vc = PokemonListViewController(viewModel: viewModel)
        vc.title = "Pokemons"
        navigationController.pushViewController(vc, animated: false)
    }
}


