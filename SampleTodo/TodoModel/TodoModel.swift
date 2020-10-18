//
//  TodoModel.swift
//  SampleTodo
//
//  Created by David U. Okonkwo on 10/16/20.
//
import RealmSwift

class TodoModel: Object {
    @objc dynamic var title = ""
    @objc dynamic var todoDescription = ""
    @objc dynamic var isDone = false
}
