//
//  ArticleListViewModelImpl.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation

class ArticleListViewModelImpl: ArticleListViewModel {
    
    var onLoadingStatusUpdate: LoadingEvent?
    var onErrorRecieve: ErrorEvent?
    var onItemsUpdate: Event?
    
    private let service: ArticleService
    private var articles = [Article]()
    
    var currentPageOffset: Int = 0
    let pageSize: Int = 20
    
    private var isLoading: Bool = false {
        didSet {
            self.onLoadingStatusUpdate?(isLoading)
        }
    }
    
    fileprivate var cellViewModels = [ArticleListCellViewModel]() {
        didSet {
            self.onItemsUpdate?()
        }
    }
    
    init(service: ArticleService) {
        self.service = service
    }
    
    func initLoading() {
        if let cachedArticles = service.getCachedArticles() {
            self.articles = cachedArticles
            cellViewModels = ArticleListCellViewModelFactory.generateCellViewModels(articles: cachedArticles)
        } else {
            isLoading = true
        }
        loadArticles()
    }
    
    func updateArticles() {
        currentPageOffset = 0
        loadArticles()
    }
    
    func loadNextArticlesBatch() {
        loadArticles()
    }
    
    func getDetailsIdentifier(_ row: Int) -> String {
        let selectedArticle: Article = articles[row]
        return selectedArticle.slug
    }
    
    func detailsSuccessPresenting(_ row: Int) {
        let selectedArticle: Article = articles[row]
        selectedArticle.viewsCount += 1
        cellViewModels[row].viewsCount += 1
        service.updateCachedArticle(selectedArticle)
    }
    
    //MARK: Private
    
    private func loadArticles() {
        let pagination = Pagination(offset: currentPageOffset, limit: pageSize)
        service.getArticles(pagination: pagination) { [weak self] (articles: [Article]?, error: ServiceError?) in
            guard let `self` = self else { return }
            self.isLoading = false
            if let e = error {
                self.onErrorRecieve?(e)
                return
            }
            if let articleList = articles {
                if self.currentPageOffset == 0 {
                    self.articles.removeAll() // очищаем кэш
                }
                self.currentPageOffset += self.pageSize
                self.articles.append(contentsOf: articleList)
                self.cellViewModels = ArticleListCellViewModelFactory.generateCellViewModels(articles: self.articles)
            }
        }
    }
}

extension ArticleListViewModelImpl: TableDataSource {
    
    func getCellViewModel(at row: Int) -> CellViewModel {
        return cellViewModels[row]
    }
    
    func getRowsCount() -> Int {
        return cellViewModels.count
    }
}
