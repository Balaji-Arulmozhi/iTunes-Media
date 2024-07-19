//
//  iTunesDataModel.swift
//  iTunesMedia
//
//  Created by Kumararaja Krishnan on 7/17/24.
//

import Foundation


struct iTunesDataModel: Codable{
    var resultCount: Int?
    var results: [resultsDataModel]
}

struct resultsDataModel: Codable{
    var wrapperType: String?
    var kind: String?
    var collectionId: Int?
    var artistName: String?
    var previewUrl: String?
    var trackName: String?
    var artworkUrl60: String?
    var longDescription: String?
    var primaryGenreName: String?
    var artworkUrl100: String?
    var trackViewUrl: String?
}
