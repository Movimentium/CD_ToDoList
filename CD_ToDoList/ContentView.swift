//  ContentView.swift
//  CD_ToDoList
//  Created by Miguel Gallego on 17/3/25.
import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) private var moc
    @FetchRequest(sortDescriptors: []) private var todoItems: FetchedResults<CDTodoItem>
    @State private var title: String = ""
    

    var body: some View {
        NavigationStack {
            VStack {
                TextField("Title", text: $title)
                    .textFieldStyle(.roundedBorder)
                    .onSubmit {
                        if isFormValid {
                            saveTodoItem(title: title)
                            title = ""
                        }
                    }
                List {
                    Section("Pending") {
                        ForEach(pendingTodoItems) { todoItem in
                            Text(todoItem.title ?? "")
                        }
                    }
                    Section("Completed") {
                        ForEach(completedTodoItems) { todoItem in
                            Text(todoItem.title ?? "")
                        }
                    }
                }
                .listStyle(.plain)
                Spacer()
            }
            .padding()
            .navigationTitle("To Do List")
        }
    }
    
    
    // MARK: - Logic
    private var isFormValid: Bool {
        !title.isEmptyOrWhiteSpace
    }
    
    private func saveTodoItem(title: String) {
        let todoItem = CDTodoItem(context: moc)
        todoItem.title = title
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
    
    private var pendingTodoItems: [CDTodoItem] {
        todoItems.filter { !$0.isCompleted }
    }
    
    private var completedTodoItems: [CDTodoItem] {
        todoItems.filter { $0.isCompleted }
    }

}

#Preview {
    ContentView()
        .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
}
