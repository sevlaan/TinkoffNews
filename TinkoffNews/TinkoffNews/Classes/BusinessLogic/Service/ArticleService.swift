//
//  ArticleService.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation

typealias ArticleServiceCompletion = (_ articles: [Article]?, _ error: ServiceError?) -> ()

protocol ArticleService {
    
    func getCachedArticles() -> [Article]?
    
    func getArticles(pagination: Pagination, completion: @escaping ArticleServiceCompletion)
    
    func updateCachedArticle(_ article: Article)
}

























