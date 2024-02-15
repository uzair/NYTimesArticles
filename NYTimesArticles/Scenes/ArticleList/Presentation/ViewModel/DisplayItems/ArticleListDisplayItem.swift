//
//  ArticleListDisplayItem.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import Foundation

class ArticleListDisplayItem {
    
    let cellDisplayItems: [ArticleCellDisplayItem]?
    let title: String
    
    init (cellDisplayItems: [ArticleCellDisplayItem]?, title: String) {
        
        self.cellDisplayItems = cellDisplayItems
        self.title = title

                
    }
}
