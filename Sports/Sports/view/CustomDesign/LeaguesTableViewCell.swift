//
//  LeaguesTableViewCell.swift
//  Sporty
//
//  Created by marwa maky on 20/08/2024.
//

import UIKit

class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var LeaguesImg: UIImageView!
    @IBOutlet weak var LeaguesName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.cornerRadius = 15
        self.contentView.layer.masksToBounds = true
        
                
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
           
    }
    @IBAction func btnGoUTube(_ sender: Any) {
        DispatchQueue.main.async {
                self.openYouTube()
            }
    }
    func openYouTube() {
//            var str = LeaguesName.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        var str = "UEFAEuropaLeague"
            str = str.replacingOccurrences(of: " ", with: "")
            print("\(str)")
            UIApplication.shared.open(URL(string: ("https://www.youtube.com/@\(str)"))!, options: [:], completionHandler: nil)
        }
    
}
