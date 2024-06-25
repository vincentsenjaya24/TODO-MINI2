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
    @State private var currentDetent: PresentationDetent = .height(300)
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
                        Text("Lvl. \(currentLevel)")
                            .fontWeight(.semibold)
                            .font(.system(size: 12))
                        ProgressBarView(maxTaps: $maxTaps, progress: $progress)
                    Spacer()
                    
                }.background(.regularMaterial).clipped().frame(width: 300).cornerRadius(15)
                
            }.padding(.bottom, 700)
            
            VStack {
                Button(action: {
                    showSheet = true
                }) {
                    ZStack {
                        Circle()
                            .frame(width: 60, height: 60)
                            .foregroundColor(.white)
                        Image(systemName: "list.bullet.clipboard.fill")
                            .foregroundColor(.black)
                            .font(.system(size: 24))
                    }
                }
                .padding(.top, 650)
            }
        }
        .edgesIgnoringSafeArea(.all)
        .onAppear(perform: {
            showSheet = true
        })
        .sheet(isPresented: $showSheet) {
            ZStack {
//                Color.white.edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 10) {
                    if currentDetent == .height(300) {
                        ZStack {
                            ShrunkView(previewTasks: previewTasks, currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask, maxTaps: $maxTaps, progress: $progress, moveToTop: $moveToTop, isFloating: $isFloating, returnToInitial: $returnToInitial, backgroundOffset: $backgroundOffset, componentFloating: $componentFloating)
                        }
                    } else {
                        ZStack{
                            ContentView(currentExp: $currentExp, currentLevel: $currentLevel, completedTask: $completedTask, maxTaps: $maxTaps, progress: $progress, moveToTop: $moveToTop, isFloating: $isFloating, returnToInitial: $returnToInitial, backgroundOffset: $backgroundOffset, componentFloating: $componentFloating)
                        }
                    }
                }
                //                    .padding()
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .topLeading)
                .presentationDetents([.height(300), .medium, .large], selection: $currentDetent)
                .presentationCornerRadius(30)
                .presentationBackground(.regularMaterial)
                .presentationDragIndicator(.visible)
            }
                    
        }
        .edgesIgnoringSafeArea(.all)
        .scrollContentBackground(.hidden)
        .presentationBackgroundInteraction(.enabled(upThrough: .height(120)))
        .interactiveDismissDisabled(true).ignoresSafeArea()
//        .presentationBackground(<#T##style: ShapeStyle##ShapeStyle#>)
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
        .modelContainer(for: Task.self)
}
