import CoreData

class CoreDataManager {
    private let context: NSManagedObjectContext

    init(context: NSManagedObjectContext) {
        self.context = context
    }

    func isLeagueFavorite(leagueKey: Int) -> Bool {
        let fetchRequest: NSFetchRequest<FavModel> = FavModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey = %d", leagueKey)
        
        do {
            let results = try context.fetch(fetchRequest)
            print("Fetched \(results.count) favorites for leagueKey: \(leagueKey)")
            return !results.isEmpty
        } catch {
            print("Failed fetching: \(error.localizedDescription)")
            return false
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
    
    func fetchFavoriteLeagues() -> [LeaguesResult] {
        let fetchRequest: NSFetchRequest<FavModel> = FavModel.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.map {
                LeaguesResult(leagueKey: Int($0.leagueKey),
                              leagueName: $0.leagueName ?? "",
                              leagueLogo: $0.leagueImg ?? "")
            }
        } catch {
            print("Error fetching favorite leagues: \(error)")
            return []
        }
    }
    func deleteFavorite(leagueKey: Int) {
        let fetchRequest: NSFetchRequest<FavModel> = FavModel.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "leagueKey = %d", leagueKey)
        
        do {
            let results = try context.fetch(fetchRequest)
            if let favoriteToDelete = results.first {
                context.delete(favoriteToDelete)
                try context.save()
                print("Deleted successfully")
            } else {
                print("Favorite league not found")
            }
        } catch {
            print("Failed deleting: \(error.localizedDescription)")
        }
    }

}
