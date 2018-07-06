//
//  CDEntity+CoreDataProperties.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 06.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//
//

import Foundation
import CoreData


extension CDEntity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDEntity> {
        return NSFetchRequest<CDEntity>(entityName: "CDEntity")
    }

    @NSManaged public var identifier: String?

}
