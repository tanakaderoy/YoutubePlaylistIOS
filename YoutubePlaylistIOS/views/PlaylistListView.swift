//
//  PlaylistListView.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/13/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import SwiftUI

struct PlaylistListView: View {
    var channelId,channelName,channelImage: String
    @State var isLoading = false
    @Environment(\.imageCache) var cache: ImageCache
    @ObservedObject var playlistManager = PlaylistManager.shared
    var body: some View {

        LoadingView(isShowing: $isLoading) {

            List(self.playlistManager.getPlaylists()){(item:PlaylistListItem) in
                NavigationLink(destination: VideoListView(playlistId: item.playlistId, playlistName: item.playlistName)) {

                    VStack(alignment:.trailing) {
                        HStack {
                            if(item.playlistThumbnailURL != ""){
                                AsyncImage(url: URL(string: item.playlistThumbnailURL)!, placeholder: ActivityIndicator(isAnimating: .constant(true), style: .large), cache: self.cache,width: 192,height: 108).aspectRatio(contentMode: .fit)
                            }else{
                                Image(systemName: "exclamationmark.triangle").resizable().frame(width: 200, height: 100).aspectRatio(contentMode: .fit)
                            }
                            Text(item.playlistName)
                            Spacer()
                        }
                        Spacer()
                        Text(item.playlistVideoCount.description)
                            .multilineTextAlignment(.trailing)
                            .padding(.trailing)
                    }
                }
            }
        }
        .navigationBarTitle(channelName)
        .onAppear {
            if (self.playlistManager.getChannelName() != self.channelName) {
                self.playlistManager.clear()
                self.searchForPlaylist(channelId: self.channelId)
            }
        }
    }
    
    
    func searchForPlaylist(channelId: String){
        isLoading = true
        Api.shared.searchForPlaylists(byChannelId: channelId,channelName: channelName,channelImage: channelImage) { (resp:[PlaylistListItem]?) in
            self.isLoading = false
            guard let resp = resp else{
                print("error")
                return
            }
            self.playlistManager.replace(newPlaylists: resp, channelName: self.channelName)
        }
    }
}

struct PlaylistListView_Previews: PreviewProvider {
    static var previews: some View {
        PlaylistListView(channelId: "1",channelName: "test",channelImage: "test")
    }
}
