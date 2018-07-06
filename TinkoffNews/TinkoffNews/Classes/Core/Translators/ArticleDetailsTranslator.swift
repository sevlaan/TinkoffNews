//
//  ArticleDetailsTranslator.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 06.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import UIKit

class ArticleDetailsTranslator: CoreDataTranslator<ArticleDetails, CDArticleDetails> {
    
    override func generateEntity(fromEntry: CDArticleDetails) -> ArticleDetails {
        guard
            let identifier = fromEntry.identifier,
            let text = fromEntry.text
            else {
                return ArticleDetails()
        }
        return ArticleDetails(
            identifier: identifier,
            text: text
        )
    }
    
    override func fillEntry(_ entry: CDArticleDetails, fromEntity: ArticleDetails) {
        entry.identifier = fromEntity.identifier
        entry.text = fromEntity.text
    }
}


