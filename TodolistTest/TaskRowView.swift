//
//  TaskRowView.swift
//  TodolistTest
//
//  Created by Vincent Senjaya on 19/06/24.
//
import SwiftUI
import SwiftData

struct TaskRowView: View {
    @Environment(\.modelContext) var modelContext
    @Bindable var task: Task
    
    @Binding var currentExp : Int
    @Binding var currentLevel : Int
    @Binding var completedTask : Int
    
 
    
    var body: some View {
           HStack {
               Button(action: {
                   task.isCompleted.toggle()
                   if task.isCompleted {
                       addProgress()
                   }
               }) {
                   Image(systemName: task.isCompleted ? "checkmark.square" : "square")
               }
               .disabled(task.isCompleted)
               .buttonStyle(PlainButtonStyle()) // This can help avoid default button styles interfering
               Divider()
               NavigationLink(destination: EditTaskView(task: task)) {
                   Text(task.title)
                       .foregroundColor(task.isCompleted ? .secondary : .primary)
                       .strikethrough(task.isCompleted, color: .secondary)
               }
//               Spacer()
//               Divider()
//               Text(checkPriority(task: task))
//                   .foregroundColor(task.isCompleted ? .secondary : .primary)
               
           }
           .contentShape(Rectangle()) // Ensures the entire HStack is tappable for navigation
       }
    
    var filledReminderLabel: some View {
        Circle()
            .stroke(.primary, lineWidth: 2)
            .overlay(alignment: .center) {
                GeometryReader { geo in
                    VStack {
                        Circle()
                            .fill(.primary)
                            .frame(width: geo.size.width*0.7, height: geo.size.height*0.7, alignment: .center)
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                }
            }
    }
    
    
    func addProgress(){
        currentExp += 10
        if currentExp >= 100 {
            currentExp = 0
            currentLevel += 1
        }
    }
    func checkPriority(task: Task) -> String{
        if task.priority == 1{
            return "meh"
        } else if task.priority == 2{
            return "maybe"
        } else if task.priority == 3{
            return "must"
        } else {
            return "dunno"
        }
    }
    var emptyReminderLabel: some View {
        Circle()
            .stroke(.secondary)
    }
}

//@ObservedObject var user: Userz
//class User: ObservableObject {
//    @Published var xp: Int = 0
//    
//    func addXP(_ amount: Int) {
//        xp += amount
//    }
//}

//#Preview {
//    do {
//        let config = ModelConfiguration(isStoredInMemoryOnly: true)
//        let container = try ModelContainer(for: Reminder.self, configurations: config)
//        let example = Reminder(name: "Reminder Example", isCompleted: false)
//        
//        return ReminderRowView(reminder: example)
//            .modelContainer(container)
//    } catch {
//        fatalError("Failed to create model container")
//    }
//}
