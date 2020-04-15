//
//  PlaylistListItemResponse.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/14/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let playlistListItemResponse = try? newJSONDecoder().decode(PlaylistListItemResponse.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.playlistListItemResponseTask(with: url) { playlistListItemResponse, response, error in
//     if let playlistListItemResponse = playlistListItemResponse {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - PlaylistListItemResponse
class PlaylistListItemResponse: Codable {
    let kind, etag:String
    let prevPageToken,nextPageToken: String?
    let pageInfo: PageInfo
    let items: [Item]

    init(kind: String, etag: String, nextPageToken: String, prevPageToken: String, pageInfo: PageInfo, items: [Item]) {
        self.kind = kind
        self.etag = etag
        self.nextPageToken = nextPageToken
        self.prevPageToken = prevPageToken
        self.pageInfo = pageInfo
        self.items = items
    }


    //
    // To read values from URLs:
    //
    //   let task = URLSession.shared.itemTask(with: url) { item, response, error in
    //     if let item = item {
    //       ...
    //     }
    //   }
    //   task.resume()

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

    //
    // To read values from URLs:
    //
    //   let task = URLSession.shared.contentDetailsTask(with: url) { contentDetails, response, error in
    //     if let contentDetails = contentDetails {
    //       ...
    //     }
    //   }
    //   task.resume()

    // MARK: - ContentDetails
    class ContentDetails: Codable {
        let videoID, videoPublishedAt: String

        enum CodingKeys: String, CodingKey {
            case videoID = "videoId"
            case videoPublishedAt
        }

        init(videoID: String, videoPublishedAt: String) {
            self.videoID = videoID
            self.videoPublishedAt = videoPublishedAt
        }
    }

    //
    // To read values from URLs:
    //
    //   let task = URLSession.shared.snippetTask(with: url) { snippet, response, error in
    //     if let snippet = snippet {
    //       ...
    //     }
    //   }
    //   task.resume()

    // MARK: - Snippet
    class Snippet: Codable {
        let publishedAt, channelID, title, snippetDescription: String
        let thumbnails: Thumbnails
        let channelTitle, playlistID: String
        let position: Int
        let resourceID: ResourceID

        enum CodingKeys: String, CodingKey {
            case publishedAt
            case channelID = "channelId"
            case title
            case snippetDescription = "description"
            case thumbnails, channelTitle
            case playlistID = "playlistId"
            case position
            case resourceID = "resourceId"
        }

        init(publishedAt: String, channelID: String, title: String, snippetDescription: String, thumbnails: Thumbnails, channelTitle: String, playlistID: String, position: Int, resourceID: ResourceID) {
            self.publishedAt = publishedAt
            self.channelID = channelID
            self.title = title
            self.snippetDescription = snippetDescription
            self.thumbnails = thumbnails
            self.channelTitle = channelTitle
            self.playlistID = playlistID
            self.position = position
            self.resourceID = resourceID
        }
    }

    //
    // To read values from URLs:
    //
    //   let task = URLSession.shared.resourceIDTask(with: url) { resourceID, response, error in
    //     if let resourceID = resourceID {
    //       ...
    //     }
    //   }
    //   task.resume()

    // MARK: - ResourceID
    class ResourceID: Codable {
        let kind, videoID: String

        enum CodingKeys: String, CodingKey {
            case kind
            case videoID = "videoId"
        }

        init(kind: String, videoID: String) {
            self.kind = kind
            self.videoID = videoID
        }
    }

    //
    // To read values from URLs:
    //
    //   let task = URLSession.shared.thumbnailsTask(with: url) { thumbnails, response, error in
    //     if let thumbnails = thumbnails {
    //       ...
    //     }
    //   }
    //   task.resume()

    // MARK: - Thumbnails
    class Thumbnails: Codable {
        let thumbnailsDefault, medium, high: Default

        enum CodingKeys: String, CodingKey {
            case thumbnailsDefault = "default"
            case medium, high
        }

        init(thumbnailsDefault: Default, medium: Default, high: Default) {
            self.thumbnailsDefault = thumbnailsDefault
            self.medium = medium
            self.high = high
        }
    }

    //
    // To read values from URLs:
    //
    //   let task = URLSession.shared.defaultTask(with: url) { default, response, error in
    //     if let default = default {
    //       ...
    //     }
    //   }
    //   task.resume()

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

    func playlistListItemResponseTask(with url: URL, completionHandler: @escaping (PlaylistListItemResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
