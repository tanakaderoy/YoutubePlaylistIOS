//
//  ChannelListView.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/13/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import SwiftUI

struct ChannelListView: View {
    @State var searchString = ""
    @State var isLoading = false
    @State var isPresentingAlert = false
    @ObservedObject var channelManager = ChannelManager.shared
    @Environment(\.imageCache) var cache: ImageCache

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
                        .alert(isPresented: self.$isPresentingAlert) { () -> Alert in
                            return Alert(title: Text("Warning!"), message: Text("Please Enter a channel to search for"), dismissButton: .default(Text("OK!"), action: {
                                self.isPresentingAlert.toggle()
                            }))
                        }
                    }
                    List(self.channelManager.getChannels()){(channel: ChannelListItem) in
                        NavigationLink(destination: PlaylistListView(channelId: channel.channelId, channelName: channel.channelName, channelImage: channel.channelImageURL) ) {
                            HStack {
                                AsyncImage(url: URL(string: channel.channelImageURL)!, placeholder: ActivityIndicator(isAnimating: .constant(true), style: .large),cache: self.cache, width: 100,height: 100).aspectRatio(contentMode: .fit)
                                Text(channel.channelName)
                            }
                        }
                    }
                    .navigationBarTitle("Channel Search")

                }
            }
        }
        
    }

    fileprivate func peformSearch(query:String) {
        guard query != "" else {
            isPresentingAlert.toggle()
            return
        }
        isLoading = true
        Api.shared.searchChannel(channel: query) { (status:NetworkCallStatus,resp: ChannelSearchListResponse?) in
            self.isLoading = false
            switch status {
            case .Error:
                print("Error")
                break
            case.Success:
                guard let resp = resp else{return}
                let channelItems = resp.items.map { (item:ChannelSearchListResponse.Item) -> ChannelListItem in
                    return ChannelListItem(channelImageURL: item.snippet.thumbnails.high.url, channelName: item.snippet.channelTitle, channelId: item.snippet.channelID, uploadCount: 3)
                }
                self.channelManager.replace(newChannels: channelItems)
                break
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ChannelListView()
    }
}
