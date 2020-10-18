//
//  AddTodoWorker.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/18/20.
//

import RealmSwift

protocol AddTodoProtocol {
    func addTodo(title: String, description: String)
}

class AddTodoWorkerClass: AddTodoProtocol {
    let realm = try? Realm()
    let todo = TodoModel()
    func addTodo(title: String, description: String) {
        todo.title = title
        todo.todoDescription = description
        try? realm?.write {
            realm?.add(todo)
        }
    }
}
