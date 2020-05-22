//
//  Photo+CoreDataProperties.swift
//  
//
//  Created by Judy on 2020/5/22.
//
//

import Foundation
import CoreData


extension Photo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Photo> {
        return NSFetchRequest<Photo>(entityName: "Photo")
    }

    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var imageURL: String?

}
