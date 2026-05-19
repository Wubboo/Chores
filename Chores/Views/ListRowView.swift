//
//  ListRowView.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    
    var body: some View {
        HStack{
            Image(systemName: "checkmark.circle")
            Text(item.title)
            Spacer()
        }
    }
}

#Preview {
    
     var item1 = ItemModel(title: "task1", isCompleted: false)
    var item2 = ItemModel(title: "task2", isCompleted: false)
    
    Group{
        ListRowView(item: item1)
        ListRowView(item: item2)
    }
    
}

