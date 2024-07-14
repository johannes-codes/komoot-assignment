//
//  Komoot_AssignmentApp.swift
//  Komoot Assignment
//
//  Created by Meißner, Johannes on 14.07.24.
//

import SwiftUI

@main
struct Komoot_AssignmentApp: App {
    @ObservedObject private var coordinator = Coordinator()

    var body: some Scene {
        WindowGroup {
            ContentView(coordinator: coordinator)
        }
    }
}
