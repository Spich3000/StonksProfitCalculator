//
//  SettingsView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var showingAlert = false
    
//    @State private var commission: Int = 0
//
//    let commissions = [0.0, 0.0005, 0.001, 0.002]
//
//    var commissionRate: Double {
//        return Double(commissions[commission])
//    }
    
    init() {PickerViewModifier()}
    
    var BTCAdress: String = "1HuiBQEFGLCBgtKsfWjZG2as3NdkVKdeBA"
    
    var body: some View {
        ZStack {
            Color.yellow
                .ignoresSafeArea()
            
            VStack(spacing: 30) {
                VStack(spacing: 25) {
                    // About
                    Text("About:")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .underline()
                    Text("This is app for my crypto-blog in Telegram. Stay tuned for new features!")
                        .lineSpacing(10)
                        .foregroundColor(.black)
                        .multilineTextAlignment(.center)
                    // Telegram redirect
                    Link(destination: URL(string: "https://t.me/stonks_signals")!, label: {
                        HStack {
                            Text("Telegram:")
                                .foregroundColor(.black)
                            Image(systemName: "paperplane")
                        }
                    }) .frame(width: 120.0, height: 30.0)
                        .linkButton
                } //VStack About
                .blockView
                
                //VStack Donate
                VStack(spacing: 15) {
                    // Donate clipboard with alert
                    Text("Feel free for donate (BTC):")
                        .foregroundColor(.black)
                    
                    Button(action: {
                        UIPasteboard.general.string = BTCAdress
                        showingAlert = true
                    }) {
                        HStack {
                            Text(BTCAdress)
                                .multilineTextAlignment(.center)
                                .foregroundColor(.black)
                                .padding()
                            Image(systemName: "doc.on.clipboard")
                                .foregroundColor(.black)
                                .padding(.horizontal, 10)
                        }
                    }
                    .linkButton
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Copied!"),
                            message: Text("Thank You!"),
                            dismissButton: .default(Text("Ok")))
                    }
                } //VStack Donate
                .blockView
                
//                VStack {
//                    Text("Select exchange commission rate:")
//                        .foregroundColor(.black)
//                    Picker("Select exchange commission rate", selection: $commission) {
//                        ForEach(0..<commissions.count) {
//                            Text("\((self.commissions[$0]).formatted()) %")
//                        }
//                    } .pickerModifier
//
//                    Text("\(commissionRate)")
//                        .foregroundColor(.black)
//
//                } //VStack select commission
//                .blockView
            }
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            SettingsView()
        }
    }
}

