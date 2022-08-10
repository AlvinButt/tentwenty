//
//  WatchDetailVC-LoadData.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 10/08/2022.
//

import UIKit

extension WatchDetailVC {
    
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
                    
                    self.name = movieInfo.title
                }
            }
        }
    }
    
}
