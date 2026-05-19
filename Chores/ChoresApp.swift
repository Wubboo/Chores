//
//  ChoresApp.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

/*
 MVVM Arcitecture
 Model - DataPoint
 View - ui
 ViewModel - manages models for views
 
 */

import SwiftUI

@main
struct ChoresApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView{
                ListView()
            }
        }
    }
}
