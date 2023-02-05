//
//  SearchBarView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 19.08.2022.
//

import SwiftUI

struct SearchBarView: View {
    
    //MARK: PROPERTIES
    @Binding var searchText: String
    
    //MARK: BODY
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(searchText.isEmpty ? Color.secondary : Color.primary)
            TextField("Search by name or symbol...", text: $searchText)
                .disableAutocorrection(true)
                .overlay(
                    Image(systemName: "multiply.circle")
                        .padding()
                        .offset(x: 10)
                        .opacity(searchText.isEmpty ? 0 : 1)
                        .onTapGesture {
                            UIApplication.shared.endEditing()
                            searchText = ""
                        }
                    , alignment: .trailing)
        }
        .title
    }
}

//MARK: PREVIEW
struct SearchBarView_Previews: PreviewProvider {
    static var previews: some View {
        SearchBarView(searchText: .constant(""))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
