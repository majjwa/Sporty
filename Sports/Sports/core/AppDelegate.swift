//
//  AppDelegate.swift
//  Sports
//
//  Created by marwa maky on 19/08/2024.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

     func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            if let leaguesDetailsVC = storyboard.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as? LeaguesDetailsViewController {
                let presenter = LeaguesDetailsPresenter(
                    view: leaguesDetailsVC,
                    apiManager: APIManager.shared,
                    coreDataManager: coreDataManager
                )
                leaguesDetailsVC.presenter = presenter
            }
            
            return true
        }
   
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


    lazy var persistentContainer: NSPersistentContainer = {
      
        let container = NSPersistentContainer(name: "Sports")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
            
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    lazy var coreDataManager: CoreDataManager = {
            return CoreDataManager(context: persistentContainer.viewContext)
        }()

    
        
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
              
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

