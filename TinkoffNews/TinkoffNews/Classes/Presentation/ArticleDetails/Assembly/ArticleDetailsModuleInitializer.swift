//
//  ArticleDetailsModuleInitializer.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 05.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import UIKit

class ArticleDetailsModuleInitializer: NSObject {
    
    @IBOutlet weak var viewController: ArticleDetailsViewController!
    
    override func awakeFromNib() {
        ArticleDetailsModuleAssembly.assemble(viewController: viewController)
    }
}
