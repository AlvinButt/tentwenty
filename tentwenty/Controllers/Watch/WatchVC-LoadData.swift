//
//  WatchVC-LoadData.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import Foundation

extension WatchVC {
    func loadData() {
        BackendController.sharedConrtoller().getUpCommingMovies { success, response in
            
            if success {
                let movies:UpcomingMovie = try! JSONDecoder().decode(UpcomingMovie.self, from: response.rawData())
                self.upComingMovies = movies.results
                self.moviesCV.reloadData()
            }
        }
    }
}
