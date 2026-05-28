//
//  ListView.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

internal import SwiftUI

struct ListView: View {

    @EnvironmentObject var listViewModel: ListViewModel
    @State private var selectedFrequency: Frequency = .daily

    var filteredItems: [ItemModel] {
        listViewModel.items.filter { $0.frequency == selectedFrequency }
    }

    var body: some View {
        List {
            ForEach(filteredItems) { item in
                ListRowView(item: item)
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation(.linear) {
                            listViewModel.updateItem(item: item)
                        }
                    }
            }
            .onDelete { indexSet in
                listViewModel.deleteItem(indexSet: indexSet, frequency: selectedFrequency)
            }
            .onMove(perform: listViewModel.moveItem)
        }
        .listStyle(PlainListStyle())
        .navigationTitle(selectedFrequency.rawValue)
        .navigationBarItems(
            leading: EditButton(),
            trailing: NavigationLink("Add", destination: Addview(frequency: selectedFrequency))
        )
        .safeAreaInset(edge: .bottom) {
            Picker("Frequency", selection: $selectedFrequency) {
                ForEach(Frequency.allCases, id: \.self) { freq in
                    Text(freq.rawValue).tag(freq)
                }
            }
            .pickerStyle(.segmented)
            .padding()
            .background(.bar)
        }
    }
}
    
    #Preview {
        NavigationView {
            ListView()
        }
        .environmentObject(ListViewModel())
    }


