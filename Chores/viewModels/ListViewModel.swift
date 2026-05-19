//
//  ListViewModel.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

import Foundation
internal import Combine
internal import SwiftUI

class ListViewModel: ObservableObject {
    
   @Published var items: [ItemModel] = []
    
    init () {
        getItems()
    }
    
    func getItems() {
        let newItems = [
            ItemModel(title: "first task", isCompleted: false),
            ItemModel(title: "second task", isCompleted: false),
            ItemModel(title: "third task", isCompleted: false)
        ]
        items.append(contentsOf: newItems)
    }
    
    func deleteItem(indexSet: IndexSet) {
        items.remove(atOffsets: indexSet)
    }
    
    func moveItem(from: IndexSet, to: Int){
        items.move(fromOffsets: from, toOffset: to)
    }
    
}
