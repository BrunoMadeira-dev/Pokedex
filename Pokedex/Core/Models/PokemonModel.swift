//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Bruno Madeira on 29/09/2025.
//

import Foundation


class PokemonListResponse: Codable {
    let results: [Pokemon]
}

class Pokemon: Codable {
    let name: String
    let url: String
}

// Detalhes completos
class PokemonDetail: Codable {
    let id: Int
    let name: String
    let height: Int
    let weight: Int
    let sprites: PokemonSprites
    let stats: [PokemonStat]
    let types: [PokemonType]
    let moves: [PokemonMoves]
}

class PokemonSprites: Codable {
    let front_default: String?
}

class PokemonStat: Codable {
    let base_stat: Int
    let stat: NamedAPIResource
}

class PokemonType: Codable {
    let slot: Int
    let type: NamedAPIResource
}

class PokemonHeldItem: Codable {
    let item: NamedAPIResource
}

class PokemonMoves: Codable {
    let move: NamedAPIResource
}


class NamedAPIResource: Codable {
    let name: String
    let url: String
}
