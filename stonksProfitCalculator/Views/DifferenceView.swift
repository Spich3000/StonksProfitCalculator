//
//  DifferenceView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct DifferenceView: View {
    
    // MARK: PROPERTIES
    @State private var sellValue = ""
    @State private var boughtValue = ""
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // MARK: BODY
    var body: some View {
        ZStack {
            background
            VStack(spacing: 30) {
                textFieldSection
                VStack(spacing: 20) {
                    information.text
                    clearButton
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    // MARK: CALCULATION
    var percentageDifference: Double {
        guard Double(convert(text: boughtValue)) ?? 0 > 0 else { return 0 }
        return ((Double(convert(text: sellValue)) ?? 0) - (Double(convert(text: boughtValue)) ?? 0)) / (Double(convert(text: boughtValue)) ?? 100) * 100
    }
}

// MARK: PREVIEW
struct DifferenceView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            DifferenceView()
        }
    }
}

// MARK: VIEW COMPONENTS
extension DifferenceView {
    
    private var background: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("backgroundWhite"), Color("backgroundGray")]),
            startPoint: UnitPoint(x: 0.2, y: 0.2),
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    // MARK: TEXT FIEDLS
    private var textFieldSection: some View {
        VStack(spacing: 30) {
            TextField("Enter sell value", text: $sellValue)
                .textFieldClearButton(text: $sellValue)
                .title
            TextField("Enter bought value", text: $boughtValue)
                .textFieldClearButton(text: $boughtValue)
                .title
        }
    }
    
    private var information: some View {
        VStack(spacing: 5) {
            Text("Difference is:")
            Text("\(percentageDifference, specifier: "%.2f") %")
        }
    }
    
    private var clearButton: some View {
        Button(action: {
            sellValue = ""
            boughtValue = ""
        }) {
            Text("Clear")
        }
        .buttonStyle(SimpleButtonStyle())
    }
    
}
