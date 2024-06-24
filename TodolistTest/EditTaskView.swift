//
//  EditDestinationView.swift
//  iTour
//
//  Created by Vincent Senjaya on 19/06/24.
//

import SwiftUI
import SwiftData

struct EditTaskView: View {
    
    @Bindable var task: Task
    
    var body: some View {
        Form{
            TextField("Name", text: $task.title)
            TextField("Details", text: $task.details, axis: .vertical)
            DatePicker("Date", selection: $task.date)
            Section("Priority"){
                Picker("Priority", selection: $task.priority){
                    Text("meh").tag(1)
                    Text("maybe").tag(2)
                    Text("must").tag(3)
                }.pickerStyle(.segmented)
            }
            
        }
        .navigationTitle("Edit Task")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

