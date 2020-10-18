//
//  DeleteTodoWorker.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/18/20.
//

import RealmSwift

protocol DeleteData {
    func deletedata(todos: [TodoModel])
}

class DeleteTaskWorker: DeleteData {
    let realm = try? Realm()
    func deletedata(todos: [TodoModel]) {
        try? realm?.write {
            realm?.delete(todos)
        }
    }
}
