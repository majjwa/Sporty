//
//  TeamDetailsViewControllerExtensions.swift
//  Sporty
//
//  Created by marwa maky on 23/08/2024.
//

import Foundation
import UIKit
import Kingfisher
extension TeamDetailsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return 6
        //return presenter?.team?.players.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersTableViewCell", for: indexPath) as! playersTableViewCell
        
        // Get the player data
//        if let player = presenter?.team?.players[indexPath.row] {
//            cell.playerName.text = player.playerName
//            cell.playerImg.image = UIImage(named: "ball")
//            // Customize the image view
//            cell.playerImg.layer.cornerRadius = 10
//            cell.playerImg.clipsToBounds = true
//        } else {
//            cell.playerName.text = "Loading..."
//            cell.playerImg.image = UIImage(named: "placeholder")
//        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        // Handle row selection if needed
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        // Set the height of the rows
        return 100
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // Space between sections
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        return footerView
    }
}
