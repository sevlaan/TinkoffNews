//
//  Storage.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 04.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import UIKit

class Storage<Model: Entity> {
    
    func save(_ entity: Model) {
        assert(false, "Storage is abstract class")
    }
    
    func save(_ entities: [Model], completion: @escaping () -> ()) {
        assert(false, "Storage is abstract class")
    }
    
    func read(_ identifier: String) -> Model? {
        assert(false, "Storage is abstract class")
    }
    
    func readAll() -> [Model] {
        assert(false, "Storage is abstract class")
    }
    
    func delete(_ entityId: String) {
        assert(false, "Storage is abstract class")
    }
    
    func deleteAll() {
        assert(false, "Storage is abstract class")
    }
}
