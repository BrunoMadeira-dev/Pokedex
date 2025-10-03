//
//  PokemonListViewController.swift
//  Pokedex
//
//  Created by Bruno Madeira on 30/09/2025.
//

import UIKit

final class PokemonListViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
    private var viewModel: PokemonListViewModel
    
    private var pokemons: [PokemonDetail] = []
    private var isFetching = false
    private let pageSize = 20
    
    var onPokemonSelected: ((PokemonDetail, UIImage) -> Void)?
    
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
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    
    func inject(viewModel: PokemonListViewModel) {
        self.viewModel = viewModel
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

//MARK: - Tableviews delegates

extension PokemonListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        pokemons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PokemonCell", for: indexPath) as! PokemonCell
        cell
            .configure(
                with: pokemons[indexPath.row]
            )
        let pokemon = pokemons[indexPath.row]
        cell.favoriteImg.image = FavoritePokemonManager.shared
            .isFavorite(pokemonId: pokemon.id) ?
        UIImage(systemName: "heart.fill") :
        UIImage(systemName: "heart")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableview.deselectRow(at: indexPath, animated: true)
        let selectedPokemon = pokemons[indexPath.row]
        let cell = tableView.cellForRow(at: indexPath) as? PokemonCell
        guard let image = cell?.pokemonImage.image ?? UIImage(systemName: "multiply.circle") else {
            return
        }
        onPokemonSelected?(selectedPokemon, image)
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
