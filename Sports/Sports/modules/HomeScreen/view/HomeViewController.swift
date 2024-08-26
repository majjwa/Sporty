//
//  HomeViewController.swift
//  Sporty
//
//  Created by marwa maky on 18/08/2024.
//
import UIKit
import Foundation


protocol HomeProtocol {
    func updateCellData()
}

class HomeViewController: UIViewController, HomeProtocol {
    var presenter: HomePresenter?

    @IBOutlet weak var DefaultImg: UIImageView!
    @IBOutlet weak var homeCollectionView: UICollectionView!
    //Custom TabBar Outlets
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
        self.DefaultImg.image = UIImage(named: "connection")
        self.DefaultImg.isHidden = true
        homeDesign()
        setUpRefrechControl()
        NotificationCenter.default.addObserver(self, selector: #selector(handleNetworkStatusChange(_:)), name: .networkStatusChanged, object: nil)
        handleNetworkStatusChange()
    }
    
  override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        homeImg.tintColor = .green
        favImg.tintColor = .white
       
    }
    func setUpRefrechControl(){
        let refreshControl = UIRefreshControl()
        refreshControl.tintColor = .green
        refreshControl.addTarget(self, action: #selector(refreshDataIndicator(_:)), for: .valueChanged)
        homeCollectionView.refreshControl = refreshControl
    }
    @IBAction func favTabBarTapped(_ sender: UIButton) {
        homeImg.tintColor = .white
        favImg.tintColor = .green
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LeaguesViewController") as! LeaguesViewController
        vc.isFavoritesMode = true
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func homeDesign() {
        self.navigationItem.hidesBackButton = true
        tabBarView.layer.cornerRadius = tabBarView.frame.height / 2
        tabBarView.clipsToBounds = true
        homeImg.tintColor = .green
    }

    func updateCellData() {
        homeCollectionView.reloadData()
        homeCollectionView.refreshControl?.endRefreshing()
    }

    @objc func refreshDataIndicator(_ sender: UIRefreshControl) {
        sender.endRefreshing()
    }
    
    @objc func handleNetworkStatusChange(_ notification: Notification? = nil) {
        DispatchQueue.main.async {
            let isReachable = Connectivity.shared.isReachable
            print("Network status change detected: Reachable = \(isReachable)")
            if isReachable {
                self.homeCollectionView.isHidden = false
                self.DefaultImg.isHidden = true
                self.presenter?.fetchData()
            } else {
                self.homeCollectionView.isHidden = true
                self.DefaultImg.isHidden = false
    
            }

            self.view.layoutIfNeeded()
        }
    }
}
