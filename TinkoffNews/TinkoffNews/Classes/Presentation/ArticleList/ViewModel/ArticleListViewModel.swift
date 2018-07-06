//
//  ArticleListViewModel.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

protocol ArticleListViewModel: TableDataSource {
    
    func initLoading()
    
    var onLoadingStatusUpdate: LoadingEvent? { get set }
    var onErrorRecieve: ErrorEvent? { get set }
    var onItemsUpdate: Event? { get set }
    
    func updateArticles()
    func loadNextArticlesBatch()
    func getDetailsIdentifier(_ row: Int) -> String
    func detailsSuccessPresenting(_ row: Int)
}
