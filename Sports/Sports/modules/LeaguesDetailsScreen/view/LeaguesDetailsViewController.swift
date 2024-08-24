import UIKit
import CoreData
import Foundation

protocol LeaguesDetailsProtocol {
    func updateCollectionView()
}

class LeaguesDetailsViewController: UIViewController, LeaguesDetailsProtocol {

    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIButton!
    var presenter: LeaguesDetailsPresenter?
    var leagueId: Int?
    var selectedLeague: LeaguesResult?

    private var isFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCompositionalLayout()
        DetailsCollectionView.register(UINib(nibName: "fisrtCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "fisrtCollectionViewCell")
        DetailsCollectionView.register(UINib(nibName: "secondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "secondCollectionViewCell")
        DetailsCollectionView.register(UINib(nibName: "thirdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "thirdCollectionViewCell")
        DetailsCollectionView.dataSource = self
        DetailsCollectionView.delegate = self

        if let leagueId = leagueId {
            presenter?.fetchUpComing(leagueId: leagueId)
            presenter?.fetchLatest(leagueId: leagueId)
            updateFavoriteStatus()
        }
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func updateCollectionView() {
        DetailsCollectionView.reloadData()
    }

    func setupCompositionalLayout() {
        DetailsCollectionView.collectionViewLayout = createCompositionalLayout()
    }

    @IBAction func favBtnTapped(_ sender: UIButton) {
        print("btntapped")
        guard let league = selectedLeague else { return }

        isFavorite.toggle()
        let imageName = isFavorite ? "heart.fill" : "heart"
        favBtn.setImage(UIImage(systemName: imageName), for: .normal)

        if isFavorite {
            saveFavorite(league)
        } else {
            deleteFavorite(league)
        }
    }

    private func updateFavoriteStatus() {
        guard let league = selectedLeague else { return }

        if isLeagueFavorite(league) {
            isFavorite = true
            favBtn.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        } else {
            isFavorite = false
            favBtn.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }

    private func isLeagueFavorite(_ league: LeaguesResult) -> Bool {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavModel")
        fetchRequest.predicate = NSPredicate(format: "leagueKey = %d", league.leagueKey)
        
        do {
            let results = try context.fetch(fetchRequest)
            return results.count > 0
        } catch {
            print("Failed fetching: \(error.localizedDescription)")
            return false
        }
    }

    private func saveFavorite(_ league: LeaguesResult) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavModel", in: context)
        let favoriteObject = NSManagedObject(entity: entity!, insertInto: context)
        favoriteObject.setValue(league.leagueKey, forKey: "leagueKey")
        favoriteObject.setValue(league.leagueName, forKey: "leagueName")
        favoriteObject.setValue(league.leagueLogo, forKey: "leagueImg")
        favoriteObject.setValue(true, forKey: "isFav")
        
        do {
            try context.save()
            print("Saved successfully")
        } catch {
            print("Failed saving: \(error.localizedDescription)")
        }
    }

    private func deleteFavorite(_ league: LeaguesResult) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "FavModel")
        fetchRequest.predicate = NSPredicate(format: "leagueKey = %d", league.leagueKey)
        
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
    
    func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
        return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
            switch sectionIndex {
            case 0:
                return self.createUpcomingEventsSection()
            case 1:
                return self.createLatestEventsSection()
            case 2:
                return self.createTeamsSection()
            default:
                return nil
            }
        }
    }
}
