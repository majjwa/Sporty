import UIKit

class FavViewController: UIViewController {

    @IBOutlet weak var favTableView: UITableView!
    @IBOutlet weak var tabBarView: UIView!
    @IBOutlet weak var favImg: UIImageView!
    @IBOutlet weak var homeImg: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true

        favImg.tintColor = .green
        homeImg.tintColor = .white

        tabBarView.layer.cornerRadius = tabBarView.frame.height / 2
        tabBarView.clipsToBounds = true

        favTableView.dataSource = self
        favTableView.delegate = self
        
        favTableView.tableFooterView = UIView()
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

}

extension FavViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavTableViewCell", for: indexPath) as! FavTableViewCell
        cell.lbl.text = "ahmed"
        cell.firstImg.image = UIImage(named: "Football")
        cell.secImg.image = UIImage(named: "youtube")
        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Favorite \(indexPath.row + 1)")
        tableView.deselectRow(at: indexPath, animated: true)
    }


//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 30
//    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
       
        let inset: CGFloat = 10
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }
}
