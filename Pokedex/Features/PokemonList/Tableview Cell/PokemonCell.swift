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

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
