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

        presenter = LeaguesPresenter(leaguesView: self)
        LeaguesTbl.dataSource = self
        LeaguesTbl.delegate = self
        LeaguesTbl.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaguesTableViewCell")
        
        if let sportType = sportType {
            presenter?.fetchLeagues(for: sportType) 
        }
    }
    
    func updateTable() {
        LeaguesTbl.reloadData()
    }
}

