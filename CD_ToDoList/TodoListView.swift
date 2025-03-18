//  TodoListView.swift
//  CD_ToDoList
//  Created by Miguel Gallego on 17/3/25.
import SwiftUI

struct TodoListView: View {
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
                        if pendingTodoItems.isEmpty {
                            ContentUnavailableView("No items", systemImage: "doc")
                        } else {
                            ForEach(pendingTodoItems) { todoItem in
                                TodoCellView(todoItem: todoItem, onChanged: update(todoItem:))
                            }
                            .onDelete(perform: { indexSet in
                                indexSet.forEach { idx in
                                    print("Pending idx:", idx)
                                    let todoItem = pendingTodoItems[idx]
                                    delete(todoItem: todoItem)
                                }
                            })
                        }
                    }
                    Section("Completed") {
                        if completedTodoItems.isEmpty {
                            ContentUnavailableView("No items", systemImage: "doc")
                        } else {
                            ForEach(completedTodoItems) { todoItem in
                                TodoCellView(todoItem: todoItem, onChanged: update(todoItem:))
                            }
                            .onDelete(perform: { indexSet in
                                indexSet.forEach { idx in
                                    print("Completed idx:", idx)
                                    let todoItem = completedTodoItems[idx]
                                    delete(todoItem: todoItem)
                                }
                            })
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

    private func update(todoItem: CDTodoItem) {
        save()
    }
    
    private func delete(todoItem: CDTodoItem) {
        moc.delete(todoItem)
        save()
    }
    
    private func save() {
        do {
            try moc.save()
        } catch {
            print(error)
        }
    }
}

#Preview {
    TodoListView()
        .environment(\.managedObjectContext, CDProvider.previewInstance.moc)
}
