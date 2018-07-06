//
//  ArticleDetailsModuleAssembly.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 05.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import UIKit

struct ArticleDetailsModuleAssembly {
    
    static func assemble(viewController: ArticleDetailsViewController) {
        
        let service = ServiceAssembly.assembleArticleDetailsService()
        viewController.service = service
    }
}
