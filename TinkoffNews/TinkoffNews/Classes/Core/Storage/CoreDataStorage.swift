//
//  CoreDataStorage.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 04.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//

import CoreData

class CoreDataStorage<CDModel: CDEntity, Model: Entity>: Storage<Model> {
    
    private let persistentContainer: NSPersistentContainer
    private var context: NSManagedObjectContext {
        let context = Thread.isMainThread ?
            persistentContainer.viewContext :
            persistentContainer.newBackgroundContext()
        context.persistentStoreCoordinator = persistentContainer.persistentStoreCoordinator
        context.automaticallyMergesChangesFromParent = true
        return context
    }
    
    private let translator: CoreDataTranslator<Model, CDModel>
    
    init(translator: CoreDataTranslator<Model, CDModel>) {
        self.translator = translator
        let container = NSPersistentContainer(name: "TinkoffNews")
        container.loadPersistentStores { (storeDescription, error) in
            if let error = error {
                fatalError("Failed to load store: \(error)")
            }
        }
        self.persistentContainer = container
    }
    
    override func save(_ entity: Model) {
        let context = self.context
        if let existingEntries = try? context.fetch(self.request(entity.identifier)),
            let existingEntry = existingEntries.first {
            translator.fillEntry(existingEntry, fromEntity: entity)
        } else {
            guard let entry = NSEntityDescription.insertNewObject(forEntityName: translator.entryClassName, into: context) as? CDModel else {
                return
            }
            translator.fillEntry(entry, fromEntity: entity)
        }
        
        try? context.save()
    }
    
    override func save(_ entities: [Model], completion: @escaping () -> ()) {
        let context = self.context
        context.performAndWait { [weak self] in
            guard let `self` = self else { return }
            for entity in entities {
                if let existingEntries = try? context.fetch(self.request(entity.identifier)),
                    let existingEntry = existingEntries.first {
                    self.translator.fillEntry(existingEntry, fromEntity: entity)
                } else {
                    guard let entry = NSEntityDescription.insertNewObject(forEntityName: self.translator.entryClassName, into: context) as? CDModel else {
                        return
                    }
                    self.translator.fillEntry(entry, fromEntity: entity)
                }
            }
            
            do {
                try context.save()
            } catch {
                context.rollback()
            }
            completion()
        }
    }
    
    override func read(_ identifier: String) -> Model? {
        var entity: Model?
        let context = self.context
        context.performAndWait { [weak self] in
            guard
                let `self` = self,
                let entries = try? context.fetch(self.request(identifier)),
                let entry = entries.first
                else {
                    return
            }
            entity = self.translator.generateEntity(fromEntry: entry)
        } 
        return entity
    }
    
    override func readAll() -> [Model] {
        var entities = [Model]()
        let context = self.context
        context.performAndWait { [weak self]  in
            guard let `self` = self else { return }
            if let entries: [CDModel] = try? context.fetch(self.request()) {
                for entry in entries {
                    let entity = self.translator.generateEntity(fromEntry: entry)
                    entities.append(entity)
                }
            }
        }
        return entities 
    }
    
    override func delete(_ entityId: String) {
        //TODO:
    }
    
    override func deleteAll() {
        //TODO:
    }
    
    //MARK: Helpers
    
    private func request() -> NSFetchRequest<CDModel> {
        let request = NSFetchRequest<CDModel>(entityName: translator.entryClassName)
        
        return request
    }
    
    private func request(_ identifier: String) -> NSFetchRequest<CDModel> {
        let request = NSFetchRequest<CDModel>(entityName: translator.entryClassName)
        request.predicate = NSPredicate(format: "identifier == %@", argumentArray: [identifier])
        
        return request
    }
}
