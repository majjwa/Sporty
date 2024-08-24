import UIKit

protocol LeaguesDetailsProtocol: AnyObject {
    func updateCollectionView()
    func updateFavoriteStatus(isFavorite: Bool)
}

class LeaguesDetailsViewController: UIViewController, LeaguesDetailsProtocol {

    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIButton!
    
    var presenter: LeaguesDetailsPresenter?
    var leagueId: Int?
    var selectedLeague: LeaguesResult?
    var isFavorite: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()

        DetailsCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        DetailsCollectionView.register(UINib(nibName: "fisrtCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "fisrtCollectionViewCell")
        DetailsCollectionView.register(UINib(nibName: "secondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "secondCollectionViewCell")
        DetailsCollectionView.register(UINib(nibName: "thirdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "thirdCollectionViewCell")

        DetailsCollectionView.dataSource = self
        DetailsCollectionView.delegate = self
        setupCompositionalLayout()

        if let leagueId = leagueId {
            presenter?.fetchUpComing(leagueId: leagueId)
            presenter?.fetchLatest(leagueId: leagueId)
            presenter?.fetchFavoriteState()
        }
    }

    @IBAction func dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }

    func updateCollectionView() {
        DetailsCollectionView.reloadData()
    }

    func updateFavoriteStatus(isFavorite: Bool) {
        self.isFavorite = isFavorite
        let imageName = isFavorite ? "heart.fill" : "heart"
        favBtn.setImage(UIImage(systemName: imageName), for: .normal)
    }

    func setupCompositionalLayout() {
        DetailsCollectionView.collectionViewLayout = createCompositionalLayout()
    }

    @IBAction func favBtnTapped(_ sender: UIButton) {
        guard let league = selectedLeague else {
            print("No selected league")
            return
        }
        print("Selected League: \(league.leagueKey), \(league.leagueName)")
        isFavorite.toggle()
        let imageName = isFavorite ? "heart.fill" : "heart"
        favBtn.setImage(UIImage(systemName: imageName), for: .normal)

        if isFavorite {
            presenter?.saveFavorite(league)
        } else {
            let alert = UIAlertController(title: "Are you sure you want to delete?", message: nil, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Yes", style: .destructive, handler: { [weak self] _ in
                self?.presenter?.deleteFavorite(league)
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { [weak self] _ in
                self?.isFavorite.toggle()
                let imageName = self!.isFavorite ? "heart.fill" : "heart"
                self!.favBtn.setImage(UIImage(systemName: imageName), for: .normal)
            }))
            self.present(alert, animated: true, completion: nil)
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
