//
//  LeaguesTableViewCell.swift
//  Sporty
//
//  Created by marwa maky on 20/08/2024.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var secImg: UIImageView!
    @IBOutlet weak var LeaguesImg: UIImageView!
    @IBOutlet weak var LeaguesName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 15
                self.contentView.layer.masksToBounds = true
      
                LeaguesImg.layer.cornerRadius = LeaguesImg.frame.size.height / 2
                LeaguesImg.clipsToBounds = true
            
                
                secImg.layer.cornerRadius = secImg.frame.size.height / 2
                secImg.clipsToBounds = true
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
