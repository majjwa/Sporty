//
//  thirdCollectionViewCell.swift
//  Sporty
//
//  Created by marwa maky on 22/08/2024.
//

import UIKit

class thirdCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamName: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.contentView.layer.cornerRadius = 20
           self.contentView.layer.masksToBounds = true
    }

}
