//
//  CoreDataManager.swift
//  Sporty
//
//  Created by marwa maky on 24/08/2024.
//

import CoreData

class CoreDataManager {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func isLeagueFavorite(leagueKey: Int) -> FavModel? {
        let fetchRequest: NSFetchRequest<FavModel> = FavModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey = %d", leagueKey)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.first
        } catch {
            print("Failed fetching: \(error.localizedDescription)")
            return nil
        }
    }

    func saveFavorite(league: LeaguesResult) {
        let favoriteObject = FavModel(context: context)
        favoriteObject.leagueKey = Int32(league.leagueKey)
        favoriteObject.leagueName = league.leagueName
        favoriteObject.leagueImg = league.leagueLogo
        favoriteObject.isFav = true
        
        do {
            try context.save()
            print("Saved successfully")
        } catch {
            print("Failed saving: \(error.localizedDescription)")
        }
    }

    func deleteFavorite(leagueKey: Int) {
        let fetchRequest: NSFetchRequest<FavModel> = FavModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey = %d", leagueKey)
        
        do {
            let results = try context.fetch(fetchRequest)
            for object in results {
                context.delete(object)
            }
            try context.save()
            print("Deleted successfully")
        } catch {
            print("Failed deleting: \(error.localizedDescription)")
        }
    }
}
