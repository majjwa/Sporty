import Foundation
import UIKit

protocol LeaguesDetailsProtocol {
    func updateCollectionView()
}

class LeaguesDetailsViewController: UIViewController, LeaguesDetailsProtocol {

    @IBOutlet weak var DetailsCollectionView: UICollectionView!
    @IBOutlet weak var favBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupCompositionalLayout()
        DetailsCollectionView.register(UINib(nibName: "fisrtCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "fisrtCollectionViewCell")
        DetailsCollectionView.register(UINib(nibName: "secondCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "secondCollectionViewCell")
        DetailsCollectionView.register(UINib(nibName: "thirdCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "thirdCollectionViewCell")
        DetailsCollectionView.dataSource = self
        DetailsCollectionView.delegate = self
    }
    
    @IBAction func Dismiss(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)

    }
    func updateCollectionView() {
        DetailsCollectionView.reloadData()
    }

     func setupCompositionalLayout() {
        DetailsCollectionView.collectionViewLayout = createCompositionalLayout()
    }
    @IBAction func favBtn(_ sender: Any) {
        
    }
    
    
    
func createCompositionalLayout() -> UICollectionViewCompositionalLayout {
       return UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvironment) -> NSCollectionLayoutSection? in
           
           switch sectionIndex {
           case 0:
               return self.createUpcomingEventsSection()
           case 1:
               return self.createLatestEventsSection()
           case 2:
               return self.createTeamsSection()
           default:
               return nil
           }
       }
   }

  
}
