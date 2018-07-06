//
//  NetworkResponseValidator.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 01.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import Foundation

class Validator<Input: Any, Output: Any> {
    
    func validate(_ data: Input) throws -> Output {
        assert(false, "Validator is abstract class")
    }
}

