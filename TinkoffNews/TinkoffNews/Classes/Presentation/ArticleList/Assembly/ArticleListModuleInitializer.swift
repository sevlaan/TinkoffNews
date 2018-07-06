//
//  ArticleListModuleInitializer.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 29.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation

class ArticleListModuleInitializer: NSObject {
    
    @IBOutlet weak var viewController: ArticleListViewController!
    
    override func awakeFromNib() {
        ArticleListModuleAssembly.assemble(viewController: viewController)
    }
}
