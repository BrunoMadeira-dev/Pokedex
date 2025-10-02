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
    @IBOutlet weak var pokemonDesc1: UILabel!
    @IBOutlet weak var pokemonDesc2: UILabel!
    @IBOutlet weak var pokemonDesc3: UILabel!
    @IBOutlet weak var pokemonDesc4: UILabel!
    @IBOutlet weak var pokemonDesc5: UILabel!
    @IBOutlet weak var pokemonDesc6: UILabel!
    
    
    private var viewModel: PokemonDetailViewModel!
    
    func inject(viewModel: PokemonDetailViewModel) {
        self.viewModel = viewModel
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    func setupUI() {
        pokemonImage.image = viewModel.image
        pokemonDesc1.text = "Name: " + viewModel.pokemon.name
        pokemonDesc2.text = "Height: " + String(viewModel.pokemon.height)
        pokemonDesc3.text = "Weight: " + String(viewModel.pokemon.weight)
        pokemonDesc4.text = "Type: " + viewModel.pokemon.types.map { $0.type.name }.joined(separator: ", ")
        pokemonDesc5.text = ""
        pokemonDesc6.text = "test"
    }
}
