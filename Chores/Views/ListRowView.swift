//
//  ListRowView.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

internal import SwiftUI

struct ListRowView: View {
    
    let item: ItemModel
    
    
    var body: some View {
        HStack{
            Image(systemName: item.isCompleted ? "checkmark.circle" : "circle")
                .foregroundColor(item.isCompleted ? .green : .red)
                .font(.title2)
                .padding(.vertical, 8)
            
            Text(item.title)
            Spacer()
        }
    }
}

#Preview {
    
     var item1 = ItemModel(title: "task1", isCompleted: false)
    var item2 = ItemModel(title: "task2", isCompleted: true)
    
    Group{
        ListRowView(item: item1)
        ListRowView(item: item2)
    }
    
}

