//
//  ChannelListItem.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/13/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import Foundation
public struct ChannelListItem:Identifiable {
    public var id = UUID()
    public var channelImageURL: String
    public var channelName: String
    public var channelId: String
    public var uploadCount: Int

}

