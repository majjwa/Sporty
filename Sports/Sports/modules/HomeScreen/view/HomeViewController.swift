import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
       
        cell.homeLbl.text = "MARWA"
        cell.homeImg.image = UIImage(named: "Ball")
        cell.layer.cornerRadius = 10
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 10
        cell.layer.shadowColor = UIColor.gray.cgColor
        return cell
    }
}
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = 8
        
        let totalSpacing = (2 * spacingBetweenCells) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
        let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}


/*
 //
 //  HomeCollectionViewUISetup.swift
 //  GamePlay
 //
 //  Created by eng.omar on 14/08/2024.
 //

 import Foundation
 import UIKit

 extension HomeSportsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         return 4
     }
     
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
         let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
         let homeData = arrHomeData[indexPath.row]
         cell.imgSportPhoto.image = UIImage(named: homeData.image)
         cell.lblSportName.text = homeData.title
         cell.HomebackgroundView.backgroundColor = cell.HomebackgroundView.backgroundColor?.withAlphaComponent(0.2)
         cell.layer.cornerRadius = 10
         cell.layer.shadowOpacity = 0.5
         cell.layer.shadowRadius = 10
         cell.layer.shadowColor = UIColor.gray.cgColor


         
         return cell
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
         let numberOfItemsPerRow: CGFloat = 2
         let spacingBetweenCells: CGFloat = 10
         
         let totalSpacing = (2 * spacingBetweenCells) + ((numberOfItemsPerRow - 1) * spacingBetweenCells)
         let width = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
         
         return CGSize(width: width, height: width)
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
         return 10
     }
     
     func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
         return 10
     }
     func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
         switch indexPath.row {
         case 0:
             
             naviToFootball(flag: 0)
         case 1:
             naviToFootball(flag: 1)

             print("basket")
         case 2:
             naviToFootball(flag: 2)

             print("cricket")

         case 3:
             naviToFootball(flag: 3)

             print("tennis")


         default:
             break
             
         }

     }
     
 }

 */
