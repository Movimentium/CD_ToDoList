//  CDProvider_Extension.swift
//  CD_ToDoList
//  Created by Miguel Gallego on 18/3/25.
import Foundation

extension CDProvider {
    static let previewInstance: CDProvider = {
        let provider = CDProvider(isForPreview: true)
        for i in 1..<10 {
            let todoItem = CDTodoItem(context: provider.moc)
            todoItem.title = "Todo item \(i)"
            todoItem.isCompleted = i.isMultiple(of: 2)
        }
        
        do {
            try provider.moc.save()
        } catch {
            print(#function, error)
        }
        // Alternative: try? provider.moc.safe
        
        return provider
    }()
    
    static var todoItemTest: CDTodoItem = {
        let moc = CDProvider.previewInstance.moc
        let item = CDTodoItem(context: moc)
        item.title = "Pedir una pizza"
        item.isCompleted = true
        return item
    }()
}
