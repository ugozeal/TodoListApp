//
//  ShowTodoInteractor.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/17/20.
//

import Foundation
protocol ShowTodoBusinessLogic {
    func getTodo()
    func deleteTask(todos: [TodoModel])
}

class ShowTodoInteractor: ShowTodoBusinessLogic {
    var deleteWorker: DeleteTaskWorker?
    var presenter: ShowTodoPresentationLogic?
    var todoWorker: ShowTodoWorker?

    func deleteTask(todos: [TodoModel]) {
        deleteWorker?.deletedata(todos: todos)
    }

    func getTodo() {
        guard let todos = todoWorker?.fetchTodo() else { return }
        presenter?.presentTodo(todos: todos)
    }
}

protocol ShowTodoDisplayLogic {
    func displayTodos(todos: [TodoModel])
}
