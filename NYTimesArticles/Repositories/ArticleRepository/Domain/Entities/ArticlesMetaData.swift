//
//  ArticlesMetaData.swift
//  NYTimesArticles
//
//  Created by Macbook on 14/02/2024.
//

import Foundation

struct ArticlesMetaData: Decodable {
    var status: String?
    var copyright: String?
    var num_results: Int?
    var results: [Article]?
    var eta_id: String?

}

struct Article: Decodable {
    
    var uri: String?
    var url: String?
    var id: Int?
    var asset_id: Int?
    var source: String?
    var published_date: String?
    var updated: String?
    var section: String?
    var subsection: String?
    var nytdsection: String?
    var adx_keywords: String?
    var column: String?
    var byline: String?
    var type: String?
    var title: String?
    var abstract: String?
    var des_facet: [String]?
    var org_facet: [String]?
    var per_facet: [String]?
    var geo_facet: [String]?
    var media: [Media]?
}

struct Media: Decodable {
    
    var type: String?
    var subtype: String?
    var caption: String?
    var copyright: String?
    var approvedForSyndication: Int?
    var mediaMetadata:[MediaMetaData]?
    
    enum CodingKeys: String, CodingKey {
        case type, subtype, caption, copyright
        case approvedForSyndication = "approved_for_syndication"
        case mediaMetadata = "media-metadata"
    }
}

struct MediaMetaData: Decodable {
    
    var url: String?
    var format: String?
    var height: Int?
    var width: Int?
    
}
