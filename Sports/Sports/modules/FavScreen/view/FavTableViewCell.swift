import UIKit

class FavTableViewCell: UITableViewCell {

    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var secImg: UIImageView!
    @IBOutlet weak var firstImg: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
     
        self.contentView.layer.cornerRadius = 10
        self.contentView.layer.masksToBounds = true

     
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.layer.shadowRadius = 4
        self.layer.shadowOpacity = 0.2
        self.layer.masksToBounds = false
        
       
        firstImg.layer.cornerRadius = firstImg.frame.size.height / 2
        firstImg.clipsToBounds = true
        secImg.layer.cornerRadius = secImg.frame.size.height / 2
        secImg.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
}
