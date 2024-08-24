import UIKit
import Kingfisher

extension LeaguesViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFavoritesMode {
            return presenter?.coreDataManager?.fetchFavoriteLeagues().count ?? 0
        } else {
            return presenter?.leagues.count ?? 0
        }
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
        
        let league: LeaguesResult?
        
        if isFavoritesMode {
            // Fetch favorite leagues
            let favoriteLeagues = presenter?.coreDataManager?.fetchFavoriteLeagues() ?? []
            league = favoriteLeagues[indexPath.row]
        } else {
            // Display regular leagues
            league = presenter?.leagues[indexPath.row]
        }
        
        if let league = league {
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
        } else {
            cell.LeaguesName.text = "Loading"
            cell.LeaguesImg.image = UIImage(systemName: "arrowshape.down.circle")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedLeague: LeaguesResult?
        
        if isFavoritesMode {
            let favoriteLeagues = presenter?.coreDataManager?.fetchFavoriteLeagues() ?? []
            selectedLeague = favoriteLeagues[indexPath.row]
        } else {
            selectedLeague = presenter?.leagues[indexPath.row]
        }
        
        let leagueId = selectedLeague?.leagueKey
        let defaultCoreDataManager = CoreDataManager(context: (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext)
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        if let leaguesDetailsVC = storyboard.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as? LeaguesDetailsViewController {
            leaguesDetailsVC.leagueId = leagueId
            leaguesDetailsVC.selectedLeague = selectedLeague
            let presenter = LeaguesDetailsPresenter(view: leaguesDetailsVC, apiManager: APIManager.shared, coreDataManager: leaguesDetailsVC.presenter?.coreDataManager ?? defaultCoreDataManager)
            leaguesDetailsVC.presenter = presenter
            
            leaguesDetailsVC.modalPresentationStyle = .fullScreen
            self.present(leaguesDetailsVC, animated: true, completion: nil)
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 100
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

        
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
           if isFavoritesMode {
               let deleteAction = UIContextualAction(style: .destructive, title: "Delete") { [weak self] (action, view, completionHandler) in
                   guard let self = self else { return }
                   
                   // Fetch favorite leagues
                   var favoriteLeagues = self.presenter?.coreDataManager?.fetchFavoriteLeagues() ?? []
                   
                   guard indexPath.row < favoriteLeagues.count else {
                       completionHandler(false)
                       return
                   }
                   
                   let leagueToDelete = favoriteLeagues[indexPath.section]
                   
                   let leagueKey = leagueToDelete.leagueKey
                   self.presenter?.coreDataManager?.deleteFavorite(leagueKey: leagueKey)
                
                   favoriteLeagues.remove(at: indexPath.section)

                       tableView.deleteRows(at: [indexPath], with: .automatic)
                
               }
               deleteAction.backgroundColor = .red
               let configuration = UISwipeActionsConfiguration(actions: [deleteAction])
               configuration.performsFirstActionWithFullSwipe = true
               return configuration
           }
           return nil
       }
       



}
