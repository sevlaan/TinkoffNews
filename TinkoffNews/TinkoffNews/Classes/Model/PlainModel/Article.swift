//
//  Article.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

class Article: Entity {
    
    let title: String
    let createdTime: String
    let slug: String
    var viewsCount: Int
    
    init(
        identifier: String,
        title: String,
        createdTime: String,
        slug: String,
        viewsCount: Int = 0
        ) {
        self.title = title
        self.createdTime = createdTime
        self.slug = slug
        self.viewsCount = viewsCount
        
        super.init(identifier: identifier)
    }
    
    required init() {
        self.title = ""
        self.createdTime = ""
        self.slug = ""
        self.viewsCount = 0
        
        super.init(identifier: "")
    }
}
