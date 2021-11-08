//
//  PersistenceController.swift
//  Cats
//
//  Created by Andrey on 7.11.21.
//

import Foundation
import CoreData

struct PersistenceController {
  
  static let shared = PersistenceController()
  
  let container: NSPersistentContainer
  
  init() {
    container = NSPersistentContainer(name: "CoreDataModelCats")
    container.loadPersistentStores { (description, error) in
      if let error = error {
        fatalError(error.localizedDescription)
      }
    }
  }
  
  func save(completion: @escaping (Error?) -> () = {_ in}){
    let context = container.viewContext
    if context.hasChanges {
      do {
        try context.save()
      } catch {
        completion(error)
      }
    }
  }
  
  func delete(_ object: NSManagedObject, completion: @escaping (Error?) -> () = {_ in}) {
    let context = container.viewContext
    context.delete(object)
    save(completion: completion)
  }
  
}
