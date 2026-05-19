//
//  ItemModel.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

import Foundation

struct ItemModel: Identifiable {
    let id: String
    let title: String
    let isCompleted: Bool
    
    init(id: String = UUID().uuidString, title: String, isCompleted: Bool) {
        
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
    
    func updateCompleiton() -> ItemModel {
        	return ItemModel(id: id, title: title, isCompleted: !isCompleted)
    }
}
