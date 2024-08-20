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

        // Set up the tabBarView with rounded corners
        tabBarView.layer.cornerRadius = tabBarView.frame.height / 2
        tabBarView.clipsToBounds = true

        // Register the NIB for the cell
        favTableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: "LeaguesTableViewCell")
        
        // Set up the table view's dataSource and delegate
        favTableView.dataSource = self
        favTableView.delegate = self
        
        // Remove extra separators
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

    @IBAction func FavBtn(_ sender: UIButton) {
        // No action needed here as we are already on the Favorites screen
    }
}

extension FavViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 // Replace with the actual number of favorite items
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "LeaguesTableViewCell", for: indexPath) as! LeaguesTableViewCell
        cell.backgroundColor = .black
        cell.LeaguesName.text = "League Name"
        cell.LeaguesImg.image = UIImage(named: "Football")
        cell.secImg.image = UIImage(named: "youtube")
   


        return cell
    }
  
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected Favorite \(indexPath.row + 1)")
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Adjust based on your cell's content and desired spacing
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let inset: CGFloat = 10
        cell.contentView.frame = cell.contentView.frame.inset(by: UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset))
    }
}
