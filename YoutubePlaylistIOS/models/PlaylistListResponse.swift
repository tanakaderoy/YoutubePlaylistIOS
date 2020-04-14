//
//  PlaylistListResponse.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/13/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playlistListResponse = try? newJSONDecoder().decode(PlaylistListResponse.self, from: jsonData)

import Foundation

// MARK: - PlaylistListResponse
class PlaylistListResponse: Codable {
    let kind, etag: String
    let nextPageToken: String?
    let pageInfo: PageInfo
    let items: [Item]
    
    enum CodingKeys: String, CodingKey {
        case kind
        case etag
        case nextPageToken = "nextPageToken"
        case pageInfo
        case items
    }
    init(kind: String, etag: String, nextPageToken: String, pageInfo: PageInfo, items: [Item]) {
        self.kind = kind
        self.etag = etag
        self.nextPageToken = nextPageToken
        self.pageInfo = pageInfo
        self.items = items
    }
    
    
    // MARK: - Item
    class Item: Codable {
        let kind, etag, id: String
        let snippet: Snippet
        let contentDetails: ContentDetails
        
        init(kind: String, etag: String, id: String, snippet: Snippet, contentDetails: ContentDetails) {
            self.kind = kind
            self.etag = etag
            self.id = id
            self.snippet = snippet
            self.contentDetails = contentDetails
        }
    }
    
    // MARK: - ContentDetails
    class ContentDetails: Codable {
        let itemCount: Int
        
        init(itemCount: Int) {
            self.itemCount = itemCount
        }
    }
    
    // MARK: - Snippet
    class Snippet: Codable {
        let publishedAt, channelID, title, snippetDescription: String
        let thumbnails: Thumbnails
        let channelTitle: String
        let localized: Localized
        
        enum CodingKeys: String, CodingKey {
            case publishedAt
            case channelID = "channelId"
            case title
            case snippetDescription = "description"
            case thumbnails, channelTitle, localized
        }
        
        init(publishedAt: String, channelID: String, title: String, snippetDescription: String, thumbnails: Thumbnails, channelTitle: String, localized: Localized) {
            self.publishedAt = publishedAt
            self.channelID = channelID
            self.title = title
            self.snippetDescription = snippetDescription
            self.thumbnails = thumbnails
            self.channelTitle = channelTitle
            self.localized = localized
        }
    }
    
    // MARK: - Localized
    class Localized: Codable {
        let title, localizedDescription: String
        
        enum CodingKeys: String, CodingKey {
            case title
            case localizedDescription = "description"
        }
        
        init(title: String, localizedDescription: String) {
            self.title = title
            self.localizedDescription = localizedDescription
        }
    }
    
    // MARK: - Thumbnails
    class Thumbnails: Codable {
        let thumbnailsDefault, medium, high, standard: Default?
        let maxres: Default?
        
        enum CodingKeys: String, CodingKey {
            case thumbnailsDefault = "default"
            case medium, high, standard, maxres
        }
        
        init(thumbnailsDefault: Default, medium: Default, high: Default, standard: Default, maxres: Default) {
            self.thumbnailsDefault = thumbnailsDefault
            self.medium = medium
            self.high = high
            self.standard = standard
            self.maxres = maxres
        }
    }
    
    // MARK: - Default
    class Default: Codable {
        let url: String
        let width, height: Int
        
        init(url: String, width: Int, height: Int) {
            self.url = url
            self.width = width
            self.height = height
        }
    }
    
    // MARK: - PageInfo
    class PageInfo: Codable {
        let totalResults, resultsPerPage: Int
        
        init(totalResults: Int, resultsPerPage: Int) {
            self.totalResults = totalResults
            self.resultsPerPage = resultsPerPage
        }
    }
}
// MARK: - URLSession response handlers

extension URLSession {
    
    func playlistListResponseTask(with url: URL, completionHandler: @escaping (PlaylistListResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
