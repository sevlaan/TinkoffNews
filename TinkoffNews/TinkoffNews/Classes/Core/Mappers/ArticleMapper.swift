//
//  ArticleMapper.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 02.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

class ArticleMapper: Mapper<Article> {
    
    let responseKey = "response"
    let newsKey = "news"
    let idKey = "id"
    let titleKey = "title"
    let createdTimeKey = "createdTime"
    let slugKey = "slug"
    
    override func map(json: [String: AnyObject]) -> [Article]? {
        var articles: [Article]?
        if
            let response = json[responseKey] as? [String: AnyObject],
            let news = response[newsKey] as? [[String: AnyObject]]
        {
            articles = [Article]()
            for articleJson: [String: AnyObject] in news {
                if let article = mapArticle(json: articleJson) {
                    articles!.append(article)
                }
            }
        }
        return articles
    }
    
    func mapArticle(json: [String: AnyObject]) -> Article? {
        if
            let identifier = json[idKey] as? String,
            let title = json[titleKey] as? String,
            let createdTime = json[createdTimeKey] as? String,
            let slug = json[slugKey] as? String
        {
            return Article(
                identifier: identifier,
                title: title,
                createdTime: createdTime,
                slug: slug
            )
        }
        return nil
    }
}

