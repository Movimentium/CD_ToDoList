//  TodoCellView.swift
//  CD_ToDoList
//  Created by Miguel Gallego on 18/3/25.
import SwiftUI

struct TodoCellView: View {
    let todoItem: CDTodoItem
    let onChanged: () -> Void
    
    var body: some View {
        HStack {
            Image(systemName: todoItem.isCompleted ? "checkmark.square" : "square")
                .onTapGesture {
                    todoItem.isCompleted.toggle()
                    onChanged()
                }
            if todoItem.isCompleted {
                Text(todoItem.title ?? "")
            } else {
                TextField("", text: Binding(get: {  // ZTip
                    todoItem.title ?? ""
                }, set: { newValue in
                    todoItem.title = newValue
                }))
                .onSubmit {
                    onChanged()
                }
            }
        }
    }
}

#Preview {
    TodoCellView(todoItem: CDProvider.todoItemTest,
                 onChanged: { })
}
