//
//  ArticleDetailsServiceImpl.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 04.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation

class ArticleDetailsServiceImpl: BaseService, ArticleDetailsService {
    
    private let networkClient: NetworkClient
    private let validator: Validator<Data,JSON>
    private let mapper: Mapper<ArticleDetails>
    private let storage: Storage<ArticleDetails>
    
    private let endPoint: String = "getArticle"
    private let queryKey: String = "urlSlug"
    
    init(
        networkClient: NetworkClient,
        validator: Validator<Data,JSON>,
        mapper: Mapper<ArticleDetails>,
        storage: Storage<ArticleDetails>
        ) {
        self.networkClient = networkClient
        self.validator = validator
        self.mapper = mapper
        self.storage = storage
        
        super.init()
    }
    
    func getCachedArticleDetails(_ identifier: String) -> ArticleDetails? {
        return storage.read(identifier)
    }
    
    func getArticleDetails(_ identifier: String, completion: @escaping ArticleDetailsServiceCompletion) {
        
        operationQueue.addOperation { [weak self] in
            guard let `self` = self else { return }
            
            var responseData: Data?
            var responseError: Error?
            let semaphore = DispatchSemaphore(value: 0)
            
            let url: URL = self.requestUrl(id: identifier)
            
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
                let articleDetails = self.mapper.map(json: jsonObj)?.first
                else {
                    self.invokeCompletionAfterFailedRequest(completion, error: .serverError(message: nil))
                    return
            }
            
            self.storage.save(articleDetails)
            
            self.completionQueue.addOperation {
                completion(articleDetails, nil)
            }
        }
    }
    
    //MARK: Helpers
    
    func requestUrl(id: String) -> URL {
        let urlString = baseUrlString + "/" + endPoint
        let url: URL = UrlBuilder.generateUrl(urlString: urlString, queryParameters: [queryKey: id])!
        return url
    }
    
    private func invokeCompletionAfterFailedRequest(_ completion: @escaping ArticleDetailsServiceCompletion, error: ServiceError) {
        self.completionQueue.addOperation {
            completion(nil, error)
        }
    }
}
