//
//  ContentView.swift
//  Bitrise TODOs Sample
//
//  Created by viktorbenei on 2023. 06. 26..
//

import SwiftUI

struct ContentView: View {
    @State private var newTaskText = ""
    @State private var tasks = [String]()

    var body: some View {
        VStack {
            TextField("Enter new task", text: $newTaskText)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            Button(action: {
                if !newTaskText.isEmpty {
                    tasks.append(newTaskText)
                    newTaskText = ""
                }
            }) {
                Text("Add Task")
            }
            .padding()

            List(tasks, id: \.self) { task in
                Text(task)
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
