//
//  FavoritePokemon+CoreDataProperties.swift
//  Pokedex
//
//  Created by Bruno Madeira on 03/10/2025.
//
//

import Foundation
import CoreData


extension FavoritePokemon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavoritePokemon> {
        return NSFetchRequest<FavoritePokemon>(entityName: "FavoritePokemon")
    }

    @NSManaged public var id: Int64
    @NSManaged public var name: String?
    @NSManaged public var imageURL: String?

}

extension FavoritePokemon : Identifiable {

}
