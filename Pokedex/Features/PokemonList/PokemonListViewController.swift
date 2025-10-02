//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Bruno Madeira on 30/09/2025.
//

import UIKit

final class PokemonListViewController: UIViewController {
    
    private let viewModel: PokemonListViewModel
    
    private var pokemons: [Pokemon] = []
    private var isFetching = false
    private let pageSize = 20
    
    @IBOutlet weak var tableview: UITableView!
    
    init(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        let repository = AppDIContainer.shared.pokemonRepository
        self.viewModel = PokemonListViewModel(repository: repository)
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        //setupButton()
        tableview.delegate = self
        tableview
            .register(
                UINib(nibName: "PokemonCell", bundle: nil),
                forCellReuseIdentifier: "PokemonCell"
            )
        Task {
            await fetchPokemons()
        }
        bindViewModel()
        tableview.dataSource = self
    }
    
    private func bindViewModel() {
        viewModel.onPokemonsFetched = { [weak self] pokemons in
            guard let self else { return }
            self.pokemons = pokemons
            self.tableview.reloadData()
        }
        self.isFetching = false
    }
    
    
    private func fetchPokemons() {
        Task {
            await viewModel.fetchPokemons(offset: 0, limit: pageSize)
        }
    }
}

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        cell.pokemonLbl.text = pokemons[indexPath.row].name
        cell.pokemonImage.image = UIImage(systemName: "chevron.right")
        cell.pokemonCellView.backgroundColor = .clear
        cell.pokemonCellStack.backgroundColor = .clear
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == pokemons.count - 1 {
            
            Task {
                await viewModel
                    .fetchPokemons(
                        offset: viewModel.pokemons.count,
                        limit: pageSize
                    )
            }
        }
    }
}
