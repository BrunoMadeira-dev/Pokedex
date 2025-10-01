//
//  Endpoints.swift
//  Pokedex
//
//  Created by Bruno Madeira on 30/09/2025.
//

import Foundation

enum Endpoints {
    static func pokemonList(limit: Int, offset: Int) -> Endpoint {
        Endpoint(url: URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")!)
    }
}

