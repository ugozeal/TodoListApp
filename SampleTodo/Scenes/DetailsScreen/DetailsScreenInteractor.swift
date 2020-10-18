//
//  DetailsScreenInteractor.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/17/20.
//

import Foundation

protocol DetailsScreenBusinessLogic {
    func fetchTodo(title: String, description: String, isDone: Bool, newTodo: TodoModel)
}

class DetailsScreenInteractor: DetailsScreenBusinessLogic {
    var displayTodo: DetailsScreenWorker?
    func fetchTodo(title: String, description: String, isDone: Bool, newTodo: TodoModel) {
        displayTodo?.displayTodo(title: title, description: description, isDone: isDone, currentTodo: newTodo)
    }
}
