//
//  CDArticleDetails+CoreDataProperties.swift
//  TinkoffNews
//
//  Created by Всеволод Беспалов on 06.07.2018.
//  Copyright © 2018 Всеволод Беспалов. All rights reserved.
//
//

import Foundation
import CoreData


extension CDArticleDetails {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDArticleDetails> {
        return NSFetchRequest<CDArticleDetails>(entityName: "CDArticleDetails")
    }

    @NSManaged public var text: String?

}
