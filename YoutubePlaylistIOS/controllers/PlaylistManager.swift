//
//  PlaylistManager.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/14/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import Foundation

class PlaylistManager:ObservableObject{
    @Published private var playlists = [PlaylistListItem]()
    private var channelName = ""
    static let shared = PlaylistManager()
    public func replace(newPlaylists:[PlaylistListItem], channelName:String){
        self.channelName = channelName
        DispatchQueue.main.async {[weak self] in
            self?.playlists = newPlaylists
        }
    }
    func getChannelName()->String{return channelName}
    func clear(){
        DispatchQueue.main.async {[weak self] in
            self?.playlists = [PlaylistListItem]()
        }
    }
    func getPlaylists() -> [PlaylistListItem] {return playlists}

}
