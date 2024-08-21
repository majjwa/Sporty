//
//  FavModel.swift
//  Sporty
//
//  Created by marwa maky on 21/08/2024.
//

import Foundation
struct FavouriteModel: Codable {
    let leagueKey: Int
    let leagueName: String
    let leagueImg: String?
}
/*
 func saveNewsToCoreData(_ newsList: [News]) {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     let context = appDelegate.persistentContainer.viewContext
     let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Model")
     let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
     do {
         try context.execute(deleteRequest)
     } catch {
         print("Failed to delete existing data: \(error.localizedDescription)")
     }
     for newsItem in newsList {
         let newsObject = NSEntityDescription.insertNewObject(forEntityName: "Model", into: context)
         newsObject.setValue(newsItem.title, forKey: "title")
         newsObject.setValue(newsItem.author, forKey: "author")
         newsObject.setValue(newsItem.desription, forKey: "desription")
         newsObject.setValue(newsItem.url, forKey: "url")
         newsObject.setValue(newsItem.publishedAt, forKey: "publishedAt")
         newsObject.setValue(newsItem.imageUrl, forKey: "imageUrl")
         newsObject.setValue(false, forKey: "isFavorite")
     }

     do {
         try context.save()
         print("Data saved to Core Data")
     } catch {
         print("Failed to save data: \(error.localizedDescription)")
     }
 }

func fetchNewsFromCoreData() -> [News]? {
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
     let context = appDelegate.persistentContainer.viewContext
     let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Model")

     do {
         let results = try context.fetch(fetchRequest) as! [NSManagedObject]
         let newsList = results.map { result in
             return News(
                 title: result.value(forKey: "title") as! String,
                 author: result.value(forKey: "author") as! String,
                 desription: result.value(forKey: "desription") as! String,
                 imageUrl: result.value(forKey: "imageUrl") as! String,
                 url: result.value(forKey: "url") as! String,
                 publishedAt: result.value(forKey: "publishedAt") as! String
             )
         }
         return newsList
     } catch {
         print("Failed to fetch data: \(error.localizedDescription)")
         return nil
     }
 }
 func deleteNewsItem(_ newsItem: News) {
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Model")
    fetchRequest.predicate = NSPredicate(format: "title = %@", newsItem.title)
    do {
        let results = try context.fetch(fetchRequest)
        for object in results {
            context.delete(object as! NSManagedObject)
        }
        try context.save()
        print("Deleted successfully")
    } catch {
        print("Failed deleting: \(error.localizedDescription)")
    }
}
 */
