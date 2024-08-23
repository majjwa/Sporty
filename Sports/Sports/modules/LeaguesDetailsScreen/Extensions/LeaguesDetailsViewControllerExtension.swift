//
//  LeaguesDetailsViewControllerExtension.swift
//  Sporty
//
//  Created by marwa maky on 22/08/2024.
//
import UIKit
import Foundation

extension LeaguesDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch section {
        case 0:
          return presenter?.upComingEvents.count ?? 0
        case 1:
          return presenter?.latestEvents.count ?? 0
        case 2:
            return presenter?.teams.count ?? 0
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fisrtCollectionViewCell", for: indexPath) as! fisrtCollectionViewCell
            let event = presenter?.upComingEvents[indexPath.row]
            
            cell.leagueName.text = presenter?.selectedLeague?.leagueName
            cell.team1Name.text = event?.eventHomeTeam
            cell.team2Name.text = event?.eventAwayTeam
            cell.date.text = event?.eventDate
            cell.time.text = event?.eventTime
            cell.team1state.text = event?.eventFinalResult
            cell.team2state.text = event?.eventFinalResult

            if let team1LogoUrl = event?.homeTeamLogo {
                cell.team1Img.kf.setImage(with: URL(string: team1LogoUrl))
            }
            if let team2LogoUrl = event?.awayTeamLogo {
                cell.team2Img.kf.setImage(with: URL(string: team2LogoUrl))
            }

            cell.layer.cornerRadius = 15
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCollectionViewCell", for: indexPath) as! secondCollectionViewCell
            let event = presenter?.latestEvents[indexPath.row]
            
          //  cell.leagueName.text = presenter?.selectedLeague?.leagueName
            cell.team1Name.text = event?.eventHomeTeam
            cell.team2Name.text = event?.eventAwayTeam
            if let team1LogoUrl = event?.homeTeamLogo {
                cell.img1.kf.setImage(with: URL(string: team1LogoUrl))
            }
            if let team2LogoUrl = event?.awayTeamLogo {
                cell.img2.kf.setImage(with: URL(string: team2LogoUrl))
            }
            cell.score.text = event?.eventFinalResult
            
            cell.layer.cornerRadius = 15
            return cell

        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCollectionViewCell", for: indexPath) as! thirdCollectionViewCell
            cell.layer.cornerRadius = 15
            let event = presenter?.teams[indexPath.row]
            cell.teamName.text = event?.teamName
            if let LogoUrl = event?.teamLogo {
                cell.logo.kf.setImage(with: URL(string: LogoUrl))
            }

            return cell

        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        switch indexPath.section {
        case 0:
            return
        case 1:
            return
        case 2:
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let selectedTeamKey = presenter?.teams[indexPath.row].teamKey
            if let vc = storyboard.instantiateViewController(withIdentifier: "TeamDetailsViewController") as? TeamDetailsViewController {
                let newPresenter = TeamsDetailsPresenter(view: vc, teamKey: selectedTeamKey, apiManager: presenter?.apiManager)
                vc.presenter = newPresenter
                vc.modalPresentationStyle = .fullScreen
                self.present(vc, animated: true, completion: nil)
            }

        default:
            return
        }}
    func createUpcomingEventsSection() -> NSCollectionLayoutSection {
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.94), heightDimension: .absolute(200))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = .groupPaging
       section.interGroupSpacing = 16
       section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
             items.forEach { item in
             let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
             let minScale: CGFloat = 0.8
             let maxScale: CGFloat = 1.0
             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
             item.transform = CGAffineTransform(scaleX: scale, y: scale)
             }
        }
       return section
   }

    func createLatestEventsSection() -> NSCollectionLayoutSection {
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
       let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
       let section = NSCollectionLayoutSection(group: group)
       section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
       section.interGroupSpacing = 15
        
       return section
   }

    func createTeamsSection() -> NSCollectionLayoutSection {
        
        let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        
        section.orthogonalScrollingBehavior = .continuous
        
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
             items.forEach { item in
             let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
             let minScale: CGFloat = 0.8
             let maxScale: CGFloat = 1.0
             let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
             item.transform = CGAffineTransform(scaleX: scale, y: scale)
             }
        }
        
        return section
    }

   
}
