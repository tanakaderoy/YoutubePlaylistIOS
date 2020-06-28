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
    @ObservedObject var videoManager = VideoListManager.shared

    var body: some View {

        LoadingView(isShowing: $isLoading) {
            List(self.videoManager.getVideos()){ (video:VideoListItem) in
                VideoCell(video: video)
            }

        }
        .navigationBarTitle(self.playlistName)
        .onAppear {
            if(self.videoManager.getPlaylistId() != self.playlistId){
                self.fetchVideos(playlistId:self.playlistId)
            }
        }
    }




    func fetchVideos(playlistId:String){
        isLoading = true
        Api.shared.fetchPlaylistVideos(byPlaylisttId: playlistId) { (res: Result<[VideoListItem], Error>) in
            self.isLoading = false
            switch res{
            case .failure(let error):
                print("error \(error)")
                break
            case .success(let items):
                self.videoManager.replace(newVideos: items, playlistId: playlistId)
                break
            }

        }
    }
}

struct VideoListView_Previews: PreviewProvider {
    static var previews: some View {
        VideoListView(playlistId: "String", playlistName: "")
    }
}




struct VideoCell: View {
    @Environment(\.imageCache) var cache: ImageCache
    var video: VideoListItem
    @State var isLoading = false
    @State var isShrunk = true
    var body: some View {
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
            self.video.openVideo()
        }
    }
}
