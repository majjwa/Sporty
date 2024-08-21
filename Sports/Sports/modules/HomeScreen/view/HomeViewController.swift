//
//  HomeViewController.swift
//  Sporty
//
//  Created by marwa maky on 18/08/2024.
//

import UIKit

class HomeViewController: UIViewController {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var favTabBar: UIView!
    @IBOutlet weak var homeTabBar: UIView!
    @IBOutlet weak var tabBarView: UIView!
    


let sportsData = [
        ("Football", "Football"),
        ("Basketball", "basketball"),
        ("Cricket", "cricket"),
        ("Tennis", "Football"),
        ("Tennis", "Football"),
        ("Tennis", "Football"),
        ("Tennis", "Football"),
        ("Tennis", "Football"),
        ("Tennis", "Football"),
        ("Tennis", "Football"),
        ("Tennis", "Football"),
        ("Tennis", "Football"),
        ("Tennis", "Football"),
        ("Tennis", "Football"),
    ]
    
override func viewDidLoad() {
        super.viewDidLoad()
    
//    APIManager.shared.fetchTeamDetails(teamId: 4) { result in
//        switch result {
//        case .success(let events):
//            print("Teams: \(events)")
//        case .failure(let error):
//            print("Error fetching upcoming Teams: \(error)")
//        }
//    }
    
    APIManager.shared.fetchUpcomingEvents(leagueId: 204, fromDate: "2023-01-18", toDate: "2024-01-18") { result in
        switch result {
        case .success(let events):
            print("Upcoming Events: \(events)")
        case .failure(let error):
            print("Error fetching upcoming events: \(error)")
        }
    }

    self.navigationItem.hidesBackButton = true
    
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self

        
        tabBarView.layer.cornerRadius = tabBarView.frame.height / 2
        tabBarView.clipsToBounds = true
        homeImg.tintColor = .green
    }
    
override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeImg.tintColor = .green
        favImg.tintColor = .white
    }

@IBAction func favTabBarTapped(_ sender: UIButton) {
        homeImg.tintColor = .white
        favImg.tintColor = .green
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FavViewController") as! FavViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return sportsData.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        let sport = sportsData[indexPath.row]
        cell.homeLbl.text = sport.0
        cell.homeImg.image = UIImage(named: sport.1)
        
        
        cell.layer.cornerRadius = 20
        cell.layer.shadowOpacity = 0.5
        cell.layer.shadowRadius = 10
        cell.layer.shadowColor = UIColor.gray.cgColor
        
        return cell
    }
}


extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfItemsPerRow: CGFloat = 2
        let spacingBetweenCells: CGFloat = 7
        
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
        let sport = sportsData[indexPath.row]
        print("\(sport.0) selected")
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        self.navigationController?.pushViewController(vc, animated: true)
        
    }
}
