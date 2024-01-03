//
//  SearchLabel.swift
//  TagTextField
//
//  Created by kosha on 21.09.2023.
//

import SwiftUI

struct SearchTextFieldLabel: View {
    let text: String
    let action: (() -> Void)
    
    var body: some View {
        HStack(alignment: .center, spacing: 10) {
            Text(text)
                .font(.system(size: 12))
                .foregroundColor(.blue)
            Button(action: action,
                   label: {
                Image(systemName: "checkmark")
                    .foregroundColor(.black)
            })
        }
        .padding(.horizontal, 10)
        .padding(.vertical, 10)
        .background(Color(red: 0.07, green: 0.18, blue: 0.42).opacity(0.05))
        .cornerRadius(5)
    }
}

#Preview {
    SearchTextFieldLabel(text: "Undergraduate", action: {})
}

