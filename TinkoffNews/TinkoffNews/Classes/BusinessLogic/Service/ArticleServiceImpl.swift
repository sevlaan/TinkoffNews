//
//  ArticleServiceImpl.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 30.06.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation

class ArticleServiceImpl: BaseService, ArticleService {
    
    private let networkClient: NetworkClient
    private let validator: Validator<Data,JSON>
    private let mapper: Mapper<Article>
    private let storage: Storage<Article>
    
    private let endPoint: String = "getArticles"
    private let maxCacheSize: Int = 20
    
    init(
        networkClient: NetworkClient,
        validator: Validator<Data,JSON>,
        mapper: Mapper<Article>,
        storage: Storage<Article>
        ) {
        self.networkClient = networkClient
        self.validator = validator
        self.mapper = mapper
        self.storage = storage
        
        super.init()
    }
    
    func getArticles(pagination: Pagination, completion: @escaping ArticleServiceCompletion) {
        
        operationQueue.addOperation { [weak self] in
            guard let `self` = self else { return }
            
            var responseData: Data?
            var responseError: Error?
            let semaphore = DispatchSemaphore(value: 0)
            
            let url: URL = self.requestUrl(pagination: pagination)
            
            self.networkClient.makeRequest(url: url, httpMethod: .get) { (data: Data?, error: Error?) in
                responseData = data
                responseError = error
                semaphore.signal()
            }
            semaphore.wait()
            
            guard
                let data = responseData,
                responseError == nil
            else {
                self.invokeCompletionAfterFailedRequest(completion, error: .connectionError)
                return
            }
            
            var json: JSON?
            do {
                json = try self.validator.validate(data)
            }
            catch ServerDataValidationError.serverError(let message) {
                self.invokeCompletionAfterFailedRequest(completion, error: .serverError(message: message))
                return
            }
            catch {
                self.invokeCompletionAfterFailedRequest(completion, error: .serverError(message: nil))
                return
            }
            
            guard
                let jsonObj = json,
                var articleList = self.mapper.map(json: jsonObj)
            else {
                self.invokeCompletionAfterFailedRequest(completion, error: .serverError(message: nil))
                return
            }
            articleList = self.sortedArticlesByDate(articles: articleList)
            
            self.storage.save(articleList, completion: {
                self.completionQueue.addOperation {
                    completion(articleList, nil)
                }
            })
        }
    }
    
    func getCachedArticles() -> [Article]? {
        var articles = storage.readAll()
        articles = sortedArticlesByDate(articles: articles)
        
        return articles
    }
    
    func updateCachedArticle(_ article: Article) {
        storage.save(article)
    }
    
    //MARK: Helpers
    
    private func requestUrl(pagination: Pagination) -> URL {
        let queryParams = [
            "pageOffset": String(pagination.offset),
            "pageSize": String(pagination.limit),
        ]
        return UrlBuilder.generateUrl(urlString: (baseUrlString + "/" + endPoint), queryParameters: queryParams)!
    }
    
    private func invokeCompletionAfterFailedRequest(_ completion: @escaping ArticleServiceCompletion, error: ServiceError) {
        self.completionQueue.addOperation {
            completion(nil, error)
        }
    }
    
    private func sortedArticlesByDate(articles: [Article]) -> [Article] {
        let sortedArticles = articles.sorted(by: { (lhs: Article, rhs: Article) -> Bool in
            guard
                let lhsDate = lhs.createdTime.date,
                let rhsDate = rhs.createdTime.date
            else {
                    return false
            }
            return lhsDate.compare(rhsDate) == .orderedDescending
        })
        return sortedArticles
    }
}

extension String {
    var date: Date? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        let date = dateFormatter.date(from: self)
        return date
    }
}
