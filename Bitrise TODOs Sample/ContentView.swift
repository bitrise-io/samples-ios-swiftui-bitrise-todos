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

struct ContentView: View {
    @State private var newTaskText = ""
    @State private var tasks = [Task]()

    var body: some View {
        VStack {
            TextField("Enter new task", text: $newTaskText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                if !newTaskText.isEmpty {
                    tasks.append(Task(title: newTaskText, completed: false))
                    newTaskText = ""
                }
            }) {
                Text("Add Task")
            }
            .padding()

            List {
                ForEach(tasks) { task in
                    HStack {
                        Button(action: {
                            if let index = tasks.firstIndex(where: { $0.id == task.id }) {
                                tasks[index].completed.toggle()
                            }
                        }) {
                            Image(systemName: task.completed ? "checkmark.square" : "square")
                                .foregroundColor(task.completed ? .green : .gray)
                        }
                        .buttonStyle(PlainButtonStyle())

                        Text(task.title)
                            .strikethrough(task.completed)
                    }
                }
            }
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
