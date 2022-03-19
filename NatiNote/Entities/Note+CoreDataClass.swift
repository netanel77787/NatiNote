//
//  Note+CoreDataClass.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 19/03/2022.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {

    public override var description: String{
        "title \(title) content \(content) image \(image)"
    }
}
