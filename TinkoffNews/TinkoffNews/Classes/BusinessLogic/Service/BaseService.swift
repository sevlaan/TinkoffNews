//
//  BaseService.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 05.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation

enum ServiceError: Error {
    case connectionError
    case serverError(message: String?)
}

class BaseService {
    
    let operationQueue: OperationQueue
    let completionQueue: OperationQueue
    
    let baseUrlString: String = "https://cfg.tinkoff.ru/news/public/api/platform/v1"
    
    init(
        operationQueue: OperationQueue = OperationQueue(),
        completionQueue: OperationQueue = OperationQueue.main
        ) {
        self.operationQueue = operationQueue
        self.completionQueue = completionQueue
    }
}
