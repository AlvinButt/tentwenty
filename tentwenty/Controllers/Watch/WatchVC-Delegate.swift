//
//  WatchVC-Delegate.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import UIKit

extension WatchVC: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
                
        let watchMovie = searchActive && homeTopBar.isHidden ? self.filterUpComingMovies[indexPath.row] : self.upComingMovies[indexPath.row]
        let vc = storyboard?.instantiateViewController(withIdentifier: "WatchDetailVCID") as! WatchDetailVC
        vc.id = watchMovie.id
        self.navigationController?.pushViewController(vc, animated: true)        
    }
}
