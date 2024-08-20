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
        
        // Remove extra separators
        LeaguesTbl.tableFooterView = UIView()
    }

}

extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // Replace with the actual number of favorite items
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
        print("Selected Favorite \(indexPath.row + 1)")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let inset: CGFloat = 10
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }
}
