//
//  PokemonListCoordinator.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation
import UIKit

class PokemonListCoordinator: Coordinator {
    var navigationController: UINavigationController

    private let diContainer: AppDIContainer

    init(navigationController: UINavigationController, diContainer: AppDIContainer) {
        self.navigationController = navigationController
        self.diContainer = diContainer
    }
    
    func start() {
        let repo = diContainer.pokemonRepository
        let viewModel = PokemonListViewModel(repository: repo)
        
        let storyboard = UIStoryboard(name: "PokemonListViewController", bundle: nil) // o nome do .storyboard sem extensão
        guard let vc = storyboard.instantiateViewController(
            withIdentifier: "PokemonListViewController"
        ) as? PokemonListViewController else {
            fatalError("PokemonListViewController não encontrado no storyboard")
        }

        vc.title = "Pokemons"
        vc.inject(viewModel: viewModel)
        
        vc.onPokemonSelected = { [weak self] pokemon, image in
            self?.showPokemonDetail(pokemon: pokemon, image: image)
        }
        
        navigationController.pushViewController(vc, animated: false)
    }
    
    private func showPokemonDetail(pokemon: PokemonDetail, image: UIImage?) {
        guard let image = image ?? UIImage(systemName: "multiply.circle") else {
            return
        }
        let detailVM = PokemonDetailViewModel(pokemon: pokemon, image: image)
        
        let storyboard = UIStoryboard(name: "PokemonDetailViewController", bundle: nil)
        guard let detailVC = storyboard.instantiateViewController(
            withIdentifier: "PokemonDetailViewController"
        ) as? PokemonDetailViewController else {
            fatalError("PokemonDetailViewController não encontrado no storyboard")
        }
        
        detailVC.inject(viewModel: detailVM)
        detailVC.title = pokemon.name.capitalized
        
        navigationController.pushViewController(detailVC, animated: true)
    }
}


