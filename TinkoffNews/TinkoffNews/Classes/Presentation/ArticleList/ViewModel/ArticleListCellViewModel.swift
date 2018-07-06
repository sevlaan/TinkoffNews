//
//  ArticleListCellViewModel.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

struct ArticleListCellViewModel: CellViewModel {
    
    static var cellIdentifier = String(describing: ArticleListCell.self)
    
    var title: String
    var createdDate: String
    var viewsCount: Int
}
