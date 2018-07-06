//
//  ArticleListModuleAssembly.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation
import UIKit

struct ArticleListModuleAssembly {
    
    static func assemble(viewController: ArticleListViewController) {
        
        let service = ServiceAssembly.assembleArticleService()
        let viewModel = ArticleListViewModelImpl(service: service)
        
        viewController.viewModel = viewModel
    }
}


