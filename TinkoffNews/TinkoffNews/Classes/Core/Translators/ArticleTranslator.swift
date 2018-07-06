//
//  ArticleTranslator.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 03.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//


class ArticleTranslator: CoreDataTranslator<Article, CDArticle> {
    
    override func generateEntity(fromEntry: CDArticle) -> Article {
        guard
            let identifier = fromEntry.identifier,
            let title = fromEntry.title,
            let createdTime = fromEntry.createdTime,
            let slug = fromEntry.slug
            else {
                return Article()
        }
        return Article(
            identifier: identifier,
            title: title,
            createdTime: createdTime,
            slug: slug,
            viewsCount: Int(fromEntry.viewsCount)
        )
    }
    
    override func fillEntry(_ entry: CDArticle, fromEntity: Article) {
        entry.identifier = fromEntity.identifier
        entry.title = fromEntity.title
        entry.createdTime = fromEntity.createdTime
        entry.slug = fromEntity.slug
        if fromEntity.viewsCount >= entry.viewsCount {
            entry.viewsCount = Int16(fromEntity.viewsCount)
        } else {
            fromEntity.viewsCount = Int(entry.viewsCount)
        }
    }
}
