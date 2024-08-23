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
        return presenter?.team?.players.count ?? 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "playersTableViewCell", for: indexPath) as! playersTableViewCell
        
        // Set selected background color to black
        cell.selectedBackgroundView = {
            let view = UIView()
            view.backgroundColor = .black
            return view
        }()
        cell.backgroundColor = .black

        // Get the player data
        if let player = presenter?.team?.players[indexPath.row] {
            cell.playerName.text = player.playerName
            cell.playerImg.image = UIImage(named: "player")
            cell.playerImg.layer.cornerRadius = 10
            cell.playerImg.clipsToBounds = true
            
            // Apply shadow and corner radius to the cell
            cell.layer.cornerRadius = 10
            cell.layer.shadowColor = UIColor.black.cgColor
            cell.layer.shadowOpacity = 0.1
            cell.layer.shadowOffset = CGSize(width: 0, height: 1)
            cell.layer.shadowRadius = 5
            cell.layer.masksToBounds = false
        } else {
            cell.playerName.text = "Loading..."
            cell.playerImg.image = UIImage(named: "placeholder")
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
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

    // Add space between cells
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.contentView.layer.masksToBounds = true
        cell.contentView.layer.cornerRadius = 30
        cell.contentView.layer.borderWidth = 8
        cell.contentView.layer.borderColor = UIColor.black.cgColor
    }
}
