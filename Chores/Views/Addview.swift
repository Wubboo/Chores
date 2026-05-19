//
//  Addview.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

import SwiftUI

struct Addview: View {
    
    @State var textFieldText: String = ""
    
    var body: some View {
        ScrollView{
            VStack{
                TextField("Do the dishes", text: $textFieldText)
                    .padding(.horizontal)
                    .frame(height: 50)
                    .background(Color.accentColor.opacity(0.15))
                    .cornerRadius(10)
                
               Button(
                action: {},
                label: {Text("Save".uppercased())
                        .foregroundColor(.white)
                        .font(.headline)
                        .frame(height: 55)
                        .frame(maxWidth: .infinity)
                        .background(Color.accentColor)
                        .cornerRadius(10)
                    
                    
                }
               )
                
            }
            .padding(14)
        }
        .navigationTitle("Add Task")
    }
}

#Preview {
    NavigationView{
        Addview()
    }
}
