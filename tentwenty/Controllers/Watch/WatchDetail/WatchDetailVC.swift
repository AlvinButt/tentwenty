//
//  WatchDetailVC.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import UIKit
import youtube_ios_player_helper

class WatchDetailVC: UIViewController {
    
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var genreCV: UICollectionView!
    @IBOutlet weak var txtOverView: UITextView!
    
    @IBOutlet weak var movieIMV: UIImageView!
    @IBOutlet weak var btnTrailler: UIButton!
    
    @IBOutlet weak var playerContaier: YTPlayerView!
    @IBOutlet weak var playerView: YTPlayerView!
    
    var id: Int? = nil
    var arrGenre = [Genre]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        playerView.delegate = self
        
        if let ptcTBC = tabBarController as? PTCardTabBarController {
            ptcTBC.customTabBar.isHidden = true
        }
        
        btnTrailler.imageEdgeInsets = UIEdgeInsets(top: 10, left:10, bottom: 10, right: 20)

        loadData()
        
    }
    
    func stopPlayer() {
        playerView.stopVideo()
        playerContaier.isHidden = true
    }
        
    @IBAction func actionGetTicket(_ sender: Any) {
        
    }
    
    @IBAction func actionTrailer(_ sender: Any) {
        
        if let id = id {
            BackendController.sharedConrtoller().getMovieVideo(id: id) { success, response in
                    
                if success {
                    let movieTrailler:MovieTrailler = try! JSONDecoder().decode(MovieTrailler.self, from: response.rawData())
                    let trailer = movieTrailler.results.filter { $0.name == "Official Trailer" }
                    if trailer.count > 0 {
                        self.playerContaier.isHidden = false
                        self.playerView.load(withVideoId: trailer[0].key, playerVars: ["playsinline": "0"])
                    }else{
                        self.showToast(message: "Trailer url not found.", font: UIFont(name: "Poppins-Regular", size: 14.0)!)
                    }
                }
                
            }
        }
        
    }
    
    @IBAction func actionBack(_ sender: Any) {
        if let nav = navigationController {
            nav.popViewController(animated: true)
        }
    }
    
    @IBAction func actionDissmissPlayer(_ sender: Any) {
        stopPlayer()
    }
}
