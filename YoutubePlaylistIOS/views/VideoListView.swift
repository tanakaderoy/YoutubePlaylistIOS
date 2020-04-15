//
//  VideoListView.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/14/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import SwiftUI
import UIKit
import Foundation

struct VideoListView: View {
    var playlistId, playlistName: String
    @State var isLoading = false
    @State var isShrunk = true
    @Environment(\.imageCache) var cache: ImageCache
    @ObservedObject var videoManager = VideoListManager.shared

    var body: some View {

        LoadingView(isShowing: $isLoading) {
            List(self.videoManager.getVideos()){ (video:VideoListItem) in
                VStack {
                    HStack {

                        AsyncImage(url: URL(string: video.videoThumbnailUrl)!, placeholder: ActivityIndicator(isAnimating: .constant(true), style: .large), cache: self.cache,width: 192,height: 108).aspectRatio(contentMode: .fit)
                        Text(video.videoTitle)
                        Spacer()
                    }
                    ShowMoreView(isShrunk: self.$isShrunk, description: video.videoDescription).onTapGesture {
                        self.isShrunk.toggle()
                    }.animation(.linear(duration: 0.3))
                }.onTapGesture {
                    video.openVideo()
                }
            }

        }
        .navigationBarTitle(self.playlistName)
        .onAppear {
            if(self.videoManager.getPlaylistId() != self.playlistId){
                self.videoManager.clear()
                self.fetchVideos(playlistId:self.playlistId)
            }
        }
    }




    func fetchVideos(playlistId:String){
        isLoading = true
        Api.shared.fetchPlaylistVideos(byPlaylisttId: playlistId) { (items:[VideoListItem]?) in
            self.isLoading = false
            guard let items = items else{
                print("eror")
                return
            }
            self.videoManager.replace(newVideos: items, playlistId: playlistId)

        }
    }
}

struct VideoListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView(playlistId: "String", playlistName: "")
    }
}



