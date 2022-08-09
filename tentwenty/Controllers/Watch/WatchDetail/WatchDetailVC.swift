//
//  WatchDetailVC.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import UIKit

class WatchDetailVC: UIViewController {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var genreCV: UICollectionView!
    @IBOutlet weak var txtOverView: UITextView!
    
    @IBOutlet weak var movieIMV: UIImageView!
    @IBOutlet weak var btnTrailler: UIButton!
    
    var id: Int? = nil
    
    var arrGenre = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let ptcTBC = tabBarController as? PTCardTabBarController {
            ptcTBC.customTabBar.isHidden = true
        }
        
        btnTrailler.imageEdgeInsets = UIEdgeInsets(top: 10, left:10, bottom: 10, right: 20)

        loadData()
        
    }
    
    func loadData() {
        //LOADDATA
        if let id = id {
            BackendController.sharedConrtoller().getMovieInfo(id: id) { success, response in
                if success {
                    
                    let movieInfo:MovieInfo = try! JSONDecoder().decode(MovieInfo.self, from: response.rawData())
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "yyyy-MM-dd"
                    if let date = dateFormatter.date(from: movieInfo.releaseDate) {
                        
                        dateFormatter.dateFormat = "MMM d, yyyy"
                        let newDate = dateFormatter.string(from: date)
                        
                        
                        self.lblDate.text = "In Theaters \(newDate)"
                    }
                    
                    self.movieIMV.loading()
                    self.movieIMV.kf.setImage(with: movieInfo.posterURL)
                    self.txtOverView.text = movieInfo.overview
                    
                    self.arrGenre = movieInfo.genres
                    self.genreCV.reloadData()
                }
            }
        }
    }
    
    @IBAction func actionGetTicket(_ sender: Any) {
        
    }
    
    @IBAction func actionTrailer(_ sender: Any) {
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
    
}
