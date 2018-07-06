//
//  ArticleDetails.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

class ArticleDetails: Entity {
    
    let text: String
    
    init(
        identifier: String,
        text: String
        ) {
        self.text = text
        
        super.init(identifier: identifier)
    }
    
    required init() {
        self.text = ""
        
        super.init(identifier: "")
    }
}
