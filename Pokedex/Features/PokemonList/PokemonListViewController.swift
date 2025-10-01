//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Bruno Madeira on 30/09/2025.
//

import UIKit

final class PokemonListViewController: UIViewController {
    
    private let viewModel: PokemonListViewModel
    private let tableView = UITableView()
    private let fetchButton = UIButton(type: .system)
    
    private var pokemons: [Pokemon] = []
    
    @IBOutlet weak var tableview: UITableView!
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //setupButton()
        bindViewModel()
    }
    
//    private func setupButton() {
//        let button = UIButton(type: .system)
//        button.setTitle("Fetch Pokemons", for: .normal)
//        button.addTarget(self, action: #selector(fetchTapped), for: .touchUpInside)
//        
//        button.translatesAutoresizingMaskIntoConstraints = false
//        view.addSubview(button)
//        
//        NSLayoutConstraint.activate([
//            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            button.centerYAnchor.constraint(equalTo: view.centerYAnchor)
//        ])
//    }
    
    private func bindViewModel() {
        viewModel.onPokemonsFetched = { [weak self] pokemons in
            guard let self else { return }
            self.pokemons = pokemons
            for pokemon in pokemons {
                print(pokemon.name)
            }
//            DispatchQueue.main.async {
//                self.tableView.reloadData()
//            }
        }
    }
    
    
    @objc private func fetchTapped() {
        Task {
            await viewModel.fetchPokemons()
        }
    }
}
