//
//  SearchTextFieldView.swift
//  TagTextField
//
//  Created by kosha on 21.09.2023.
//

import SwiftUI

struct SearchTextFieldView: View {
    @State var tags: [String] = []
    @State var keyword: String = ""
    
    var allTags: [String] = ["Grape", "Apple", "Apricot", "Banana", "Watemelon", "Melon", "Mango", "Cherry", "Kiwi", "Pineapple", "Orange", "Carambola", "Strawberry", "Blackberry"]
    
    var body: some View {
            TagTextField(tags: $tags, keyword: $keyword, placeholder: "Fruit") { _ in
                return allTags.filter{$0.lowercased().contains(keyword.lowercased()) == true}.first
            }
            .padding(6)
            .background(Color.cyan.opacity(0.3))
        
        if (allTags.filter{$0.lowercased().contains(keyword.lowercased()) == true}).count > 0 {
            List {
                ForEach((allTags.filter{$0.lowercased().contains(keyword.lowercased()) == true}), id: \.self) { tag in
                    Button(action: {
                        if tags.contains(tag) == false {
                            tags.append(tag)
                        }
                        keyword = ""
                    }, label: {
                        Text(tag)
                            .padding()
                    })
                    .listRowInsets(EdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16))
                }
            }
        }
        else {
            VStack(alignment: .center, spacing: 0) {
                Spacer()
                
                Text("No tags found")
                    .font(Font.system(size: 16))
                    .foregroundColor(Color.secondary)
                    .padding(.top, 20)
                
                Spacer()
            }
        }
    }
    
}

#Preview {
    SearchTextFieldView()
}
