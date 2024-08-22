
import UIKit

class FavViewController: UIViewController {

    @IBOutlet weak var favTableView: UITableView!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var homeImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
         favTableView.dataSource = self
         favTableView.delegate = self
         tblDesgin()
         favTableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaguesTableViewCell")
      
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        favImg.tintColor = .green
        homeImg.tintColor = .white
    }

    @IBAction func HomeBtn(_ sender: UIButton) {
        homeImg.tintColor = .green
        favImg.tintColor = .white
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }

    func tblDesgin(){
        self.navigationItem.hidesBackButton = true
        favImg.tintColor = .green
        homeImg.tintColor = .white
        favTableView.tableFooterView = UIView()
        tabBarView.layer.cornerRadius = tabBarView.frame.height / 2
        tabBarView.clipsToBounds = true
    }
}
// --------------------------------Extension---------------------------------------------------
extension FavViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell", for: indexPath) as! LeaguesTableViewCell
        cell.backgroundColor = .black
        cell.LeaguesName.text = "League Name"
        cell.LeaguesImg.image = UIImage(named: "Football")
        
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Favorite \(indexPath.section + 1)")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }

    // space between cells using footer height
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 12
    }

    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear 
        return footerView
    }
}
