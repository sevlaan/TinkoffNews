//
//  ServiceAssembly.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

struct ServiceAssembly {
    
    static func assembleArticleService() -> ArticleService {
        return ArticleServiceImpl(
            networkClient: NetworkClient(),
            validator: ServerResponseValidator(),
            mapper: ArticleMapper(),
            storage: CoreDataStorage(translator: ArticleTranslator())
        )
        
    }
    
    static func assembleArticleDetailsService() -> ArticleDetailsService {
        return ArticleDetailsServiceImpl(
            networkClient: NetworkClient(),
            validator: ServerResponseValidator(),
            mapper: ArticleDetailsMapper(),
            storage: CoreDataStorage(translator: ArticleDetailsTranslator())
        )
    }
}
