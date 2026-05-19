//
//  ListView.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

internal import SwiftUI

struct ListView: View {
    
    @EnvironmentObject var listViewModel: ListViewModel

    var body: some View {
        List{
            ForEach(listViewModel.items){ item in
                ListRowView(item: item)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.linear){
                            listViewModel.updateItem(item: item)
                        }
                    }            }
            .onDelete(perform: listViewModel.deleteItem)
            .onMove(perform: listViewModel.moveItem)
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
        .environmentObject(ListViewModel())
    }


