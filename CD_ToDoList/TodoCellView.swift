//  TodoCellView.swift
//  CD_ToDoList
//  Created by Miguel Gallego on 18/3/25.
import SwiftUI

struct TodoCellView: View {
    let todoItem: CDTodoItem
    let onChanged: (CDTodoItem) -> ()
    
    var body: some View {
        HStack {
            Image(systemName: todoItem.isCompleted ? "checkmark.square" : "square")
                .onTapGesture {
                    todoItem.isCompleted.toggle()
                    onChanged(todoItem)
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
                    onChanged(todoItem)
                }
            }
        }
    }
}

// TODO: poner esto en Preview Content folder
private var todoItem: CDTodoItem = {
    let item =  CDTodoItem(context: CDProvider.previewInstance.moc)
    item.title = "Pedir una pizza"
    item.isCompleted = false
    return item
}()

#Preview {
    TodoCellView(todoItem: todoItem,
                 onChanged: {_ in })
}
