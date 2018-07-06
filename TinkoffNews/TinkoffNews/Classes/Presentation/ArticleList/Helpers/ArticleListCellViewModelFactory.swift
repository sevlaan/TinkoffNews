//
//  ArticleListCellViewModelFactory.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 02.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

struct ArticleListCellViewModelFactory {
    
    static func generateCellViewModels(articles: [Article]) -> [ArticleListCellViewModel] {
        return articles.map {
            ArticleListCellViewModel(
                title: $0.title,
                createdDate: $0.createdTime,
                viewsCount: $0.viewsCount
            )
        }
    }
}
