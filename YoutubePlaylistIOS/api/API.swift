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
        urlComponent.path = "/youtube/v3/search"
        key = URLQueryItem(name: "key", value: API_KEY)

    }
    func searchChannel(channel:String,completion: @escaping  (_ result: ChannelSearchListResponse?)->()){
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
    
}


