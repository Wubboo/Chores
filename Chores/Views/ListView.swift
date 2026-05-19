//
//  ListView.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

import SwiftUI

struct ListView: View {
    
    @State var items: [String] = [
        "First Item",
        "Second Item",
        "Third Item"
    ]
    
    
    var body: some View {
        List{
            ForEach(items, id: \.self){ item in
                ListRowView(title: item)
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


