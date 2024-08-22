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
        return 6
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "fisrtCollectionViewCell", for: indexPath) as! fisrtCollectionViewCell
           
            return cell

        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "secondCollectionViewCell", for: indexPath) as! secondCollectionViewCell
            return cell

        case 2:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "thirdCollectionViewCell", for: indexPath) as! thirdCollectionViewCell
            return cell

        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.alpha = 0
        UIView.animate(withDuration: 0.3, animations: {
            cell.alpha = 1
        })
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       // navigateToTeamDetails(index: indexPath.row)
    }
    
   
}
