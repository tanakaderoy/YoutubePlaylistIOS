//
//  ChannelManager.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/13/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import Foundation

class ChannelManager:ObservableObject {
    @Published private var channels = [ChannelListItem]()
    static let shared = ChannelManager()
    func addChannel(channel:ChannelListItem) {
        DispatchQueue.main.async {
            self.channels.append(channel)
        }
    }

    func replace(newChannels: [ChannelListItem]){
        DispatchQueue.main.async {
            self.channels = newChannels
        }
    }
    func getChannels()-> [ChannelListItem] {return channels}


}
class PlaylistManager:ObservableObject{
    @Published private var playlists = [PlaylistListItem]()
    static let shared = PlaylistManager()
    public func replace(newPlaylists:[PlaylistListItem]){
        DispatchQueue.main.async {
            self.playlists = newPlaylists
        }
    }
    func clear(){
        DispatchQueue.main.async {
                   self.playlists = [PlaylistListItem]()
               }
    }
    func getPlaylists() -> [PlaylistListItem] {return playlists}

}
