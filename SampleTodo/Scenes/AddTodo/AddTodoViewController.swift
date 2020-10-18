//
//  AddTodoViewController.swift
//  SampleTodo
//  Created by David U. Okonkwo on 10/17/20.

import UIKit

class AddTodoViewController: UIViewController, UITextViewDelegate, UITextFieldDelegate {
    var addTodoItem: ShowTodoDisplayLogic?
    var addTodoLogic: AddTodoBusinessLogicPrime?
    
    func activateTodo() {
        let todoInteractor = AddTodoInteractor()
        let todoWorker = AddTodoWorkerClass()
        todoInteractor.todoWorker = todoWorker
        self.addTodoLogic = todoInteractor
    }
    
    lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = StringConstants.taskTitleText
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor = #colorLiteral(red: 0.9136453867, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
        textField.setLeftPaddingPoints(10)
        textField.setRightPaddingPoints(10)
        return textField
    }()

    lazy var descriptionTextField: UITextView = {
        let textField = UITextView()
        textField.textColor = .black
        textField.layer.borderWidth = 1
        textField.layer.cornerRadius = 5
        textField.layer.borderColor =  #colorLiteral(red: 0.9136453867, green: 0.9137768149, blue: 0.9136165977, alpha: 1)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()

    lazy var saveTodoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle(StringConstants.addButtonText.uppercased(), for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.backgroundColor =  #colorLiteral(red: 0.07057534903, green: 0.07059564441, blue: 0.07057406753, alpha: 1)
        button.layer.cornerRadius = 5
        button.setTitleColor(.white, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleAddTodoButton), for: .touchUpInside)
        return button
    }()

    @objc func handleAddTodoButton() {
        addTodoLogic?.getTodo(title: titleTextField.text ?? "", description: descriptionTextField.text)
        self.navigationController?.popViewController(animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationBar()
        layoutViews()
        activateTodo()
    }

    func setNavigationBar() {
        self.navigationController?.navigationBar.tintColor = .black
    }

    func layoutViews() {
        view.addSubview(titleTextField)
        view.addSubview(descriptionTextField)
        view.addSubview(saveTodoButton)
        setConstraints()
        hideKeyboard()
    }

    func setConstraints() {
        NSLayoutConstraint.activate([
            // set title text field constraints
            titleTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            titleTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            titleTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            titleTextField.heightAnchor.constraint(equalToConstant: 50),
            // set description text field constraints
            descriptionTextField.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: 20),
            descriptionTextField.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            descriptionTextField.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            descriptionTextField.heightAnchor.constraint(equalToConstant: 300),
            // set save todo button constraints
            saveTodoButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20),
            saveTodoButton.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -20),
            saveTodoButton.topAnchor.constraint(equalTo: descriptionTextField.bottomAnchor, constant: 50),
            saveTodoButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
