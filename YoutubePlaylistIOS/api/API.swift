//
//  API.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/13/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

import Foundation
class Api{
    var urlComponent: URLComponents
    var key: URLQueryItem
    static let shared = Api()
    private init(){
        urlComponent = URLComponents()
        urlComponent.scheme = "https"
        urlComponent.host = "www.googleapis.com"
        key = URLQueryItem(name: "key", value: API_KEY)

    }
    func searchChannel(channel:String,completion: @escaping  (_ result: ChannelSearchListResponse?)->()){
        urlComponent.path = "/youtube/v3/search"
        let part = URLQueryItem(name: "part", value: "snippet")
        let maxResults = URLQueryItem(name: "maxResults", value: "10")
        let type = URLQueryItem(name: "type", value: "channel")
        let q = URLQueryItem(name: "q", value: channel)
        urlComponent.queryItems = [part,maxResults,type,q,key]
        if let url = urlComponent.url{
            print("URL: \(url)")
            let task = URLSession.shared.channelSearchListResponseTask(with: url) { channelSearchListResponse, response, error in
                if let error = error{
                    print("Error: \(error.localizedDescription)")
                }
                if let channelSearchListResponse = channelSearchListResponse {

                    print("Datat")
                    completion(channelSearchListResponse)
                }
                completion(nil)
            }
            task.resume()
        }
    }

    func searchForPlaylists(byChannelId channelId:String, channelName:String, channelImage:String, completion: @escaping (_ result: [PlaylistListItem]?)->()){
        urlComponent.path = "/youtube/v3/playlists"
        let part = URLQueryItem(name: "part", value: "snippet,contentDetails")
        let maxResults = URLQueryItem(name: "maxResults", value: "50")
        let channelIdQ = URLQueryItem(name: "channelId", value: channelId)
        urlComponent.queryItems = [part,maxResults,channelIdQ,key]
        guard let url = urlComponent.url else {
            completion(nil)
            return
        }
        print(url)
        //        let task = URLSession.shared.playlistListResponseTask(with: url) { (playListResponse, response, error) in
        //            if let error = error{
        //                print("Error \(error.localizedDescription)")
        //                completion(nil)
        //            }
        //            guard let playListResponse = playListResponse else {
        //                completion(nil)
        //                return
        //            }
        //            var playlistListItems = playListResponse.items.map { (item: PlaylistListResponse.Item) -> PlaylistListItem in
        //                return PlaylistListItem(playlistName: item.snippet.title, playlistThumbnailURL: item.snippet.thumbnails.high.url, playlistId: item.id, playlistVideoCount: item.contentDetails.itemCount)
        //            }
        //            //PlaylistListItem(channelName + " Uploads", channelImage, uploadCount, channelPlaylistId));
        //            //                    String channelPlaylistId = channelId.replaceAll("UC", "UU");
        //            let channelIdPlaylist = channelId.replacingOccurrences(of: "UC", with: "UU")
        //
        //            playlistListItems.insert(PlaylistListItem(playlistName: "\(channelName) Uploads", playlistThumbnailURL: channelImage, playlistId: channelIdPlaylist, playlistVideoCount: 200), at: 0)
        //            completion(playlistListItems)
        //
        //        }
        //        task.resume()
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data,resp,err in
            if let err = err{
                print("error: \(err.localizedDescription)")
                completion(nil)
            }
            if let data = data{
                do {
                    let playlistResponse = try JSONDecoder().decode(PlaylistListResponse.self, from: data )
                    var playlistListItems = playlistResponse.items.map { (item: PlaylistListResponse.Item) -> PlaylistListItem in
                        return PlaylistListItem(playlistName: item.snippet.title, playlistThumbnailURL: item.snippet.thumbnails.high?.url ?? "", playlistId: item.id, playlistVideoCount: item.contentDetails.itemCount)
                        
                    }
                    let channelIdPlaylist = channelId.replacingOccurrences(of: "UC", with: "UU")
                    playlistListItems.insert(PlaylistListItem(playlistName: "\(channelName) Uploads", playlistThumbnailURL: channelImage, playlistId: channelIdPlaylist, playlistVideoCount: 200), at: 0)
                    completion(playlistListItems)
                } catch{
                    let error = error as! DecodingError
                    print("Error during JSON serialization: \(error.recoverySuggestion)")
                    print(error)
                    completion(nil)
                }
            }
        })
        task.resume()

    }
    
}


