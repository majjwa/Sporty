//
//  LeaguesViewController.swift
//  Sporty
//
//  Created by marwa maky on 20/08/2024.
//

import UIKit
import Kingfisher

protocol LeaguesProtocol {
    func updateTable()
}

class LeaguesViewController: UIViewController, LeaguesProtocol {

    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var deafultImg: UIImageView!
    var presenter: LeaguesPresenter?
    var sportType: String?
    var isFavoritesMode = false

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let coreDataManager = CoreDataManager(context: context)
        presenter = LeaguesPresenter(leaguesView: self, coreDataManager: coreDataManager)
        leaguesTableView.dataSource = self
        leaguesTableView.delegate = self
        leaguesTableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaguesTableViewCell")

        if isFavoritesMode {
            setupFavoritesMode()
        } else if let sportType = sportType {
            presenter?.fetchLeagues(for: sportType)
        }

        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .green
        refreshControl.addTarget(self, action: #selector(refreshDataIndicator(_:)), for: .valueChanged)
        leaguesTableView.refreshControl = refreshControl
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
    }

    func setupUI() {
        view.backgroundColor = .black
        leaguesTableView.tableFooterView = UIView()
        deafultImg.isHidden = true
    }

    private func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = .green
        navigationController?.navigationBar.barTintColor = .black
        self.navigationItem.title = isFavoritesMode ? "Favorites Leagues" : "Leagues"
    }

    @objc private func refreshDataIndicator(_ sender: UIRefreshControl) {
        sender.beginRefreshing()
        if let sportType = sportType, !isFavoritesMode {
            presenter?.fetchLeagues(for: sportType)
        } else if isFavoritesMode {
            presenter?.fetchFavoriteLeagues()
        }
    }

    func updateTable() {
        DispatchQueue.main.async {
            self.leaguesTableView.reloadData()
            self.leaguesTableView.refreshControl?.endRefreshing()
            if self.isFavoritesMode && (self.presenter?.coreDataManager?.fetchFavoriteLeagues().count ?? 0) == 0 {
                self.deafultImg.isHidden = false
            } else {
                self.deafultImg.isHidden = true
            }
        }
    }

    private func setupFavoritesMode() {
        presenter?.fetchFavoriteLeagues()
    }
}
