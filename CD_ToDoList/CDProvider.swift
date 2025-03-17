//  CDProvider.swift
//  CD_ToDoList
//  Created by Miguel Gallego on 18/3/25.
import Foundation
import CoreData

class CDProvider {
    let pc = NSPersistentContainer(name: "CDModel")
    
    var moc: NSManagedObjectContext {
        pc.viewContext
    }
    
    init(isForPreview: Bool = false) {
        print(Self.self, #function)
        
        if isForPreview {
            pc.persistentStoreDescriptions.first?.url = URL(fileURLWithPath: "/dev/null")
        }
        print("pc.persistentStoreDescriptions.first?.url?.absoluteString: ")
        print(pc.persistentStoreDescriptions.first?.url?.absoluteString ?? "nil")

        pc.loadPersistentStores { _, error in
            if let error {
                fatalError("Core Data store failed to initialize: \(error)")
            }
        }
    }
    
    // MARK: - For Preview
    
    static var previewInstance: CDProvider = {
        let provider = CDProvider(isForPreview: true)
        for i in 1..<10 {
            let todoItem = CDTodoItem(context: provider.moc)
            todoItem.title = "Todo item \(i)"
        }
        
        do {
            try provider.moc.save()
        } catch {
            print(#function, error)
        }
        // Alternative: try? provider.moc.safe
        
        return provider
    }()
}
