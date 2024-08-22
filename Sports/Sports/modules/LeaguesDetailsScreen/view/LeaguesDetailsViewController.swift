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

    func createUpcomingEventsSection() -> NSCollectionLayoutSection {
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .absolute(200))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = .groupPaging
       section.interGroupSpacing = 16
       section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
       return section
   }

    func createLatestEventsSection() -> NSCollectionLayoutSection {
       let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .fractionalHeight(1.0))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(100))
       let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitems: [item])
       let section = NSCollectionLayoutSection(group: group)
       section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
       section.interGroupSpacing = 8
       return section
   }

    func createTeamsSection() -> NSCollectionLayoutSection {
       let itemSize = NSCollectionLayoutSize(widthDimension: .absolute(100), heightDimension: .absolute(100))
       let item = NSCollectionLayoutItem(layoutSize: itemSize)
       let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1.0), heightDimension: .absolute(110))
       let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
       let section = NSCollectionLayoutSection(group: group)
       section.orthogonalScrollingBehavior = .continuous
       section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 10, bottom: 10, trailing: 10)
       section.interGroupSpacing = 16
       return section
   }
}
