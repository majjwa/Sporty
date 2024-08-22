//
//  secondCollectionViewCell.swift
//  Sporty
//
//  Created by marwa maky on 22/08/2024.
//

import UIKit

class secondCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var score: UILabel!
    @IBOutlet weak var img1: UIImageView!
    @IBOutlet weak var img2: UIImageView!
    @IBOutlet weak var team1Name: UILabel!
    @IBOutlet weak var team2Name: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 20
           self.contentView.layer.masksToBounds = true
    }

}
