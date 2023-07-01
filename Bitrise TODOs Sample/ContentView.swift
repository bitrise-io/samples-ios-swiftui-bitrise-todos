//
//  ContentView.swift
//  Bitrise TODOs Sample
//
//  Created by viktorbenei on 2023. 06. 26..
//

import SwiftUI

struct Task: Identifiable {
    let id = UUID()
    var title: String
    var completed: Bool
}

class Tasks: ObservableObject {
    @Published var tasks: [Task]
    
    init() {
        tasks = [Task]()
    }
    
    init(withTasks ts: [Task] = []){
        tasks = ts
    }
    
    func addTask(title: String) {
        if !title.isEmpty {
            tasks.append(Task(title: title, completed: false))
        }
    }
    
    func toggleTaskCompletion(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks[index].completed.toggle()
        }
    }
    
    func deleteTask(task: Task) {
        if let index = tasks.firstIndex(where: { $0.id == task.id }) {
            tasks.remove(at: index)
        }
    }
}

struct ContentView: View {
    @State private var newTaskText = ""
    @ObservedObject private var tasks: Tasks
    
    init() {
        tasks = Tasks()
    }
    
    init(withTasks ts: Tasks) {
        tasks = ts
    }
    
    var body: some View {
        VStack {
            TextField("Enter new task", text: $newTaskText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                tasks.addTask(title: newTaskText)
                newTaskText = ""
            }) {
                Text("Add Task")
            }
            .padding()

            Text("Not Done Yet")
            List {
                ForEach(tasks.tasks.filter { !$0.completed }) { task in
                    taskRow(task: task)
                }
            }
            
            Text("Done")
            List {
                ForEach(tasks.tasks.filter { $0.completed }) { task in
                    taskRow(task: task)
                }
            }
        }
        .padding()
    }
    
    @ViewBuilder
    private func taskRow(task: Task) -> some View {
        HStack {
            Button(action: {
                tasks.toggleTaskCompletion(task: task)
            }) {
                Image(systemName: task.completed ? "checkmark.square" : "square")
                    .foregroundColor(task.completed ? .green : .gray)
            }
            .buttonStyle(PlainButtonStyle())

            Text(task.title)
                .strikethrough(task.completed)
            
            Spacer()
            
            Button(action: {
                tasks.deleteTask(task: task)
            }) {
                Image(systemName: "trash")
                    .foregroundColor(.red)
            }
            .buttonStyle(PlainButtonStyle())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(withTasks: Tasks(withTasks: [
            Task(title: "Preview task 1", completed: false),
            Task(title: "Preview task 2", completed: true)
        ]))
    }
}
