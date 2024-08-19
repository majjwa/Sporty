//
//  FavViewController.swift
//  Sporty
//
//  Created by marwa maky on 19/08/2024.
//

import UIKit

class FavViewController: UIViewController {
    @IBOutlet weak var FavTable: UITableView!
    
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var FavView: UIImageView!
    @IBOutlet weak var homeView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        FavView.tintColor = .green
        homeView.tintColor = .white
        
        tabBarView.layer.cornerRadius = tabBarView.frame.height / 2
        tabBarView.clipsToBounds = true
        
    }
    override func viewWillAppear(_ animated: Bool) {
        FavView.tintColor = .green
        homeView.tintColor = .white
    }


}
