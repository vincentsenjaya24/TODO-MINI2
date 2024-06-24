//
//  SheetView.swift
//  TodolistTest
//
//  Created by Clarissa Alverina on 17/06/24.
//

import SwiftUI
import SwiftData
import Foundation

struct SheetView: View {
    @State private var showSheet: Bool = false
    @AppStorage("currentExp") private var currentExp = 0 
    @AppStorage("currentLevel") private var currentLevel = 1
    @AppStorage("completedTask") private var completedTask = 0
    @State private var currentDetent: PresentationDetent = .height(190)
//    @State private var tabSelection = 1
//    
    @Query(filter: #Predicate<Task> { task in
        task.isCompleted == false
    }) private var previewTasks : [Task]
    
    @Query(filter: #Predicate<Task> { task in
        task.isCompleted == true
    }) private var checkedTasks : [Task]
    
    var body: some View {
        ZStack {
            VStack {
                    Text("EXP \(currentExp)")
                        .fontWeight(.semibold)
                        .font(.system(size: 18))
                    Text("LEVEL \(currentLevel)")
                        .fontWeight(.semibold)
                        .font(.system(size: 18))
                        //xp and level here
            }
            .padding(.bottom, 700)
            .padding(.trailing, 200)
        }
        .onAppear(perform: {
            showSheet = true
        })
        .sheet(isPresented: $showSheet) {
                    VStack(alignment: .leading, spacing: 10) {
                        if currentDetent == .height(190) {
                            ShrunkView(previewTasks: previewTasks, currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask)
                        } else {
                            ContentView(currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask)
                        }
                    }
                    .padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                    .presentationDetents([.height(190), .medium, .large], selection: $currentDetent)
                    .presentationCornerRadius(30)
                    .presentationBackground(.regularMaterial)
                    .presentationDragIndicator(.visible)
                    .interactiveDismissDisabled(true).ignoresSafeArea()
        }
    }
    struct ShrunkView: View {
        var previewTasks: [Task]
        @Binding var currentExp : Int
        @Binding var currentLevel : Int
        @Binding var completedTask : Int
        
        var body: some View {
            NavigationStack{
                List{
                    ForEach(previewTasks){task in
                            TaskRowView(task: task, currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask)
                    }
                }.navigationTitle(checkPreviewTask(previewTasks: previewTasks))
            }
        }
        
        func checkPreviewTask(previewTasks: [Task]) -> String {
            if previewTasks.isEmpty{
                return "Good Job!"
            } else {
                return "Finish Them!"
            }
        }
    }

}

#Preview {
    SheetView()
}
