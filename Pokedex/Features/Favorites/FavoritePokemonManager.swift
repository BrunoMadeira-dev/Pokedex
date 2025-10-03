//
//  FavoritePokemonManager.swift
//  Pokedex
//
//  Created by Bruno Madeira on 03/10/2025.
//

import CoreData
import UIKit

final class FavoritePokemonManager {
    static let shared = FavoritePokemonManager()
    
    private let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    private init() {}
    
    // MARK: - Add favorite
    func addFavorite(pokemon: PokemonDetail) {
        guard !isFavorite(pokemonId: pokemon.id) else { return }
        
        let favorite = FavoritePokemon(context: context)
        favorite.id = Int64(pokemon.id)
        favorite.name = pokemon.name
        favorite.imageURL = pokemon.sprites.front_default
        
        saveContext()
    }
    
    // MARK: - Remove favorite
    func removeFavorite(pokemonId: Int) {
        if let favorite = fetchFavorite(pokemonId: pokemonId) {
            context.delete(favorite)
            saveContext()
        }
    }
    
    // MARK: - Check favorite
    func isFavorite(pokemonId: Int) -> Bool {
        return fetchFavorite(pokemonId: pokemonId) != nil
    }
    
    // MARK: - Fetch all favorites
    func getAllFavorites() -> [FavoritePokemon] {
        let request: NSFetchRequest<FavoritePokemon> = FavoritePokemon.fetchRequest()
        do {
            return try context.fetch(request)
        } catch {
            print("Error fetching favorites: \(error)")
            return []
        }
    }
    
    // MARK: - Helpers
    private func fetchFavorite(pokemonId: Int) -> FavoritePokemon? {
        let request: NSFetchRequest<FavoritePokemon> = FavoritePokemon.fetchRequest()
        request.predicate = NSPredicate(format: "id == %d", pokemonId)
        return try? context.fetch(request).first
    }
    
    private func saveContext() {
        do {
            try context.save()
        } catch {
            print("Error saving context: \(error)")
        }
    }
}

