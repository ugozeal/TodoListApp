//
//  TodoListViewController.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/16/20.
//

import UIKit

class TodoListViewController: UITableViewController, ShowTodoDisplayLogic {
    var arrayOfTodos: [TodoModel]?
    var interactor: ShowTodoBusinessLogic?

    func displayTodos(todos: [TodoModel]) {
        arrayOfTodos = todos
        reloadTodo()
    }

    override func viewWillAppear(_ animated: Bool) {
        reloadTodo()
        interactor?.getTodo()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
        setNavigation()
        reloadTodo()
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: StringConstants.cellId)
    }

    func setUp() {
        let presenter = ShowTodoPresenter()
        let interactor = ShowTodoInteractor()
        let worker = ShowTodoWorker()
        presenter.showTodo = self
        interactor.presenter = presenter
        interactor.todoWorker = worker
        self.interactor = interactor
        
        let deleteWorker = DeleteTaskWorker()
        interactor.deleteWorker = deleteWorker
    }

    func setNavigation() {
        navigationItem.title = StringConstants.todoListScreenTitle
        let addTodoButton = UIButton(type: .custom)
        addTodoButton.setTitle( StringConstants.addButtonText, for: .normal)
        addTodoButton.setTitleColor(.black, for: .normal)
        addTodoButton.addTarget(self, action: #selector(addTodo), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addTodoButton)
    }

    func reloadTodo() {
        tableView?.reloadData()
    }

    @objc func addTodo() {
        let addTodoScreen = AddTodoViewController()
        navigationController?.pushViewController(addTodoScreen, animated: true)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayOfTodos?.count ?? 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let todoCell = tableView.dequeueReusableCell(withIdentifier: StringConstants.cellId) else { return UITableViewCell() }
        guard let todos = arrayOfTodos?[indexPath.row] else { return UITableViewCell() }
        todoCell.textLabel?.text = todos.title
        let isDone = UIImage(systemName: StringConstants.checkMark, withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        let notDone = UIImage(systemName: StringConstants.notDone, withConfiguration: UIImage.SymbolConfiguration(weight: .regular))?.withTintColor(.black, renderingMode: .alwaysOriginal)
        if todos.isDone{
            todoCell.accessoryView = UIImageView(image: isDone)
        } else {
            todoCell.accessoryView = UIImageView(image: notDone)
        }
        return todoCell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let todoDetailViewController = DisplayTodoViewController()
        navigationController?.pushViewController(todoDetailViewController, animated: true)
        let selectedTodo = arrayOfTodos?[indexPath.row]
        todoDetailViewController.currentTodo = selectedTodo
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            guard let todo = arrayOfTodos?[indexPath.row] else { return }
            interactor?.deleteTask(todos: [todo])
            interactor?.getTodo()
            reloadTodo()
        }
    }
    
}
