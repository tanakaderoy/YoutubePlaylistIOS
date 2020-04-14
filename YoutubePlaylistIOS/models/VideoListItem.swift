//
//  VideoListItem.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/14/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import Foundation
import UIKit
struct VideoListItem:Identifiable, Hashable {
    var id = UUID()
    var videoTitle, videoDescription, videoThumbnailUrl, videoId, playlistId: String
    func getAppURL() -> String{
        return"youtube://www.youtube.com/watch?v=" + videoId + "&list=" + playlistId
    }
    func getWebURL()->String{
        return"https://www.youtube.com/watch?v=" + videoId + "&list=" + playlistId
    }

    func openVideo(){
        let application = UIApplication.shared
        let appURL = URL(string: self.getAppURL())!
        let webURL = URL(string: self.getWebURL())!
        if application.canOpenURL(appURL as URL) {
            application.open(appURL as URL)
        } else {
            // if Youtube app is not installed, open URL inside Safari
            application.open(webURL as URL)
        }
    }
}
