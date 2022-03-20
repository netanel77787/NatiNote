//
//  NotesDAO.swift
//  NatiNote
//
//  Created by Netanel Mantsoor on 19/03/2022.
//

import Foundation
import CoreData

class NotesDAO{
    private init(){}
    
    static let shared = NotesDAO()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NatiNote")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func saveContext () {
        let context = context
        
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                showError(title: "Unable to use context")
            }
        }
        
    }
    
    var context: NSManagedObjectContext{
        persistentContainer.viewContext
    }
    
    func update(note: Note){
        saveContext()
    }
    
    func addNote(note: Note){
        saveContext()
    }

    func loadNotes()-> [Note]{
        let context = persistentContainer.viewContext

        let fetchRequest: NSFetchRequest<Note> = Note.fetchRequest()

        let notes = (try? context.fetch(fetchRequest)) ?? []

        return notes
    }
    

    func deleteAll(){
        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "Note")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try  context.execute(deleteRequest)
        } catch let err as NSError {
            showError(title: err.localizedDescription)
            // TODO: handle the error
        }
    }

    
    
    
}



extension NotesDAO: ShowHUD{
    
}
