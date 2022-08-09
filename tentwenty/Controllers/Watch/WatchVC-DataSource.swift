//
//  WatchVC-DataSource.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import UIKit
import Kingfisher

extension WatchVC: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  searchActive && homeTopBar.isHidden ? filterUpComingMovies.count : upComingMovies.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        
        if searchActive && homeTopBar.isHidden  {
            
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SearchMovieCellID", for: indexPath) as! SearchMovieCell
            cell.layer.cornerRadius = 10
            let movie = filterUpComingMovies[indexPath.row]
            cell.lblName.text = movie.title
            cell.movieIMV.loading()
            cell.movieIMV.kf.setImage(with: movie.backdropURL)
            return cell
            
        }
        
            
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MovieCellID", for: indexPath) as! MovieCell
        cell.layer.cornerRadius = 10
        let movie = upComingMovies[indexPath.row]
        cell.lblName.text = movie.title
        cell.movieIMV.loading()
        cell.movieIMV.kf.setImage(with: movie.backdropURL)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.bounds.width, height: self.searchActive ? 100 :180)
    }
    
}
