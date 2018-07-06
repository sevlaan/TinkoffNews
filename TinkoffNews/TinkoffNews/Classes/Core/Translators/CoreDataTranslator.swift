//
//  CoreDataTranslator.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 04.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import UIKit

class CoreDataTranslator<Model: Entity, CDModel: CDEntity> {
    
    open var entryClassName: String {
        return NSStringFromClass(CDModel.self).components(separatedBy: ".").last!
    }
    
    func generateEntity(fromEntry: CDModel) -> Model {
        assert(false, "CoreDataTranslator is abstract class")
    }
    
    func fillEntry(_ entry: CDModel, fromEntity: Model) {
        assert(false, "CoreDataTranslator is abstract class")
    }
}
