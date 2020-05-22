//
//  CoreManager.swift
//  SearchPhotoDemo
//
//  Created by Judy on 2020/5/22.
//  Copyright © 2020 SuJustin. All rights reserved.
//

import Foundation
import CoreData

class CoreDataManager {
    static let shared = CoreDataManager()
    
    let identifier: String = "com.SuJustin.SearchPhotoDemo"
    let modelName: String = "CoreDataModel"
    
    lazy var persistentContainer: NSPersistentContainer = {
        let messageKitBundle = Bundle(identifier: self.identifier)
        let modelURL = messageKitBundle!.url(forResource: self.modelName, withExtension: "momd")!
        let managedObjectModel =  NSManagedObjectModel(contentsOf: modelURL)

        let container = NSPersistentContainer(name: self.modelName, managedObjectModel: managedObjectModel!)
        container.loadPersistentStores { (storeDescription, error) in
            if let err = error{
                fatalError("[Error] Loading of store failed:\(err)")
            }
        }
        return container
    }()
    
    private let entityName = "Photo"
    
    init() { }
    
    func createPhoto(id: String, title: String, imageURL: String){
        let context = persistentContainer.viewContext
        let contact = NSEntityDescription.insertNewObject(forEntityName: entityName, into: context) as! Photo
        
        contact.id = id
        contact.title = title
        contact.imageURL = imageURL
        saveContext()
    }
    
    func match() -> [Photo] {
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest = Photo.fetchRequest()
        
        do {
            let result = try context.fetch(fetchRequest)
            return result
        } catch {
            fatalError("[Error]CoreData Failed to match Person: \(error.localizedDescription)")
        }
    }
    
    func delete(with photo: PhotoCellViewModel) {
        let id = photo.id
        let context = persistentContainer.viewContext
        let fetchRequest: NSFetchRequest = Photo.fetchRequest()
        fetchRequest.predicate = NSPredicate(format: "id == %@", id)
        do {
            let result = try context.fetch(fetchRequest)
            for person in result {
                context.delete(person)
            }
        } catch {
            fatalError();
        }
        saveContext()
    }
    
    private func saveContext() {
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch {
            fatalError("[Error]CoreData Failed to Save Person:\n \(error.localizedDescription)")
        }
    }
}
