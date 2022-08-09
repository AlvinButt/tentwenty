//
//  WatchVC-TextField.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import UIKit

extension WatchVC:UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if filterUpComingMovies.count > 0 && searchCatView.isHidden {
            self.lblSearchedTop.text = "\(filterUpComingMovies.count) Results found."
            
            self.searchBar.isHidden = true
            self.searchedTopBar.isHidden = false
            
        }
        
        textField.resignFirstResponder() // dismiss keyboard
        return true
    }
}
