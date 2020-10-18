//
//  AddTodoInteractor.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/17/20.
//

import UIKit

protocol AddTodoBusinessLogicPrime {
    func getTodo(title: String, description: String)
}

class AddTodoInteractor: AddTodoBusinessLogicPrime {
    var todoWorker: AddTodoWorkerClass?
    func getTodo(title: String, description: String) {
        todoWorker?.addTodo(title: title, description: description)
    }
}

