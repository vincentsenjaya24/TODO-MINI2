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
    @Query(filter: #Predicate<Task> { task in
        task.isCompleted == false
    }) private var previewTasks : [Task]
    @Query(filter: #Predicate<Task> { task in
        task.isCompleted == true
    }) private var checkedTasks : [Task]
    
    @State var progress: Double = 0.0
    @State var maxTaps = 10
    
    @State var moveToTop = false
    @State var isFloating = false
    @State var returnToInitial = false
    @State var backgroundOffset: CGFloat = 0
    @State var componentFloating = false
    
    var body: some View {
        ZStack {
            WaterView(moveToTop: $moveToTop, isFloating: $isFloating, returnToInitial: $returnToInitial, backgroundOffset: $backgroundOffset, componentFloating: $componentFloating)
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
                            ShrunkView(previewTasks: previewTasks, currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask, maxTaps: $maxTaps, progress: $progress, moveToTop: $moveToTop, isFloating: $isFloating, returnToInitial: $returnToInitial, backgroundOffset: $backgroundOffset, componentFloating: $componentFloating)
                        } else {
                            ContentView(currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask, maxTaps: $maxTaps, progress: $progress, moveToTop: $moveToTop, isFloating: $isFloating, returnToInitial: $returnToInitial, backgroundOffset: $backgroundOffset, componentFloating: $componentFloating)
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
        
        @Binding var moveToTop: Bool
        @Binding var isFloating: Bool
        @Binding var returnToInitial: Bool
        @Binding var backgroundOffset: CGFloat
        @Binding var componentFloating: Bool
        
        var body: some View {
            NavigationStack{
                List{
                    ForEach(previewTasks){task in
                        TaskRowView(task: task, currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask, maxTaps: $maxTaps, progress: $progress, moveToTop: $moveToTop, isFloating: $isFloating, returnToInitial: $returnToInitial, backgroundOffset: $backgroundOffset, componentFloating: $componentFloating)
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
