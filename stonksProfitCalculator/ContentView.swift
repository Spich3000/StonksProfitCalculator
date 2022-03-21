//
//  ContentView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 02.03.2022.

import SwiftUI

import MobileCoreServices

struct ContentView: View {
    
    @State private var selectedView = 1
    
    @FocusState private var focus: Bool
    
    @State private var showingAlert = false
    
    let BTCAdress: String = "1HuiBQEFGLCBgtKsfWjZG2as3NdkVKdeBA"
    
    // Replace "," with "." function
    
    func convert(text: String) -> String {
        
        let conversion = text.replacingOccurrences(of: ",", with: ".")
        
        return conversion
        
    }
    
    // Variable for Tab#1
    
    @State private var quantityOfToken = ""
    @State private var boughtPrice = ""
    @State private var iWantPercentage = ""
    
    // Variable for Tab#2
    
    @State private var sellValue2 = ""
    @State private var boughtValue2 = ""
    
    // Variable for Tab#3
    
    @State private var quantityOfTokenFirstBuy = ""
    @State private var boughtPriceFirstBuy = ""
    @State private var quantityOfTokenSecondBuy = ""
    @State private var boughtPriceSecondBuy = ""
    
    // Tab#1 calculation
    
    var boughtValue: Double {
        
        let boughtValue = ((Double(convert(text: quantityOfToken)) ?? 0) * (Double(convert(text: boughtPrice)) ?? 0) * 1.001)
        
        return boughtValue
        
    }
    
    var sellPrice: Double {
        
        let sellPrice = ((Double(convert(text: boughtPrice)) ?? 0) * ((1 + (Double(convert(text: iWantPercentage)) ?? 0) / 100) + 0.001))
        
        return sellPrice
    }
    
    var sellValue: Double {
        
        let sellValue = (Double(convert(text: quantityOfToken)) ?? 0) * sellPrice
        
        return sellValue
    }
    
    var profitValue: Double {
        
        let profitValue = sellValue - boughtValue
        
        return profitValue
    }
    
    // Tab#2 calculation
    
    var percentageDifference: Double {
        
        let percentageDifference = ((Double(convert(text: sellValue2)) ?? 0) - (Double(convert(text: boughtValue2)) ?? 0)) / (Double(convert(text: boughtValue2)) ?? 100) * 100
        
        return percentageDifference
        
    }
    
    // Tab#3 calculation
    
    var averagePrice: Double {
        
        let totalQuantity: Double = (Double(convert(text: quantityOfTokenFirstBuy)) ?? 0) + (Double(convert(text: quantityOfTokenSecondBuy)) ?? 1)
        
        let v1 = (Double(convert(text: quantityOfTokenFirstBuy)) ?? 0) * (Double(convert(text: boughtPriceFirstBuy)) ?? 0)
        
        let v2 = (Double(convert(text: quantityOfTokenSecondBuy)) ?? 0) * (Double(convert(text: boughtPriceSecondBuy)) ?? 0)
        
        let totalValue = ( v1 + v2 ) * 1.001
        
        let averagePrice = (totalValue / totalQuantity)
        
        return averagePrice
        
    }
    
    // TextField modifier
    
    struct Title: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .colorInvert()
                .accentColor(.gray)
                .padding(.horizontal, 35.0)
                .padding(.bottom, 20.0)
                .shadow(radius: 2)
                .keyboardType(.decimalPad)
        }
    }
    
    // ClearButton modifier
    
    struct TitleClear: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .frame(width: 80.0, height: 25.0)
                .background(.gray)
                .cornerRadius(10)
        }
    }
    
    // TextFieldClearButton
    
    struct TextFieldClearButton: ViewModifier {
        
        @Binding var text: String
        
        func body(content: Content) -> some View {
            
            ZStack(alignment: .trailing) {
                
                content
                
                if !text.isEmpty {
                    
                    Button(
                        action: { self.text = "" },
                        label: {
                            Image(systemName: "multiply.circle")
                                .padding(.trailing)
                        }
                    )
                }
            }
        }
    }
    
    var body: some View {
        
        TabView(selection: $selectedView) {
            
            ZStack {
                
                LinearGradient(colors: [.yellow, .yellow], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    TextField("Enter quantity of token", text: $quantityOfToken)
                        .modifier(TextFieldClearButton(text: $quantityOfToken))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField("Enter bought price", text: $boughtPrice)
                        .modifier(TextFieldClearButton(text: $boughtPrice))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField("Enter profit you want to receive %", text: $iWantPercentage)
                        .modifier(TextFieldClearButton(text: $iWantPercentage))
                        .modifier(Title())
                        .focused($focus)
                    
                    Text("Your bought value:")
                        .foregroundColor(.black)
                        .padding(.bottom, -20)
                    
                    Text("\(boughtValue, specifier: "%.2f") $")
                        .foregroundColor(.black)
                        .padding()
                    
                    Text("Set limit order at:")
                        .foregroundColor(.black)
                        .padding(.bottom, -20)
                    
                    Text("\((sellPrice).formatted()) $")
                        .foregroundColor(.black)
                        .padding()
                    
                    Text("Your profit:")
                        .foregroundColor(.black)
                        .padding(.bottom, -20)
                    
                    Text("\(profitValue, specifier: "%.2f") $")
                        .foregroundColor(.black)
                        .padding()
                    
                }
                
                Button(action: {
                    quantityOfToken = ""
                    boughtPrice = ""
                    iWantPercentage = ""
                }) {
                    Text("Clear")
                        .modifier(TitleClear())
                }  .padding(.top, 500.0)
                    .shadow(radius: 2)
                
            }
            .tabItem {
                Image(systemName: "dollarsign.circle")
                Text("Sell price")
            } .tag(1)
            
            ZStack {
                
                LinearGradient(colors: [.yellow, .yellow], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    TextField("Enter sell value", text: $sellValue2)
                        .modifier(TextFieldClearButton(text: $sellValue2))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField("Enter bought value", text: $boughtValue2)
                        .modifier(TextFieldClearButton(text: $boughtValue2))
                        .modifier(Title())
                        .focused($focus)
                    
                    Text("Difference is:")
                        .foregroundColor(.black)
                        .padding(.bottom, -1)
                    
                    Text("\(percentageDifference, specifier: "%.2f") %")
                        .foregroundColor(.black)
                    
                }
                
                Button(action: {
                    sellValue2 = ""
                    boughtValue2 = ""
                }) {
                    Text("Clear")
                        .modifier(TitleClear())
                } .padding(.top, 500)
                    .shadow(radius: 2)
                
            }
            
            .tabItem {
                Image(systemName: "align.vertical.bottom")
                Text("Difference")
            } .tag(2)
            
            ZStack {
                
                LinearGradient(colors: [.yellow, .yellow], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    TextField("Enter amount of token: first buy", text: $quantityOfTokenFirstBuy)
                        .modifier(TextFieldClearButton(text: $quantityOfTokenFirstBuy))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField("Enter price: first buy", text: $boughtPriceFirstBuy)
                        .modifier(TextFieldClearButton(text: $boughtPriceFirstBuy))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField("Enter amount of token: second buy", text: $quantityOfTokenSecondBuy)
                        .modifier(TextFieldClearButton(text: $quantityOfTokenSecondBuy))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField("Enter price: second buy", text: $boughtPriceSecondBuy)
                        .modifier(TextFieldClearButton(text: $boughtPriceSecondBuy))
                        .modifier(Title())
                        .focused($focus)
                    
                    Text("Your average price is:")
                        .foregroundColor(.black)
                        .padding(.bottom, -1)
                    
                    Text("\((averagePrice).formatted()) $")
                        .foregroundColor(.black)
                    
                }
                
                Button(action: {
                    quantityOfTokenFirstBuy = ""
                    boughtPriceFirstBuy = ""
                    quantityOfTokenSecondBuy = ""
                    boughtPriceSecondBuy = ""
                }) {
                    Text("Clear")
                        .modifier(TitleClear())
                } .padding(.top, 500)
                    .shadow(radius: 2)
                
            }
            
            .tabItem {
                Image(systemName: "chart.xyaxis.line")
                Text("Average Price")
            } .tag(3)
            
            ZStack {
                
                LinearGradient(colors: [.yellow, .yellow], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    // About
                    
                    Text("About:")
                        .font(.largeTitle)
                        .foregroundColor(.black)
                        .padding(.bottom, 10)
                    
                    Text("Sell price included maker/taker fee 0,1%")
                        .foregroundColor(.black)
                        .frame(width: 350, height: 60, alignment: .center)
                        .padding(10)
                    
                    Text("This is app for my crypto-blog in Telegram. Stay tuned for new features!")
                        .lineSpacing(10)
                        .foregroundColor(.black)
                        .frame(width: 350, height: 60, alignment: .center)
                        .multilineTextAlignment(.center)
                        .padding(.bottom, 30)
                    
                    // Telegram redirect
                    
                    Link(destination: URL(string: "https://t.me/stonks_signals")!, label: {
                        HStack {
                            Text("Telegram:")
                                .foregroundColor(.black)
                            Image(systemName: "paperplane")
                        }
                    }) .frame(width: 120.0, height: 30.0)
                        .background(.gray)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.bottom, 30)
                    
                    // Donate clipboard with alert
                    
                    Text("Feel free for donate (BTC):")
                        .foregroundColor(.black)
                        .padding(.bottom, 30)
                    
                    Button(action: {
                        UIPasteboard.general.string = BTCAdress
                        showingAlert = true
                    }) {
                        HStack {
                            Text(BTCAdress)
                            Image(systemName: "doc.on.clipboard")
                        }
                    } .frame(width: 370.0, height: 40.0)
                        .background(.gray)
                        .cornerRadius(10)
                        .shadow(radius: 2)
                        .padding(.bottom, 30)
                    
                        .alert(isPresented: $showingAlert) {
                            Alert(
                                title: Text("Copied!"),
                                message: Text("Thank You!"),
                                dismissButton: .default(Text("Ok")))
                        }
                }
            }
            .tabItem {
                Image(systemName: "gear")
                Text("Settings")
            } .tag(4)
        }
        
        .onAppear() {
            
            UITabBar.appearance().barTintColor = .gray
            
        } .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button("Done") {
                    focus = false
                } .foregroundColor(.yellow)
            }
        }
        .accentColor(.black)
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            ContentView()
        }
    }
}
