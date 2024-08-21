//
//  LeaguesViewController.swift
//  Sporty
//
//  Created by marwa maky on 20/08/2024.
//

import UIKit
protocol LeaguesProtocol{
    func updateTable()
    
}
class LeaguesViewController: UIViewController, LeaguesProtocol {

    @IBOutlet weak var LeaguesTbl: UITableView!

    var presenter: LeaguesPresenter?
    var sportType: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        view.backgroundColor = .black
          // LeaguesTbl.backgroundColor = .black
            //navigationController?.navigationBar.barTintColor = .blue
        navigationController?.navigationBar.tintColor = .green

        presenter = LeaguesPresenter(leaguesView: self)
        LeaguesTbl.dataSource = self
        LeaguesTbl.delegate = self
        LeaguesTbl.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaguesTableViewCell")
        
        if let sportType = sportType {
            presenter?.fetchLeagues(for: sportType) 
        }
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .green
        refreshControl.addTarget(self, action: #selector(refreshDataIndicator(_:)), for: .valueChanged)
        LeaguesTbl.refreshControl = refreshControl
    }
    override func viewWillAppear(_ animated: Bool) {
           view.backgroundColor = .black
          //  LeaguesTbl.backgroundColor = .black
            navigationController?.navigationBar.barTintColor = .black   
    }
    @objc private func refreshDataIndicator(_ sender: UIRefreshControl) {
       sender.beginRefreshing()
        if let sportType = sportType {
            presenter?.fetchLeagues(for: sportType)
        }
        
    }
    func updateTable() {
        LeaguesTbl.reloadData()
        LeaguesTbl.refreshControl?.endRefreshing()

    }
}

