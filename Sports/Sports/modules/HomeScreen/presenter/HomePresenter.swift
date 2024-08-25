import Foundation
import Alamofire
class HomePresenter {
    var homeView: HomeProtocol?
    var sportsData: [HomeModel] = []

    init(homeView: HomeProtocol? = nil) {
        self.homeView = homeView
       
    }
    func fetchData() {
        sportsData = [
            HomeModel(image: "Football", title: "football"),
            HomeModel(image: "Basketball", title: "basketball"),
            HomeModel(image: "cricket", title: "cricket"),
            HomeModel(image: "tennis", title: "tennis"),
            HomeModel(image: "skating", title: "skating"),
            HomeModel(image: "running", title: "running"),
            HomeModel(image: "swimming", title: "swimming"),
            HomeModel(image: "Golf", title: "golf"),
            HomeModel(image: "sky", title: "skydiving"),
            HomeModel(image: "cycling", title: "cycling"),
            HomeModel(image: "box", title: "boxing"),
            HomeModel(image: "batball", title: "batBall"),
        ]
        
        homeView?.updateCellData()
    }
}
