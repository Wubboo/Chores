//
//  ItemModel.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

import Foundation

enum Frequency: String, CaseIterable, Codable {
    case daily = "Daily"
    case weekly = "Weekly"
    case monthly = "Monthly"
}

struct ItemModel: Identifiable, Codable {
    let id: String
    let title: String
    let isCompleted: Bool
    var frequency: Frequency  

    init(id: String = UUID().uuidString, title: String, isCompleted: Bool, frequency: Frequency = .daily) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
        self.frequency = frequency
    }

    func updateCompleiton() -> ItemModel {
        return ItemModel(id: id, title: title, isCompleted: !isCompleted, frequency: frequency) // was losing frequency!
    }
}
