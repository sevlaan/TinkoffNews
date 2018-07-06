//
//  NetworkResponseValidatorImpl.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 01.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation

enum ServerDataValidationError: Error {
    case serializationError
    case serverError(message: String)
}

class ServerResponseValidator: Validator<Data, JSON> {
    
    let errorKey = "error"
    let errorMessageKey = "message"
    
    override func validate(_ data: Data) throws -> JSON {
        var json: [String: AnyObject]?
        
        do {
            let jsonObj = try JSONSerialization.jsonObject(with: data, options: [])
            guard let jsonDict = jsonObj as? [String: AnyObject] else {
                throw ServerDataValidationError.serializationError
            }
            if
                let error = jsonDict[errorKey],
                let message = error[errorMessageKey] as? String
            {
                throw ServerDataValidationError.serverError(message: message)
            }
            json = jsonDict
        } catch {
            throw ServerDataValidationError.serializationError
        }
        
        return json!
    }
}


