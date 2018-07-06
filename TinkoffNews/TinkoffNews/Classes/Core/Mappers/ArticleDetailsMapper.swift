//
//  ArticleDetailsMapper.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 05.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

class ArticleDetailsMapper: Mapper<ArticleDetails> {
    
    let responseKey = "response"
    let textKey = "text"
    let slugKey = "slug"

    override func map(json: [String: AnyObject]) -> [ArticleDetails]? {
        if
            let response = json[responseKey] as? [String: AnyObject],
            let text = response[textKey] as? String,
            let slug = response[slugKey] as? String
        {
            let details = ArticleDetails(identifier: slug, text: text)
            return [details]
        }
        return nil
    }
}
