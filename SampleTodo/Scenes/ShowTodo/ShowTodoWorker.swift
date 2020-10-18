//
//  ShowTodoWorker.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/18/20.
//

import RealmSwift

protocol GetTodoProtocol {
    func fetchTodo() -> [TodoModel]
}

class ShowTodoWorker: GetTodoProtocol {
    let realm = try? Realm()
    func fetchTodo() -> [TodoModel] {
        guard let arrayOfTodos =  { realm?.objects(TodoModel.self) }() else { return [TodoModel]() }
        return Array(arrayOfTodos)
    }
}
