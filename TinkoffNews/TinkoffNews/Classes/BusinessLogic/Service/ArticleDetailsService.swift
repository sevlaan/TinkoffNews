//
//  ArticleDetailsService.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 04.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

typealias ArticleDetailsServiceCompletion = (_ articleDetails: ArticleDetails?, _ error: ServiceError?) -> ()

protocol ArticleDetailsService {
    
    func getCachedArticleDetails(_ identifier: String) -> ArticleDetails?
    
    func getArticleDetails(_ identifier: String, completion: @escaping ArticleDetailsServiceCompletion)
}
