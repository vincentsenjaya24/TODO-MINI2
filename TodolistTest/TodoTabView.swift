//
//  TodoTabView.swift
//  TodolistTest
//
//  Created by Vincent Senjaya on 24/06/24.
//

import SwiftUI

struct TodoTabView: View {
    @Binding var tabSelection: Int
    @Namespace private var animationNamespace
    
    let tabBarItems: [(image: String, title : String)] = [
        
        ("clock.arrow.circlepath", "History"),
        ("house", "Home"),
        ("calendar", "Schedule")
    ]
    var body: some View {
        ZStack{
            Capsule()
                .frame(height: 80)
                .foregroundColor(Color(.secondarySystemBackground))
                .shadow(radius: 2)
            
            HStack{
                ForEach(0..<3){ index in
                    Button{
                        tabSelection = index + 1
                    } label: {
                        VStack(spacing: 8){
                            Spacer()
                            Image(systemName: tabBarItems[index].image)
                            Text(tabBarItems[index].title)
                            if index + 1 == tabSelection {
                                Capsule()
                                    .frame(height: 8)
                                    .foregroundColor(.blue)
                                    .matchedGeometryEffect(id: "SelectedTabId", in: animationNamespace)
                                    .offset(y: 3)
                            } else {
                                Capsule()
                                    .frame(height: 8)
                                    .foregroundColor(.clear)
                                    .offset(y: 3)
                            }
                        }.foregroundColor(index + 1 == tabSelection ? .blue : .gray)
                    }
                }
            }
            .frame(height: 80)
            .clipShape(Capsule())
        }
    }
}

//#Preview {
//    TodoTabView()
//}
