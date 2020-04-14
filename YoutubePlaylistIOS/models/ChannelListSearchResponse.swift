//
//  ChannelListSearchResponse.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/13/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let channelSearchListResponse = try? newJSONDecoder().decode(ChannelSearchListResponse.self, from: jsonData)

//
// To read values from URLs:
//
//   let task = URLSession.shared.channelSearchListResponseTask(with: url) { channelSearchListResponse, response, error in
//     if let channelSearchListResponse = channelSearchListResponse {
//       ...
//     }
//   }
//   task.resume()

import Foundation

// MARK: - ChannelSearchListResponse
class ChannelSearchListResponse: Codable {
    let kind, etag, nextPageToken, regionCode: String
    let pageInfo: PageInfo
    let items: [Item]

    init(kind: String, etag: String, nextPageToken: String, regionCode: String, pageInfo: PageInfo, items: [Item]) {
        self.kind = kind
        self.etag = etag
        self.nextPageToken = nextPageToken
        self.regionCode = regionCode
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
        let kind, etag: String
        let id: ID
        let snippet: Snippet

        init(kind: String, etag: String, id: ID, snippet: Snippet) {
            self.kind = kind
            self.etag = etag
            self.id = id
            self.snippet = snippet
        }
    }

    //
    // To read values from URLs:
    //
    //   let task = URLSession.shared.iDTask(with: url) { iD, response, error in
    //     if let iD = iD {
    //       ...
    //     }
    //   }
    //   task.resume()

    // MARK: - ID
    class ID: Codable {
        let kind, channelID: String

        enum CodingKeys: String, CodingKey {
            case kind
            case channelID = "channelId"
        }

        init(kind: String, channelID: String) {
            self.kind = kind
            self.channelID = channelID
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
        let channelTitle, liveBroadcastContent: String

        enum CodingKeys: String, CodingKey {
            case publishedAt
            case channelID = "channelId"
            case title
            case snippetDescription = "description"
            case thumbnails, channelTitle, liveBroadcastContent
        }

        init(publishedAt: String, channelID: String, title: String, snippetDescription: String, thumbnails: Thumbnails, channelTitle: String, liveBroadcastContent: String) {
            self.publishedAt = publishedAt
            self.channelID = channelID
            self.title = title
            self.snippetDescription = snippetDescription
            self.thumbnails = thumbnails
            self.channelTitle = channelTitle
            self.liveBroadcastContent = liveBroadcastContent
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

        init(url: String) {
            self.url = url
        }
    }

    //
    // To read values from URLs:
    //
    //   let task = URLSession.shared.pageInfoTask(with: url) { pageInfo, response, error in
    //     if let pageInfo = pageInfo {
    //       ...
    //     }
    //   }
    //   task.resume()

    // MARK: - PageInfo
    class PageInfo: Codable {
        let totalResults, resultsPerPage: Int

        init(totalResults: Int, resultsPerPage: Int) {
            self.totalResults = totalResults
            self.resultsPerPage = resultsPerPage
        }
    }
    
}

// MARK: - Helper functions for creating encoders and decoders

func newJSONDecoder() -> JSONDecoder {
    let decoder = JSONDecoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        decoder.dateDecodingStrategy = .iso8601
    }
    return decoder
}

func newJSONEncoder() -> JSONEncoder {
    let encoder = JSONEncoder()
    if #available(iOS 10.0, OSX 10.12, tvOS 10.0, watchOS 3.0, *) {
        encoder.dateEncodingStrategy = .iso8601
    }
    return encoder
}

// MARK: - URLSession response handlers

extension URLSession {
    func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            do {
                   let youtubeError = try newJSONDecoder().decode(YoutubeError.self, from: data)
                print(youtubeError.error.message)
                completionHandler(nil, response, error)


            }catch{
                print("No Youtube errors")
            }
            completionHandler(try? newJSONDecoder().decode(T.self, from: data), response, nil)
        }
    }

    func channelSearchListResponseTask(with url: URL, completionHandler: @escaping (ChannelSearchListResponse?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
