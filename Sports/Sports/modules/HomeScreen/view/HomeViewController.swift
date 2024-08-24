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
    
    var presenter: HomePresenter?
    //Outlets:
    @IBOutlet weak var homeCollectionView: UICollectionView!
    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var homeImg: UIImageView!
    @IBOutlet weak var favTabBar: UIView!
    @IBOutlet weak var homeTabBar: UIView!
    @IBOutlet weak var tabBarView: UIView!
    

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
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        vc.isFavoritesMode = true
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



