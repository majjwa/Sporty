//
//  LeaguesDetailsViewController.swift
//  Sporty
//
//  Created by marwa maky on 20/08/2024.
//
import Foundation
import UIKit
protocol LeaguesDetailsProtocol{
    func updateCollectionView()
}
class LeaguesDetailsViewController: UIViewController,LeaguesDetailsProtocol {
    
    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIButton!
    
func updateCollectionView() {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

       
    }
  
    
    @IBAction func favBtn(_ sender: Any) {
    }
    

}
