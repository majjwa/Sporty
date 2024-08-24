import UIKit
import Kingfisher

protocol LeaguesDetailsProtocol: AnyObject {
    func updateCollectionView()
    func updateFavoriteStatus(isFavorite: Bool)
}

class LeaguesDetailsViewController: UIViewController, LeaguesDetailsProtocol {
    
    @IBOutlet weak var detailsCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIButton!
    
    var presenter: LeaguesDetailsPresenter?
    var leagueId: Int?
    var selectedLeague: LeaguesResult?
    var isFavorite: Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCompositionalLayout()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter?.fetchFavoriteState()
    }
    
    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func favBtnTapped(_ sender: UIButton) {
        toggleFavoriteStatus()
    }
    
    func updateCollectionView() {
        DispatchQueue.main.async {
            self.detailsCollectionView.reloadData()
        }
    }
    
    func updateFavoriteStatus(isFavorite: Bool) {
        DispatchQueue.main.async {
            print("Updating favorite status: \(isFavorite)")
            self.isFavorite = isFavorite
            let imageName = isFavorite ? "heart.fill" : "heart"
            self.favBtn.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }
    
    private func setupCollectionView() {
        detailsCollectionView.register(HeaderView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "HeaderView")
        detailsCollectionView.register(UINib(nibName: "fisrtCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "fisrtCollectionViewCell")
        detailsCollectionView.register(UINib(nibName: "secondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "secondCollectionViewCell")
        detailsCollectionView.register(UINib(nibName: "thirdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "thirdCollectionViewCell")
        detailsCollectionView.dataSource = self
        detailsCollectionView.delegate = self
    }
    
    private func setupCompositionalLayout() {
        detailsCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    
    private func loadData() {
        guard let leagueId = leagueId else {
            print("No league ID")
            return
        }
        
        presenter?.fetchUpComing(leagueId: leagueId)
        presenter?.fetchLatest(leagueId: leagueId)
        presenter?.fetchFavoriteState()
    }
    
    private func toggleFavoriteStatus() {
        guard let league = selectedLeague else {
            print("No selected league")
            return
        }
        
        isFavorite.toggle()
        let imageName = isFavorite ? "heart.fill" : "heart"
        favBtn.setImage(UIImage(systemName: imageName), for: .normal)
        
        if isFavorite {
            presenter?.saveFavorite(league)
        } else {
            showDeleteConfirmation(for: league)
        }
    }
    
    private func showDeleteConfirmation(for league: LeaguesResult) {
        let alert = UIAlertController(title: "Are you sure you want to delete?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.presenter?.deleteFavorite(league)
        })
        alert.addAction(UIAlertAction(title: "No", style: .cancel))
        present(alert, animated: true)
    }
    
    private func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
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
