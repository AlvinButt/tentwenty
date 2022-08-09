//
//  WatchDetailVC-YTPlayerViewDelegate.swift
//  tentwenty
//
//  Created by Arslan Ahmad on 10/08/2022.
//

import UIKit
import youtube_ios_player_helper

extension WatchDetailVC: YTPlayerViewDelegate {
    
    func playerView(_ playerView: YTPlayerView, didChangeTo state: YTPlayerState) {
        
        if state == .ended {
            
            stopPlayer()
            
        }
        
    }
    
    func playerViewPreferredWebViewBackgroundColor(_ playerView: YTPlayerView) -> UIColor {
        return UIColor.black
    }
    
    func playerViewDidBecomeReady(_ playerView: YTPlayerView) {
        playerView.playVideo()
    }
    
}
