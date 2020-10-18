//
//  DisplayTodoViewController.swift
//  SampleTodo
//  Created by David U. Okonkwo on 10/17/20.

import UIKit

class DisplayTodoViewController: UIViewController {
    var currentTodo: TodoModel?
    var displayTodoInteractor: DetailsScreenBusinessLogic?
    
    func setUpView() {
        let interactor = DetailsScreenInteractor()
        let worker = DetailsScreenWorker()
        interactor.displayTodo = worker
        self.displayTodoInteractor = interactor
    }
    
    func defaultTodo() {
        if let actualTodo = currentTodo {
            taskTitle.text = actualTodo.title
            taskDescription.text = actualTodo.todoDescription
            toggleButton.isOn = actualTodo.isDone
        }
    }

    lazy var taskTitle: UITextField = {
        let textLabel = UITextField()
        textLabel.textColor = .black
        textLabel.font = UIFont(name: StringConstants.fontFamily, size: 25)
        textLabel.textAlignment = .center
        textLabel.isEnabled = false
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
       }()

    func setNavigationBar() {
        let addButton = UIButton(type: .custom)
        addButton.setTitle(StringConstants.editButton, for: .normal)
        addButton.setTitleColor(.black, for: .normal)
        addButton.addTarget(self, action: #selector(editTodo), for: .touchUpInside)
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: addButton)
        self.navigationController?.navigationBar.tintColor = .black
    }

    @objc func editTodo() {
        toggleButton.isHidden = false
        saveTodoButton.isHidden = false
        taskDescription.isEditable = true
        taskTitle.isEnabled = true
    }

    lazy var toggleButton: UISwitch = {
        let switchOnOff = UISwitch(frame:CGRect(x: 150, y: 150, width: 0, height: 0))
        switchOnOff.setOn(true, animated: false)
        switchOnOff.translatesAutoresizingMaskIntoConstraints = false
        switchOnOff.tintColor = .red
        switchOnOff.onTintColor = .red
        switchOnOff.thumbTintColor = .white
        switchOnOff.isHidden = true
        return switchOnOff
    }()

    lazy var taskDescription: UITextView = {
        let textView = UITextView()
        textView.font = UIFont(name: StringConstants.fontFamily, size: 20)
        textView.textColor = .black
        textView.isEditable = false
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()

    lazy var saveTodoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(StringConstants.saveButtonText.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor =  #colorLiteral(red: 0.07057534903, green: 0.07059564441, blue: 0.07057406753, alpha: 1)
        button.layer.cornerRadius = 5
        button.isHidden = true
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(saveTask), for: .touchUpInside)
        return button
    }()

    @objc func saveTask() {
        displayTodoInteractor?.fetchTodo(title: taskTitle.text ?? "", description: taskDescription.text, isDone: toggleButton.isOn, newTodo: currentTodo ?? TodoModel())
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpView()
        setNavigationBar()
        layoutViews()
        defaultTodo()
    }

    func layoutViews() {
        view.addSubview(taskTitle)
        view.addSubview(taskDescription)
        view.addSubview(saveTodoButton)
        view.addSubview(toggleButton)
        setConstraints()
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            // set task description heading display constraints
            taskTitle.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            taskTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            taskTitle.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            // set task description display constraints
            taskDescription.topAnchor.constraint(equalTo: taskTitle.bottomAnchor, constant: 10),
            taskDescription.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            taskDescription.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            taskDescription.heightAnchor.constraint(equalToConstant: 300),
            // set save todo button constraints
            saveTodoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            saveTodoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            saveTodoButton.topAnchor.constraint(equalTo: toggleButton.bottomAnchor, constant: 20),
            saveTodoButton.heightAnchor.constraint(equalToConstant: 50),
            // set toggle button constraints
            toggleButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            toggleButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1),
            toggleButton.topAnchor.constraint(equalTo: taskDescription.bottomAnchor, constant: 30)
        ])
    }
}
