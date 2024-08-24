//
//  LeaguesViewController.swift
//  Sporty
//
//  Created by marwa maky on 20/08/2024.
//

import UIKit
import Kingfisher

protocol LeaguesProtocol{
    func updateTable()
}
class LeaguesViewController: UIViewController, LeaguesProtocol {

    @IBOutlet weak var leaguesTableView: UITableView!
    @IBOutlet weak var tabBarView: UIView?
    @IBOutlet weak var favImg: UIImageView?
    @IBOutlet weak var homeImg: UIImageView?

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

        if isFavoritesMode {
            updateTabBarSelection()
        }
    }

    private func setupUI() {
        view.backgroundColor = .black
        leaguesTableView.tableFooterView = UIView()

        if isFavoritesMode {
            tabBarView?.layer.cornerRadius = tabBarView?.frame.height ?? 0 / 2
            tabBarView?.clipsToBounds = true
        }
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
        leaguesTableView.reloadData()
        leaguesTableView.refreshControl?.endRefreshing()
    }

    private func setupFavoritesMode() {
        // Customize tab bar for Favorites mode
        favImg?.tintColor = .green
        homeImg?.tintColor = .white
        
        // Load favorite leagues
        presenter?.fetchFavoriteLeagues()
    }

    private func updateTabBarSelection() {
        favImg?.tintColor = .green
        homeImg?.tintColor = .white
    }

    @IBAction func homeButtonTapped(_ sender: UIButton) {
        homeImg?.tintColor = .green
        favImg?.tintColor = .white
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
