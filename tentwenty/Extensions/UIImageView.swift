//
//  UIImageView.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 09/08/2022.
//

import Kingfisher
import UIKit

extension UIImageView {
    func loading() {
        var kf = self.kf
        kf.indicatorType = .activity
    }
}
