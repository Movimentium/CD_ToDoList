//  CD_ToDoListApp.swift
//  CD_ToDoList
//  Created by Miguel Gallego on 17/3/25.
import SwiftUI

@main
struct CD_ToDoListApp: App {
    
    let provider = CDProvider()
    
    var body: some Scene {
        WindowGroup {
            TodoListView()
                .environment(\.managedObjectContext, provider.moc)
        }
    }
}
