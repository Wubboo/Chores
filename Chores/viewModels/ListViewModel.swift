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
    
    @Published var items: [ItemModel] = [] {
        didSet {
            saveItems()
        }
    }
    let itemsKey: String = "items_list"
    
    init () {
        getItems()
    }
    
    func getItems() {
            guard
            let data = UserDefaults.standard.data(forKey: itemsKey),
            let savedItems = try? JSONDecoder().decode([ItemModel].self, from: data)
            else {return}
        self.items = savedItems
    }
    
    func deleteItem(indexSet: IndexSet, frequency: Frequency) {
        let filteredItems = items.filter { $0.frequency == frequency }
        let idsToDelete = indexSet.map { filteredItems[$0].id }
        items.removeAll { idsToDelete.contains($0.id) }
    }
    
    func moveItem(from: IndexSet, to: Int, frequency: Frequency) {
        let filteredItems = items.filter { $0.frequency == frequency }
        var filteredIds = filteredItems.map { $0.id }
        filteredIds.move(fromOffsets: from, toOffset: to)
        
        // rebuild full array preserving other frequencies
        let otherItems = items.filter { $0.frequency != frequency }
        let reorderedFiltered = filteredIds.compactMap { id in
            items.first { $0.id == id }
        }
        items = reorderedFiltered + otherItems
    }
    
    func addItem(title: String, frequency: Frequency) {  
        let newItem = ItemModel(title: title, isCompleted: false, frequency: frequency)
        items.append(newItem)
    }
    
    func updateItem(item: ItemModel) {
        if let index = items.firstIndex(where: { $0.id == item.id}) {
            items[index] = item.updateCompleiton()
        }
            
        }
    func saveItems(){
        if let encodedData = try? JSONEncoder().encode(items){
            UserDefaults.standard.set(encodedData, forKey: itemsKey)
        }
    }
    }
