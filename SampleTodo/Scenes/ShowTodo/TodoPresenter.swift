//
//  TodoPresenter.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/17/20.
//

import Foundation

protocol ShowTodoPresentationLogic {
    func presentTodo(todos: [TodoModel])
}

class ShowTodoPresenter: ShowTodoPresentationLogic {
    var showTodo: ShowTodoDisplayLogic?
    func presentTodo(todos: [TodoModel]) {
        showTodo?.displayTodos(todos: todos)
    }
}
