//
//  ProfileView.swift
//  TodolistTest
//
//  Created by Vincent Senjaya on 24/06/24.
//

import SwiftUI
import Charts
import SwiftData

struct ProfileView: View {
    
    @Binding var currentExp : Int
    @Binding var currentLevel : Int
    @Binding var completedTask : Int
    @Query var tasks: [Task]
    
    @Query(filter: #Predicate<Task> { task in
        task.priority == 1
    }) private var taskMeh : [Task]
    
    @Query(filter: #Predicate<Task> { task in
        task.priority == 2
    }) private var taskMaybe : [Task]
    
    @Query(filter: #Predicate<Task> { task in
        task.priority == 3
    }) private var taskMust : [Task]
    
    private var taskStats: [(name: String, count: Int)] {
        return [
            (name: "Meh", count: taskMeh.count),
            (name: "Maybe", count: taskMaybe.count),
            (name: "Must", count: taskMust.count),
        ]
    }
    
    var body: some View {
        ScrollView{
            VStack(alignment: .leading) {
                // Header
                HStack {
                    VStack(alignment: .leading) {
                        Text("Ahoy,")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                        Text("Captain!")
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .foregroundColor(.black)
                    }
                    Spacer()
                    Image(systemName: "person.crop.circle")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                }
                .padding()
                
                // Level and XP
                HStack {
                    VStack(alignment: .leading) {
                        Text("My level")
                        Text("\(currentExp)/100 XP")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    ZStack {
                        Circle()
                            .stroke(lineWidth: 10)
                            .opacity(0.3)
                            .foregroundColor(Color.gray)
                        Circle()
                            .trim(from: 0.0, to: 0.5)
                            .stroke(style: StrokeStyle(lineWidth: 10, lineCap: .round, lineJoin: .round))
                            .foregroundColor(Color.green)
                            .rotationEffect(Angle(degrees: 270.0))
                            .animation(.linear)
                        Text("\(currentLevel)")
                            .font(.title)
                            .fontWeight(.bold)
                    }
                    .frame(width: 60, height: 60)
                }
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding()
                
                // Statistics
                HStack {
                    VStack {
                        Text("\(completedTask)")
                            .font(.headline)
                        Text("Finished task")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Divider()
                    Spacer()
                    VStack {
                        Text("5")
                            .font(.headline)
                        Text("Treasures")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    
                }
                .padding()
                
                // Pet Collection
                VStack {
                    Text("Pet Collection")
                        .font(.headline)
                    Text("Pet you have been discovered")
                        .font(.caption)
                        .foregroundColor(.gray)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(UIColor.systemGray6))
                .cornerRadius(10)
                .padding()
                
                // Task Progress
                VStack(alignment: .center) {
                    Divider()
                    Text("Your Weekly Summary")
                        .font(.headline)
                        .padding()
                    HStack{
                        VStack {
                            ZStack{
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                Chart {
                                    ForEach(taskStats, id: \.name) { coffee in
                                        SectorMark(
                                            angle: .value("Cup", coffee.count),
                                            innerRadius: .ratio(0.65),
                                            angularInset: 2.0
                                        )
                                        .foregroundStyle(by: .value("Type", coffee.name))
                                        .cornerRadius(10)
                                    }
                                }.chartLegend(.hidden).padding()
                            }
                        }.padding(10)
                        VStack(alignment: .leading) {
                            HStack {
                                Circle().fill(Color.orange).frame(width: 15, height: 15)
                                VStack(alignment: .leading)
                                {
                                    Text("meh").font(.system(size: 16))
                                    Text("2 task").font(.system(size: 12)).opacity(0.5)
                                }
                            }
                            
                            HStack {
                                Circle().fill(Color.green).frame(width: 15, height: 15)
                                VStack(alignment: .leading)
                                {
                                    Text("maybe").font(.system(size: 16))
                                    Text("2 task").font(.system(size: 12)).opacity(0.5)
                                }
                            }
                            
                            HStack {
                                Circle().fill(Color.blue).frame(width: 15, height: 15)
                                VStack(alignment: .leading)
                                {
                                    Text("must").font(.system(size: 16))
                                    Text("2 task").font(.system(size: 12)).opacity(0.5)
                                }
                            }
                            
                            
                        }.padding()
                    }.padding()
                }
            }
        }.padding().edgesIgnoringSafeArea(.bottom)
    }
}

//#Preview {
//    ProfileView()
//}
