//
//  DifferenceView.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

struct DifferenceView: View {
    @FocusState private var focus: Bool

    @State private var sellValue2 = 0.0
    @State private var boughtValue2 = 0.0
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()

            VStack(spacing: 2) {
                Text("Enter sell value")
                TextField("Enter sell value", value: $sellValue2, format: .number)
                    .textFieldClearButton(for: $sellValue2)
                    .title
                    .focused($focus)
                Text("Enter bought value")
                TextField("Enter bought value", value: $boughtValue2, format: .number)
                    .textFieldClearButton(for: $boughtValue2)
                    .title
                    .focused($focus)

                Text("Difference is:")
                    .foregroundColor(.black)
                    .padding(.bottom, -1)

                Text("\(percentageDifference, format: .percent)")
                    .foregroundColor(.black)
            }

            Button {
                sellValue2 = 0
                boughtValue2 = 0
            } label: {
                Text("Clear")
                    .titleClear
            }
            .padding(.top, 500)
            .shadow(radius: 2)
        }
    }

    var percentageDifference: Double {
        guard boughtValue2 > 0 else { return 0 }
        return (sellValue2 - boughtValue2) / boughtValue2
    }
}

struct DifferenceView_Previews: PreviewProvider {
    static var previews: some View {
        DifferenceView()
    }
}
