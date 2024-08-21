import Foundation

class HomePresenter {
    var homeView: HomeProtocol?
    var sportsData: [HomeModel] = []
    
    init(homeView: HomeProtocol? = nil) {
        self.homeView = homeView
    }
    
    func fetchData() {
    
        sportsData = [
            HomeModel(image: "Football", title: "Football"),
            HomeModel(image: "Basketball", title: "Basketball"),
            HomeModel(image: "cricket", title: "Cricket"),
            HomeModel(image: "tennis", title: "Tennis"),
            HomeModel(image: "skating", title: "Skating"),
            HomeModel(image: "running", title: "Running"),
            HomeModel(image: "swimming", title: "Swimming"),
            HomeModel(image: "Golf", title: "Golf"),
            HomeModel(image: "sky", title: "Skydiving"),
            HomeModel(image: "cycling", title: "Cycling"),
            HomeModel(image: "box", title: "Boxing"),
            HomeModel(image: "batball", title: "BatBall"),
            
        ]
        
       
        homeView?.updateCellData()
    }
}
