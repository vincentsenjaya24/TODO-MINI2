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
    
    @State var progress: Double = 0.0
    @State var maxTaps = 10
    
    var body: some View {
        ZStack {
            VStack {
                HStack {
                    Spacer()
                    VStack {
                        //                    Text("EXP \(currentExp)")
                        //                        .fontWeight(.semibold)
                        //                        .font(.system(size: 18))
                        Text("Lvl. \(currentLevel)")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                    }
                    
                    VStack {
                        ProgressBarView(maxTaps: $maxTaps, progress: $progress)
                    }
                    
                    Spacer()
                    
                }
            }.padding(.bottom, 700)
        }
        .onAppear(perform: {
            showSheet = true
        })
        .sheet(isPresented: $showSheet) {
                    VStack(alignment: .leading, spacing: 10) {
                        if currentDetent == .height(190) {
                            ShrunkView(previewTasks: previewTasks, currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask, maxTaps: $maxTaps, progress: $progress)
                        } else {
                            ContentView(currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask, maxTaps: $maxTaps, progress: $progress)
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
        @Binding var maxTaps : Int
        @Binding var progress : Double
        
        var body: some View {
            NavigationStack{
                List{
                    ForEach(previewTasks){task in
                        TaskRowView(task: task, currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask, maxTaps: $maxTaps, progress: $progress)
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
