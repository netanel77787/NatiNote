//
//  Note+CoreDataProperties.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 19/03/2022.
//
//

import Foundation
import CoreData


extension Note {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Note> {
        return NSFetchRequest<Note>(entityName: "Note")
    }

    @NSManaged public var content: String?
    @NSManaged public var image: Data?
    @NSManaged public var title: String?

}

extension Note : Identifiable {

}
