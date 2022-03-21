//
//  DifferenceView.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

struct DifferenceView: View {
    @FocusState private var focus: Bool

    @State private var sellValue2 = ""
    @State private var boughtValue2 = ""
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()

            VStack {
                TextField("Enter sell value", text: $sellValue2)
                    .textFieldClearButton(text: $sellValue2)
                    .title
                    .focused($focus)

                TextField("Enter bought value", text: $boughtValue2)
                    .textFieldClearButton(text: $boughtValue2)
                    .title
                    .focused($focus)

                Text("Difference is:")
                    .foregroundColor(.black)
                    .padding(.bottom, -1)

                Text("\(percentageDifference, specifier: "%.2f")%")
                    .foregroundColor(.black)
            }

            Button {
                sellValue2 = ""
                boughtValue2 = ""
            } label: {
                Text("Clear")
                    .titleClear
            }
            .padding(.top, 500)
            .shadow(radius: 2)
        }
    }

    var percentageDifference: Double {
       ((Double(convert(text: sellValue2)) ?? 0) - (Double(convert(text: boughtValue2)) ?? 0)) / (Double(convert(text: boughtValue2)) ?? 100) * 100
    }

    // Replace "," with "." function
    func convert(text: String) -> String {
         text.replacingOccurrences(of: ",", with: ".")
    }
}

struct DifferenceView_Previews: PreviewProvider {
    static var previews: some View {
        DifferenceView()
    }
}
