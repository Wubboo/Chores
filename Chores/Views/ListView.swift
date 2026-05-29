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

    var completedCount: Int {
        filteredItems.filter { $0.isCompleted }.count
    }

    var totalCount: Int {
        filteredItems.count
    }

    var body: some View {
        VStack(spacing: 0) {
            VStack(spacing: 6) {
                HStack {
                    Text("\(completedCount)")
                        .foregroundColor(.green)
                        .fontWeight(.semibold)
                    Text("/")
                        .foregroundColor(.secondary)
                    Text("\(totalCount)")
                        .foregroundColor(completedCount == totalCount && totalCount > 0 ? .green : .red)
                        .fontWeight(.semibold)
                    Text("done")
                        .foregroundColor(.secondary)
                    Spacer()
                }
                .font(.subheadline)

                ProgressView(value: totalCount > 0 ? Double(completedCount) / Double(totalCount) : 0)
                    .tint(completedCount == totalCount && totalCount > 0 ? .green : .accentColor)
            }
            .padding(.horizontal)
            .padding(.vertical, 8)

            List {
                ForEach(filteredItems) { item in
                    ListRowView(item: item)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            withAnimation(.linear) {
                                listViewModel.updateItem(item: item)
                            }
                        }
                }  // closes ForEach
                .onDelete { indexSet in
                    listViewModel.deleteItem(indexSet: indexSet, frequency: selectedFrequency)
                }
                .onMove { indexSet, toOffset in
                    listViewModel.moveItem(from: indexSet, to: toOffset, frequency: selectedFrequency)
                }
            }  // closes List
            .listStyle(PlainListStyle())
        }  // closes VStack
        .navigationTitle("\(selectedFrequency.rawValue)  \(completedCount)/\(totalCount)")
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
