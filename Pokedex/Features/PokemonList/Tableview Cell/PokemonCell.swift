//
//  PokemonCell.swift
//  Pokedex
//
//  Created by Bruno Madeira on 01/10/2025.
//

import Foundation
import UIKit

class PokemonCell: UITableViewCell {
    
    @IBOutlet weak var pokemonImage: UIImageView!
    @IBOutlet weak var pokemonLbl: UILabel!
    @IBOutlet weak var pokemonCellView: UIView!
    @IBOutlet weak var pokemonCellStack: UIStackView!
    @IBOutlet weak var favoriteImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        pokemonCellStack.backgroundColor = UIColor.clear
        pokemonCellView.backgroundColor = UIColor.clear
    }
    
    func configure(with pokemon: PokemonDetail) {
        pokemonLbl.text = pokemon.name.capitalized

        if let urlString = pokemon.sprites.front_default,
           let url = URL(string: urlString) {
            loadImage(from: url)
        }
    }
    
    private func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, _, _ in
            if let data = data,
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    self.pokemonImage.image = image
                }
            }
        }.resume()
    }
}
