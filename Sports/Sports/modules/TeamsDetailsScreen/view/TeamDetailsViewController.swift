import UIKit
import Kingfisher

protocol TeamDetailsViewProtocol: AnyObject {
    func updateTeamDetails()
}

class TeamDetailsViewController: UIViewController, TeamDetailsViewProtocol {

    @IBOutlet weak var teamTbl: UITableView!
    @IBOutlet weak var TeamImg: UIImageView!
    @IBOutlet weak var coachName: UILabel!
    
    @IBOutlet weak var tittle: UILabel!
    var presenter: TeamsDetailsPresenter?
    var teamKey: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        teamTbl.register(UINib(nibName: "playersTableViewCell", bundle: nil), forCellReuseIdentifier: "playersTableViewCell")
        teamTbl.dataSource = self
        teamTbl.delegate = self
        
        if let teamKey = teamKey {
            presenter = TeamsDetailsPresenter(teamKey: teamKey)
            presenter?.apiManager = APIManager.shared
            presenter?.view = self 
            presenter?.fetchTeamDetails()
        } else {
            print("Team key is missing.")
        }
    }

    
    func updateTeamDetails() {
        tittle.text = presenter?.team?.teamName ?? ""
        tittle.textColor = .white
        
        coachName.text = "Coach: " + (presenter?.team?.coaches.first!.coachName)!
        if let teamLogoUrl = URL(string: presenter?.team?.teamLogo ?? "") {
            TeamImg.kf.setImage(with: teamLogoUrl)
        }
        teamTbl.reloadData()
    }

    @IBAction func dismiss(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
