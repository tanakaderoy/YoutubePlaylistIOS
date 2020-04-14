//
//  ContentView.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/13/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var searchString = ""
    @State var isLoading = false
    @ObservedObject var channelManager = ChannelManager.shared
    @Environment(\.imageCache) var cache: ImageCache



    fileprivate func peformSearch(query:String) {
        isLoading = true
        Api.shared.searchChannel(channel: query) { (resp: ChannelSearchListResponse?) in
            guard let resp = resp else{
                self.isLoading = false
                print("Error!!!!")
                return
            }
            self.isLoading = false
            let channelItems = resp.items.map { (item:ChannelSearchListResponse.Item) -> ChannelListItem in
                return ChannelListItem(channelImageURL: item.snippet.thumbnails.high.url, channelName: item.snippet.channelTitle, channelId: item.snippet.channelID, uploadCount: 3)
            }
            self.channelManager.replace(newChannels: channelItems)
        }
    }

    var body: some View {
        NavigationView{
            LoadingView(isShowing: $isLoading) {

                VStack {
                    HStack{
                        TextField("Search for Channel", text: self.$searchString, onCommit: {
                            self.peformSearch(query: self.searchString)
                        }).border(Color.black,width: 0.5).padding(.all, 8)
                        Button(action: {
                            self.peformSearch(query: self.searchString)

                        }, label: {
                            Text("Go!").padding()
                        })
                    }
                    List(self.channelManager.getChannels()){(channel: ChannelListItem) in
                        HStack {
                            AsyncImage(url: URL(string: channel.channelImageURL)!, placeholder: Text("Loading..."),cache: self.cache).aspectRatio(contentMode: .fit)
                            Text(channel.channelName)
                        }
                    }
                    .navigationBarTitle("Channel Search")

                }
            }
        }
        
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
