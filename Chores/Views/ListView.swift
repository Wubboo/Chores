//
//  ListView.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

import SwiftUI

struct ListView: View {
    
    @State var items: [ItemModel] = [
        ItemModel(title: "first task", isCompleted: false),
        ItemModel(title: "second task", isCompleted: false),
        ItemModel(title: "third task", isCompleted: false)
    ]
    
    
    var body: some View {
        List{
            ForEach(items){ item in
                Text("hi")
                //ListRowView(title: item)
            }
        }
        .listStyle(PlainListStyle())
        .navigationTitle("Todo:")
        .navigationBarItems(
            leading: EditButton(),
            trailing:
                NavigationLink(
                    "Add", destination: Addview())
        )
    }
}

#Preview {
    NavigationView {
        ListView()
    }
}


