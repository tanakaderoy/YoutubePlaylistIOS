//
//  PlaylistListItem.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/13/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import Foundation

public struct PlaylistListItem:Identifiable {
    public let id = UUID()
    var playlistName, playlistThumbnailURL, playlistId: String
    var playlistVideoCount: Int
}
