//
//  Addview.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

internal import SwiftUI

struct Addview: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var listViewModel: ListViewModel
    @State var textFieldText: String = ""
    let frequency: Frequency  

    var body: some View {
        ScrollView {
            VStack {
                TextField("Do the dishes", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color.accentColor.opacity(0.15))
                    .cornerRadius(10)

                Button(action: saveButtonTapped) {
                    Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                }
            }
            .padding(14)
        }
        .navigationTitle("Add \(frequency.rawValue) Task")
    }

    func saveButtonTapped() {
        listViewModel.addItem(title: textFieldText, frequency: frequency)  
        presentationMode.wrappedValue.dismiss()
    }
}

#Preview {
    NavigationView {
        Addview(frequency: .daily)
    }
    .environmentObject(ListViewModel())
}
