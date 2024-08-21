//
//  LeaguesViewController.swift
//  Sporty
//
//  Created by marwa maky on 20/08/2024.
//

import UIKit

class LeaguesViewController: UIViewController {

    @IBOutlet weak var LeaguesTbl: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
    
        LeaguesTbl.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaguesTableViewCell")
        LeaguesTbl.dataSource = self
        LeaguesTbl.delegate = self
        LeaguesTbl.tableFooterView = UIView()
    }

}
// --------------------------------Extension---------------------------------------------------

extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 10
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell", for: indexPath) as! LeaguesTableViewCell
        cell.backgroundColor = .black
        cell.LeaguesName.text = "League Name"
        cell.LeaguesImg.image = UIImage(named: "Football")
        cell.secImg.image = UIImage(named: "youtube")

        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}
