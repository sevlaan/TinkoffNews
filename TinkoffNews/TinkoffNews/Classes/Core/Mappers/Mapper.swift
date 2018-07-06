//
//  ArticleMapper.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 02.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

class Mapper<Model: Entity> {
    
    func map(json: [String: AnyObject]) -> [Model]? {
        assert(false, "Mapper is abstract class")
    }
}
