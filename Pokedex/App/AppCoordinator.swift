//
//  AppCoordinator.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation
import UIKit

protocol Coordinator: AnyObject {
    var navigationController: UINavigationController { get set }
    func start()
}

class AppCoordinator: Coordinator {
    var navigationController: UINavigationController

    private var window: UIWindow?
    private let diContainer: AppDIContainer
    private var childCoordinator: Coordinator?
    
    init(window: UIWindow, diContainer: AppDIContainer) {
        self.window = window
        self.diContainer = diContainer
        self.navigationController = UINavigationController()
    }

    func start() {
        let pokemonCoordinator = PokemonListCoordinator(
            navigationController: UINavigationController(),
            diContainer: diContainer
        )
        self.childCoordinator = pokemonCoordinator
        window?.rootViewController = pokemonCoordinator.navigationController
        window?.makeKeyAndVisible()
        pokemonCoordinator.start()
    }
}
