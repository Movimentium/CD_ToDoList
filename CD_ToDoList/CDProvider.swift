//  CDProvider.swift
//  CD_ToDoList
//  Created by Miguel Gallego on 18/3/25.
import Foundation
import SwiftUI
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
        
#if DEBUG
        addMocks()
#endif
    }
    
#if DEBUG
    private func addMocks() {
        @AppStorage("areMocksAdded") var areMocksAdded = false
        if areMocksAdded {
            return
        }
        
        let item0 = CDTodoItem(context: moc)
        item0.title = "Limpiar el coche"
        
        let item1 = CDTodoItem(context: moc)
        item1.title = "Cortar el cesped"

        let item2 = CDTodoItem(context: moc)
        item2.title = "Tirar la basura"
        
        let item3 = CDTodoItem(context: moc)
        item3.title = "Hacer la compra"
        
        try? moc.save()
        areMocksAdded = true 
    }
#endif

}
