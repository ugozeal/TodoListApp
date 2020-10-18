//
//  DetailsScreenWorker.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/18/20.
//

import RealmSwift

protocol DisplayScreenLogic {
    func displayTodo(title: String, description: String, isDone: Bool, currentTodo: TodoModel)
}

class DetailsScreenWorker: DisplayScreenLogic {
    let realm = try? Realm()
    func displayTodo(title: String, description: String, isDone: Bool, currentTodo: TodoModel) {
        try? realm?.write {
            currentTodo.isDone = isDone
            currentTodo.title = title
            currentTodo.todoDescription = description
        }
    }
}
