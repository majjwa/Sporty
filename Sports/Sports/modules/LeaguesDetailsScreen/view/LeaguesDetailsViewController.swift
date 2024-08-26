//
//  LeaguesDetailsViewController.swift
//  Sporty
//
//  Created by marwa maky on 22/08/2024.
//

import UIKit
import Kingfisher
import Alamofire

protocol LeaguesDetailsProtocol: AnyObject {
    func updateCollectionView()
    func updateFavoriteStatus(isFavorite: Bool)
    func showOfflineAlert()
}

class LeaguesDetailsViewController: UIViewController, LeaguesDetailsProtocol {

    @IBOutlet weak var detailsCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIButton!
    @IBOutlet weak var defaultImg: UIImageView!

    var presenter: LeaguesDetailsPresenter?
    var leagueId: Int?
    var selectedLeague: LeaguesResult?
    private var isFavorite: Bool = false
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupCompositionalLayout()
        checkNetworkStatusAndLoadData()
        self.defaultImg.image = UIImage(named: "no data")

    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        updateFavoriteStatus(isFavorite: presenter?.coreDataManager.isLeagueFavorite(leagueKey: leagueId ?? 0) ?? false)
    }

    @IBAction func dismiss(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    @IBAction func favBtnTapped(_ sender: UIButton) {
        toggleFavoriteStatus()
    }

    func updateCollectionView() {
        DispatchQueue.main.async {
            let hasData = self.presenter?.upComingEvents.isEmpty == false ||
                          self.presenter?.latestEvents.isEmpty == false ||
                          self.presenter?.teams.isEmpty == false

            self.defaultImg.isHidden = hasData
            self.detailsCollectionView.isHidden = !hasData

            if hasData {
                self.detailsCollectionView.reloadData()
            }
        }
    }

    func updateFavoriteStatus(isFavorite: Bool) {
        DispatchQueue.main.async {
            self.isFavorite = isFavorite
            let imageName = isFavorite ? "heart.fill" : "heart"
            self.favBtn.setImage(UIImage(systemName: imageName), for: .normal)
        }
    }

    func showOfflineAlert() {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "No Internet Connection", message: "Please check your network settings and try again.", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                self?.dismiss(animated: true, completion: nil)
            })
            self.present(alert, animated: true, completion: nil)
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

    private func checkNetworkStatusAndLoadData() {
        guard let leagueId = leagueId else {
            print("No league ID")
            return
        }

        if Connectivity.shared.isReachable {
            presenter?.fetchUpComing(leagueId: leagueId)
            presenter?.fetchLatest(leagueId: leagueId)
            presenter?.checkFavoriteStatus()
        } else {
            showOfflineAlert()
        }
    }

    private func toggleFavoriteStatus() {
        guard let leagueId = leagueId, let league = selectedLeague else {
            print("No selected league")
            return
        }

        isFavorite.toggle()
        let imageName = isFavorite ? "heart.fill" : "heart"
        favBtn.setImage(UIImage(systemName: imageName), for: .normal)

        if isFavorite {
            presenter?.saveFavorite(league)
        } else {
            showDeleteConfirmation(for: leagueId)
        }
    }

    private func showDeleteConfirmation(for leagueId: Int) {
        let alert = UIAlertController(title: "Are you sure you want to delete?", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .destructive) { [weak self] _ in
            self?.presenter?.deleteFavorite(leagueId: leagueId)
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
