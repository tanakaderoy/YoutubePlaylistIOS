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
