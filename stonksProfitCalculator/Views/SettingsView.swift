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
    @State private var alertMessage = ""

    @EnvironmentObject private var viewModel: PortfolioViewModel

    @AppStorage("isDarkMode") private var isDarkMode = false
        
    // MARK: BODY
    var body: some View {
        ZStack {
            background
            VStack(spacing: 50) {
                colorThemePicker
                VStack {
                    Text("Please export your portfolio so that you can later add it to a new version of the application and not lose data")
                        .padding(.horizontal)
                        .text
                    
                    Button(action: {
                        viewModel.copyPortfolioToJSONToClipboard()
                        showingAlert = true
                        alertMessage = "Portfolio copied successfully to clipboard."
                    }) {
                        Text("Copy Portfolio to clipboard!")
                            .foregroundColor(.primary)
                            .frame(maxWidth: .infinity)
                            .padding()
                    }
                    .padding()
                    .alert(isPresented: $showingAlert) {
                        Alert(title: Text("Save Status"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
                    }
                }
                .buttonStyle(SimpleButtonStyle())
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
