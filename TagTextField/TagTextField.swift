//
//  TagTextField.swift
//  TagTextField
//
//  Created by kosha on 21.09.2023.
//

import SwiftUI

struct TagTextField: View {
    @Binding var tags: [String]
    @Binding var keyword: String
    
    var placeholder: String = ""
    var checkKeyword: ((String) -> String?)? = { $0 } //this is a closure is to get a candidate for the currently inputed text
        
    @State private var availableWidth: CGFloat = 0
    @State private var elementsSize: [String: CGSize] = [:]
    
    public var body: some View {
        ZStack(alignment: Alignment(horizontal: .leading, vertical: .center)) {
            Color.clear
                .frame(height: 1)
                .readSize { size in
                    availableWidth = size.width
                }
            tagContainer
        }
    }
    
    var tagContainer: some View {
        let rows = computeRows()
        return VStack(alignment: .leading, spacing: 5) {
            ForEach(0..<rows.count, id: \.self) { index in
                HStack(spacing: 5) {
                    ForEach(rows[index], id: \.self) { element in
                        SearchTextFieldLabel(text: element, action: {
                            tags.removeAll(where: {$0 == element})
                        })
                        .fixedSize()
                        .readSize { size in
                            elementsSize[element] = size
                        }
                    }
                    if index == rows.count - 1 {
                        textInputView
                    }
                }
            }
        }
    }
    
    @ViewBuilder
    var textInputView: some View {
        TextField(placeholder, text: $keyword, onCommit: {
            if keyword.count > 0,
               let result = checkKeyword?(keyword), tags.contains(result) == false {
                tags.append(result)
            }
            keyword = ""
        })
        .textFieldStyle(PlainTextFieldStyle())
        .font(.system(size: 12))
        .foregroundColor(.black)
        .disableAutocorrection(true)
        .padding(6)
        .background(Color(.sRGB, red: 244.0/255.0, green: 245.0/255.0, blue: 249.0/255.0, opacity: 1))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        //.autocapitalization(.none)
    }
    
    func computeRows() -> [[String]] {
        var rows: [[String]] = [[]]
        var currentRow = 0
        var remainingWidth = availableWidth
        
        for element in tags {
            let elementSize = elementsSize[element, default: CGSize(width: availableWidth, height: 1)]
            
            if remainingWidth - (elementSize.width + 5) >= 0 {
                rows[currentRow].append(element)
            } else {
                currentRow = currentRow + 1
                rows.append([element])
                remainingWidth = availableWidth
            }
            remainingWidth = remainingWidth - (elementSize.width + 5)
        }
        return rows
    }
}

#Preview {
    TagTextField(tags: .constant(["Grape", "Apple", "Apricot", "Banana"]), keyword: .constant(""))
}
