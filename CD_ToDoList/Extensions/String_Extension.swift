//  String_Extension.swift
//  CD_ToDoList
//  Created by Miguel Gallego on 18/3/25.
import Foundation

extension String {
    var isEmptyOrWhiteSpace: Bool {
        return self.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
