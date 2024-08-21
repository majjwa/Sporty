//
//  Extensions.swift
//  Sporty
//
//  Created by marwa maky on 21/08/2024.
//

import UIKit
import Kingfisher

extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {

    func numberOfSections(in tableView: UITableView) -> Int {
        return presenter?.leagues.count ?? 0
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell", for: indexPath) as! LeaguesTableViewCell
        // Set selected background color to black
        cell.selectedBackgroundView = {
              let view = UIView()
            view.backgroundColor = .black
              return view
          }()
        cell.backgroundColor = .black
        if let league = presenter?.leagues[indexPath.section] {
            cell.LeaguesName.text = league.leagueName
            
            let placeholderImage = UIImage(named: "Ball")
            if let logoURL = league.leagueLogo, let url = URL(string: logoURL) {
                cell.LeaguesImg.kf.setImage(with: url, placeholder: placeholderImage, options: [
                    .transition(.fade(0.2)),
                    .cacheOriginalImage
                ])
            } else {
                cell.LeaguesImg.image = placeholderImage
            }
        
            cell.LeaguesImg.layer.cornerRadius = 10
            cell.LeaguesImg.clipsToBounds = true
            
        }
        else {
            cell.LeaguesName.text = "Loading"
            cell.LeaguesImg.image = UIImage(systemName: "arrowshape.down.circle")
                }

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
