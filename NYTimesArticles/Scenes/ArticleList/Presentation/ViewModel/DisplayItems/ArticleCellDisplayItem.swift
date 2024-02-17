//
//  ArticleCellDisplayItem.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import Foundation

final class ArticleCellDisplayItem {
    
    let title: String?
    let author: String?
    let publishDate: String?
    var thumbnail: String?
    
    init(article: Article) {
        self.title = article.title
        self.author = article.byline
        self.publishDate = article.published_date
        
        if let media = article.media {
            if media.count > 0 {
                if let mediaMetaData =  media[0].mediaMetadata {
                    if mediaMetaData.count > 0 {
                        self.thumbnail = mediaMetaData[0].url
                    }
                }
            }
        }
    }
}
