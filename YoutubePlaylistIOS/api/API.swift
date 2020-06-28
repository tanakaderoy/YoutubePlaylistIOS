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
    func searchChannel(channel:String,completion: @escaping  (Result<ChannelSearchListResponse, Error>)->()){
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
                    completion(.failure(error))
                    print("Error: \(error.localizedDescription)")
                }
                if let channelSearchListResponse = channelSearchListResponse {

                    print("Datat")
                    completion(.success(channelSearchListResponse))
                }
            }
            task.resume()
        }
    }

    func searchForPlaylists(byChannelId channelId:String, channelName:String, channelImage:String, completion: @escaping (Result<[PlaylistListItem],Error>)->()){
        urlComponent.path = "/youtube/v3/playlists"
        let part = URLQueryItem(name: "part", value: "snippet,contentDetails")
        let maxResults = URLQueryItem(name: "maxResults", value: "50")
        let channelIdQ = URLQueryItem(name: "channelId", value: channelId)
        urlComponent.queryItems = [part,maxResults,channelIdQ,key]
        guard let url = urlComponent.url else {
            completion(.failure(MyError.malformedURL(urlComponent.url?.absoluteString ?? "")))
            return
        }
        print(url)
     
        let task = URLSession.shared.dataTask(with: url, completionHandler: {data,resp,err in
            if let err = err{
                print("error: \(err.localizedDescription)")
                completion(.failure(err))
            }
            if let data = data{
                do {
                    let playlistResponse = try JSONDecoder().decode(PlaylistListResponse.self, from: data )
                    var playlistListItems = playlistResponse.items.map { (item: PlaylistListResponse.Item) -> PlaylistListItem in
                        return PlaylistListItem(playlistName: item.snippet.title, playlistThumbnailURL: item.snippet.thumbnails.high?.url ?? "", playlistId: item.id, playlistVideoCount: item.contentDetails.itemCount)
                        
                    }
                    let channelIdPlaylist = channelId.replacingOccurrences(of: "UC", with: "UU")
                    playlistListItems.insert(PlaylistListItem(playlistName: "\(channelName) Uploads", playlistThumbnailURL: channelImage, playlistId: channelIdPlaylist, playlistVideoCount: 200), at: 0)
                    completion(.success(playlistListItems))
                } catch{
                    let error = error as! DecodingError
                    print("Error during JSON serialization: \(error)")
                    print(error)
                    completion(.failure(error))
                }
            }
        })
        task.resume()

    }

    func fetchPlaylistVideos(byPlaylisttId playlistId:String, completion: @escaping (Result<[VideoListItem], Error>)->()){
        urlComponent.path = "/youtube/v3/playlistItems"
        let part = URLQueryItem(name: "part", value: "snippet,contentDetails")
        let maxResults = URLQueryItem(name: "maxResults", value: "50")
        let playlistIdQ = URLQueryItem(name: "playlistId", value: playlistId)
        urlComponent.queryItems = [part,maxResults,playlistIdQ,key]
        guard let url = urlComponent.url else {
            completion(.failure(MyError.malformedURL(urlComponent.url!.absoluteString)))
            return
        }
        print(url)
        let task = URLSession.shared.playlistListItemResponseTask(with: url) { playlistListItemResponse, response, error in
            if let playlistListItemResponse = playlistListItemResponse {
                let videoListItems = playlistListItemResponse.items.map { (item:PlaylistListItemResponse.Item) -> VideoListItem in
                    return VideoListItem(videoTitle: item.snippet.title, videoDescription: item.snippet.snippetDescription, videoThumbnailUrl: item.snippet.thumbnails.high.url, videoId: item.contentDetails.videoID, playlistId: item.snippet.playlistID)
                }
                completion(.success(videoListItems))
            }
        }
        task.resume()
    }
    
}


enum NetworkCallStatus{
    case Success
    case Error
}

enum MyError: Error {
    case runtimeError(String)
    case malformedURL(String)
    case malformedData(String)
}

