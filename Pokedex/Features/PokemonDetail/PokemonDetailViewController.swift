//
//  PokemonDetailViewController.swift
//  Pokedex
//
//  Created by Bruno Madeira on 02/10/2025.
//

import Foundation
import UIKit

class PokemonDetailViewController: UIViewController {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var descriptionView: UIView!
    @IBOutlet weak var tableview: UITableView!

    private var favoriteButton: UIBarButtonItem!
    private var viewModel: PokemonDetailViewModel!
    
    func inject(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFavoriteButton()
        
        tableview.delegate = self
        tableview.dataSource = self
        tableview
            .register(
                UINib(nibName: "PokemonDetailCell", bundle: nil),
                forCellReuseIdentifier: "PokemonDetailCell"
            )
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableview.reloadData()
    }
    
    func setupUI() {
        
        self.view.backgroundColor = UIColor.systemGray4
        
        descriptionView.backgroundColor = UIColor.white
        descriptionView.layer.cornerRadius = 18.0
        
        tableview.layer.cornerRadius = 18.0
        
        pokemonImage.image = viewModel.image
        pokemonImage.layer.cornerRadius = 10.0
        pokemonImage.layer.shadowColor = UIColor.black.cgColor
        pokemonImage.layer.shadowOffset = CGSize(width: 1, height: 1)
        pokemonImage.layer.shadowOpacity = 0.5
    }
    
    private func setupFavoriteButton() {
        favoriteButton = UIBarButtonItem(
            image: UIImage(systemName: viewModel.isFavorite() ? "heart.fill" : "heart"),
            style: .plain,
            target: self,
            action: #selector(favoriteTapped)
        )
        navigationItem.rightBarButtonItem = favoriteButton
    }
    
    @objc private func favoriteTapped() {
        viewModel.toggleFavorite()
        favoriteButton.image = UIImage(systemName: viewModel.isFavorite() ? "heart.fill" : "heart")
    }
    
}

extension PokemonDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.detailItems.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "PokemonDetailCell",
            for: indexPath
        ) as! PokemonDetailCell
        let item = viewModel.detailItems[indexPath.row]
        
        cell.pokeTitle.text = item.title
        cell.pokeDetail.text = item.value
        return cell
    }

    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10 // altura do espaçamento
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = .clear // cor do fundo do "espaço"
        return view
    }
}
