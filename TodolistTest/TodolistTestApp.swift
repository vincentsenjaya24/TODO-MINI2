//
//  TodolistTestApp.swift
//  TodolistTest
//
//  Created by Clarissa Alverina on 17/06/24.
//

import SwiftUI

@main
struct TodolistTestApp: App {
    var body: some Scene {
        WindowGroup {
            SheetView()
        }.modelContainer(for: Task.self)
    }
}
