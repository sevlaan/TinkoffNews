//
//  CDArticle+CoreDataProperties.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 06.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//
//

import Foundation
import CoreData


extension CDArticle {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDArticle> {
        return NSFetchRequest<CDArticle>(entityName: "CDArticle")
    }

    @NSManaged public var createdTime: String?
    @NSManaged public var slug: String?
    @NSManaged public var title: String?
    @NSManaged public var viewsCount: Int16

}
