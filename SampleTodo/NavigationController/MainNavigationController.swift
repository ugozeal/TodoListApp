//
//  MainNavigationController.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/16/20.
//

import UIKit

class MainNavigationController: UINavigationController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        let listTodoViewController = TodoListViewController()
        viewControllers = [listTodoViewController]
    }
}
