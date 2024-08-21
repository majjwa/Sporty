//
//  HomeViewController.swift
//  Sporty
//
//  Created by marwa maky on 18/08/2024.
//

import UIKit

protocol HomeProtocol {
    func updateCellData()
}

class HomeViewController: UIViewController, HomeProtocol {

    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var favTabBar: UIView!
    @IBOutlet weak var homeTabBar: UIView!
    @IBOutlet weak var tabBarView: UIView!
    
    var presenter: HomePresenter?

    override func viewDidLoad() {
        super.viewDidLoad()
        homeCollectionView.delegate = self
        homeCollectionView.dataSource = self
        presenter = HomePresenter(homeView: self)
        presenter?.fetchData()
        homeDesign()
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .green
        refreshControl.addTarget(self, action: #selector(refreshDataIndicator(_:)), for: .valueChanged)
        homeCollectionView.refreshControl = refreshControl


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
    func homeDesign(){
        self.navigationItem.hidesBackButton = true
        tabBarView.layer.cornerRadius = tabBarView.frame.height / 2
        tabBarView.clipsToBounds = true
        homeImg.tintColor = .green
    }
    func updateCellData() {
        homeCollectionView.reloadData()
        homeCollectionView.refreshControl?.endRefreshing()

    }
    @objc private func refreshDataIndicator(_ sender: UIRefreshControl) {
       sender.beginRefreshing()
        presenter?.fetchData()
    }
}
// --------------------------------Extension---------------------------------------------------
extension HomeViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.sportsData.count ?? 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HomeCollectionViewCell", for: indexPath) as! HomeCollectionViewCell
        
        if let sport = presenter?.sportsData[indexPath.row] {
            cell.homeLbl.text = sport.title
            cell.homeImg.image = UIImage(named: sport.image)
        }
        
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
        if let sport = presenter?.sportsData[indexPath.row] {
            print("\(sport.title) selected")
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
