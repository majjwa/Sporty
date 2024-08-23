import UIKit
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
    
    @IBAction func favBtnTapped(_ sender: Any) {
        // Handle favorite button action
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
