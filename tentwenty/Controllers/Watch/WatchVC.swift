//
//  WatchVC.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 08/08/2022.
//

import UIKit

class WatchVC: UIViewController {

    @IBOutlet weak var homeTopBar: UIView!
    @IBOutlet weak var searchBar: UIView!
    @IBOutlet weak var searchTF: UITextField!
    
    @IBOutlet weak var moviesCV: UICollectionView!
    @IBOutlet weak var searchCatView: UIView!
    
    @IBOutlet weak var topResultView: UIView!
    @IBOutlet weak var topResultHeight: NSLayoutConstraint!
    
    //SEARCHED
    @IBOutlet weak var searchedTopBar: UIView!
    @IBOutlet weak var lblSearchedTop: UILabel!
    
    var upComingMovies = [Movie]()
    var filterUpComingMovies = [Movie]()
    var searchActive : Bool = false

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.searchTF.delegate = self
        self.searchTF.returnKeyType = .go
        hideKeyboardWhenTappedAround()
        loadData()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let ptcTBC = self.tabBarController as? PTCardTabBarController {
            ptcTBC.customTabBar.isHidden = false
        }
    }
    
    
    func reloadMovies(searchKey:String){
        
        filterUpComingMovies = upComingMovies.filter({ (data) -> Bool in
            let code = data.title
            let range1 = code.range(of: searchKey , options: .caseInsensitive)
            return range1 != nil
        })
        if(filterUpComingMovies.count == 0){
            if searchKey.isBlank {
                searchActive = false
            }else{
                //EMTY SHOW
                searchActive = true
            }
        } else {
            searchActive = true
        }
        self.moviesCV.reloadData()
        
    }
    
    
    @IBAction func actionHomeSearch(_ sender: Any) {
       
        homeTopBar.isHidden = true
        searchCatView.isHidden = false
        moviesCV.isHidden = true
        
    }
    
    @IBAction func actionClose(_ sender: Any) {
     
        homeTopBar.isHidden = false
        searchCatView.isHidden = true
        moviesCV.isHidden = false
        topResultHeight.constant = 0
        searchActive = false
        moviesCV.reloadData()
    }
    
    @IBAction func editingChanged(_ sender: UITextField) {
        
        if let searchText = sender.text {
            
            if !searchText.isBlank {
                if homeTopBar.isHidden {
                    topResultHeight.constant = 50
                }
                
                moviesCV.isHidden = false
                searchCatView.isHidden = true
                reloadMovies(searchKey: searchText)
            }else{
                topResultHeight.constant = 0
                moviesCV.isHidden = true
                searchCatView.isHidden = false
            }

        }
        
    }
    
    @IBAction func actionSearchedBack(_ sender: Any) {
        
        self.searchBar.isHidden = false
        self.searchedTopBar.isHidden = true

        
    }
}
