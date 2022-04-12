//
//  SettingsView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 22.03.2022.
//

import SwiftUI

struct SettingsView: View {
    
    @State private var showingAlert = false
    
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
                
                Text("Sell price included maker/taker fee 0,1%")
                    .foregroundColor(.black)
                    .multilineTextAlignment(.center)

//                    .frame(width: 330, height: 30, alignment: .center)
                
                Text("This is app for my crypto-blog in Telegram. Stay tuned for new features!")
                    .lineSpacing(10)
                    .foregroundColor(.black)
//                    .frame(width: 330, height: 90, alignment: .center)
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
                } .blockView
                    .padding(.horizontal, 20)

                
                
                VStack(spacing: 15) {
                // Donate clipboard with alert
                Text("Feel free for donate (BTC):")
                    .foregroundColor(.black)
//                    .blockView
                
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
                } //.frame(width: 370.0, height: 40.0)
                    .linkButton
//                    .padding()
                    .alert(isPresented: $showingAlert) {
                        Alert(
                            title: Text("Copied!"),
                            message: Text("Thank You!"),
                            dismissButton: .default(Text("Ok")))
                    }
                } .blockView
                    .padding(.horizontal, 20)

//                Spacer()
                
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

