//
//  ListRowView.swift
//  Chores
//
//  Created by Wubbo Boiten on 19/05/2026.
//

import SwiftUI

struct ListRowView: View {
    
    let title: String
    
    
    var body: some View {
        HStack{
            Image(systemName: "checkmark.circle")
            Text(title)
            Spacer()
        }
    }
}

#Preview {
    ListRowView(title: "")
}

