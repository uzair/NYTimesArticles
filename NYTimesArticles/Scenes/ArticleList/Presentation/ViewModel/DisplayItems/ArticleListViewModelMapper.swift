//
//  ArticlesMetaDataViewModelMapper.swift
//  NYTimesArticles
//
//  Created by Macbook on 15/02/2024.
//

import Foundation

class ArticleListViewModelMapper: ArticleListViewModelMapperInterface {
    
    func listDisplayItem(articlesMetaData: ArticlesMetaData) -> ArticleListDisplayItem {
        
        let cellDisplayItems = cellDisplayItemsFor(articles: articlesMetaData.results)
        return ArticleListDisplayItem(cellDisplayItems: cellDisplayItems, title: "NY Times Most Popular")
    }
    
    func cellDisplayItemsFor(articles:[Article]?) -> [ArticleCellDisplayItem]? {
        let displayItems = articles?.compactMap { ArticleCellDisplayItem(article: $0)}
        return displayItems
        
    }
}
