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
    @State private var showResetAlert: Bool = false

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
                if filteredItems.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "checklist")
                            .font(.largeTitle)
                            .foregroundColor(.secondary)
                        Text("No \(selectedFrequency.rawValue) tasks yet")
                            .font(.headline)
                        Text("Tap \"Add\" to get started")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    .frame(maxWidth: .infinity)
                    .padding()
                } else {
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
                    .onMove { indexSet, toOffset in
                        listViewModel.moveItem(from: indexSet, to: toOffset, frequency: selectedFrequency)
                    }
                }
            }
            .listStyle(PlainListStyle())
        }
        .navigationTitle("\(selectedFrequency.rawValue)  \(completedCount)/\(totalCount)")
        .navigationBarItems(
            leading: EditButton(),
            trailing: HStack {
                Button(action: {
                    showResetAlert = true
                }) {
                    Image(systemName: "arrow.counterclockwise")
                }
                NavigationLink("Add", destination: Addview(frequency: selectedFrequency))
            }
        )
        .alert("Reset Chores?", isPresented: $showResetAlert) {
            Button("Reset", role: .destructive) {
                listViewModel.resetItems(frequency: selectedFrequency)
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("All chores in \(selectedFrequency.rawValue) will be marked incomplete.")
        }
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
