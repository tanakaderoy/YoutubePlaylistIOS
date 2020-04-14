//
//  YoutubeError.swift
//  YoutubePlaylistIOS
//
//  Created by Tanaka Mazivanhanga on 4/14/20.
//  Copyright © 2020 Tanaka Mazivanhanga. All rights reserved.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let youtubeError = try? newJSONDecoder().decode(YoutubeError.self, from: jsonData)

import Foundation

// MARK: - YoutubeError
class YoutubeError: Codable {
    let error: YoutubeErrorError

    init(error: YoutubeErrorError) {
        self.error = error
    }
}

// MARK: - YoutubeErrorError
class YoutubeErrorError: Codable {
    let errors: [ErrorElement]
    let code: Int
    let message: String

    init(errors: [ErrorElement], code: Int, message: String) {
        self.errors = errors
        self.code = code
        self.message = message
    }
}

// MARK: - ErrorElement
class ErrorElement: Codable {
    let domain, reason, message: String

    init(domain: String, reason: String, message: String) {
        self.domain = domain
        self.reason = reason
        self.message = message
    }
}
