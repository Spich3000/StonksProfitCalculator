//
//  SettingsView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct SettingsView: View {
    
    // MARK: PROPERTIES
    @State private var showingAlert = false
    @State private var pick: Int = 0
        
    @AppStorage("isDarkMode") private var isDarkMode = false
        
    // MARK: BODY
    var body: some View {
        ZStack {
            background
            VStack(spacing: 30) {
                aboutSection
                colorThemePicker
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

// MARK: PREVIEW
struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SettingsView()
        }
    }
}

// MARK: VIEW COMPONENTS
extension SettingsView {
    
    private var background: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("backgroundWhite"), Color("backgroundGray")]),
            startPoint: UnitPoint(x: 0.2, y: 0.2),
            endPoint: .bottomTrailing
        )
        .ignoresSafeArea()
    }
    
    private var aboutSection: some View {
        VStack(spacing: 25) {
            // About
            Text("About:")
                .font(.largeTitle)
                .underline()
                .text
            Text("This is app for my crypto-blog in Telegram. Stay tuned for new features!")
                .lineSpacing(10)
                .multilineTextAlignment(.center)
                .padding(.horizontal,20)
                .text
            // Telegram redirect
            Link(destination: URL(string: "https://t.me/stonks_signals")!, label: {
                HStack {
                    Text("Telegram:")
                    Image(systemName: "paperplane")
                }
            })
            .buttonStyle(SimpleButtonStyle())
        }
    }
    
    private var colorThemePicker: some View {
        VStack {
            Text("Color scheme:")
                .text
            Picker(selection: $isDarkMode, label: Text("Dark mode"), content: {
                Text("Light").tag(false)
                Text("Dark").tag(true)
            })
                .pickerModifier
                .padding(.horizontal,20)
                .onAppear {
                    PickerViewModifier()
                }
        }
    }
    
}
