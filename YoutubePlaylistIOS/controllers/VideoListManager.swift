//
//  VideoListManager.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/14/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import Foundation
class VideoListManager:ObservableObject{
    @Published private var videos = [VideoListItem]()
    static let shared = VideoListManager()
    var playlistId = ""
    public func replace(newVideos:[VideoListItem], playlistId: String){
        self.playlistId = playlistId
        DispatchQueue.main.async {[weak self] in
            self?.videos = newVideos
        }
    }
    func clear(){
        DispatchQueue.main.async {[weak self] in
//            self?.videos = [VideoListItem]()
            self?.videos.removeAll()
        }
    }
    func getVideos() -> [VideoListItem] {return videos}
    func getPlaylistId() -> String {return playlistId}

}
