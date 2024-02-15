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
    var num_results: String?
    var results: [Article]?
    var eta_id: String?

}

struct Article: Decodable {
    
    var uri: String?
    var url: String?
    var id: String?
    var asset_id: String?
    var source: String?
    var published: String?
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
    var approved_for_syndication: String?
    var media_metadata:[MediaMetaData]?
}

struct MediaMetaData: Decodable {
    
    var url: String?
    var format: String?
    var height: String?
    var width: String?
    
}
