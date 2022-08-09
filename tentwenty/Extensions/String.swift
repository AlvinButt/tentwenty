//
//  String.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import Foundation

extension String {
    
    var isBlank: Bool{
        self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
    
}
