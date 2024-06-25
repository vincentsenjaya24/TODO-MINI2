//
//  ProfileView.swift
//  TodolistTest
//
//  Created by Vincent Senjaya on 24/06/24.
//

import SwiftUI
import Charts

struct ProfileView: View {
    
    private var coffeeSales = [
        (name: "Americano", count: 120),
        (name: "Cappuccino", count: 234),
        (name: "Espresso", count: 62),
        (name: "Latte", count: 625),
        (name: "Mocha", count: 320),
        (name: "Affogato", count: 50)
    ]
    
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
                        Text("50/100 XP")
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
                        Text("2")
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
                        Text("500")
                            .font(.headline)
                        Text("Finished task")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    Spacer()
                    Divider()
                    Spacer()
                    VStack {
                        Text("10")
                            .font(.headline)
                        Text("Island discovered")
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
                    Text("Your Steps Progress")
                        .font(.headline)
                        .padding(.leading)
                    Picker(selection: .constant(1), label: Text("")) {
                        Text("Weekly").tag(1)
                        Text("Monthly").tag(2)
                        Text("Yearly").tag(3)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()
                    HStack{
                        VStack {
                            ZStack{
                                Circle()
                                    .fill(Color.gray.opacity(0.2))
                                Chart {
                                    ForEach(coffeeSales, id: \.name) { coffee in
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
                        VStack {
                            HStack {
                                Circle().fill(Color.orange).frame(width: 15, height: 15)
                                VStack(alignment: .leading)
                                {
                                    Text("Home").font(.system(size: 16))
                                    Text("2 task").font(.system(size: 12)).opacity(0.5)
                                }
                            }
                            
                            HStack {
                                Circle().fill(Color.green).frame(width: 15, height: 15)
                                VStack(alignment: .leading)
                                {
                                    Text("Home").font(.system(size: 16))
                                    Text("2 task").font(.system(size: 12)).opacity(0.5)
                                }
                            }
                            
                            HStack {
                                Circle().fill(Color.blue).frame(width: 15, height: 15)
                                VStack(alignment: .leading)
                                {
                                    Text("Home").font(.system(size: 16))
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

#Preview {
    ProfileView()
}
