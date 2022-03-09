//
//  ContentView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 02.03.2022.

import SwiftUI

struct ContentView: View {
    
    //probuem ubrat' keyboard
//    enum Field: Hashable {
//            case myField
//        }
    
    @State private var selectedView = 1
    
    //probuem ubrat' keyboard
//    @FocusState private var focusedField: Field?
    
    // Tab1 var
    
    @State private var quantityOfToken = ""
    
    // I tried to make some value check
    
//    func didSet() -> String {
//        if Double(quantityOfToken) ?? 0 <= 0 {
//            quantityOfToken = "Insert Value"
//        }
//        return quantityOfToken
//    }
    
    @State private var boughtPrice = ""
    @State private var iWantPercentage = ""
    
    //Tab2 var
    
    @State private var sellValue2 = ""
    @State private var boughtValue2 = ""
    
    //Tab3 var
    
    @State private var quantityOfTokenFirstBuy = ""
    @State private var boughtPriceFirstBuy = ""
    @State private var quantityOfTokenSecondBuy = ""
    @State private var boughtPriceSecondBuy = ""
    
    // Tab1 form
    
    var boughtValue: Double {
        
        let boughtValue = ((Double(quantityOfToken) ?? 0) * (Double(boughtPrice) ?? 0) * 1.001)
        
        return boughtValue
     
    }
    
    var sellPrice: Double {
        
        let sellPrice = ((Double(boughtPrice) ?? 0) * ((1 + (Double(iWantPercentage) ?? 0) / 100) + 0.001))
        
        return sellPrice
    }
    
    var sellValue: Double {
        
        let sellValue = (Double(quantityOfToken) ?? 0) * sellPrice
        
        return sellValue
    }
    
    var profitValue: Double {
        
        let profitValue = sellValue - boughtValue
        
        return profitValue
    }
    
    // Tab2 form
    
    var percentageDifference: Double {
        
        let percentageDifference = ((Double(sellValue2) ?? 0) - (Double(boughtValue2) ?? 0)) / (Double(boughtValue2) ?? 0) * 100
        
        return percentageDifference
        
    }
    
    // Tab3 form
    
    var averagePrice: Double {
        
        let totalQuantity: Double = (Double(quantityOfTokenFirstBuy) ?? 0) + (Double(quantityOfTokenSecondBuy) ?? 0)
        
        let v1 = (Double(quantityOfTokenFirstBuy) ?? 0) * (Double(boughtPriceFirstBuy) ?? 0)
        
        let v2 = (Double(quantityOfTokenSecondBuy) ?? 0) * (Double(boughtPriceSecondBuy) ?? 0)
        
        let totalValue = ( v1 + v2 ) * 1.001
        
        let averagePrice = (totalValue / totalQuantity)
        
        return averagePrice
        
    }
    
    //    let formatter: NumberFormatter = {
    //           let formatter = NumberFormatter()
    //           formatter.numberStyle = .decimal
    //           return formatter
    //       }()
    
    struct Title: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .colorInvert()
                .accentColor(.gray)
                .padding(.horizontal, 35.0)
                .padding(.bottom, 20.0)
                .shadow(radius: 2)
        }
        
    }
    
    struct TitleClear: ViewModifier {
        
        func body(content: Content) -> some View {
            content
                .frame(width: 80.0, height: 25.0)
                .background(.gray)
                .cornerRadius(10)
        }
        
    }
    
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
//                        .focused($focusedField, equals: .myField)
//                        .keyboardType(.numberPad)
//                        .toolbar {
//                                ToolbarItemGroup(placement: .keyboard) {
//                                        Button("Done") {
//                                           focusedField = nil
//                                        }
//                                    }
//                                }
                        
                    TextField("Enter bought price", text: $boughtPrice)
                        .modifier(TextFieldClearButton(text: $boughtPrice))
                        .modifier(Title())
                    
                    TextField("Enter wanted profit %", text: $iWantPercentage)
                        .modifier(TextFieldClearButton(text: $iWantPercentage))
                        .modifier(Title())
                    
                    Text("Your bought value:")
                        .foregroundColor(.black)
                        .padding(.bottom, -20)
                    
                    Text("\(boughtValue, specifier: "%.2f")$")
                        .foregroundColor(.black)
                        .padding()
                    
                    Text("Set limit order at:")
                        .foregroundColor(.black)
                        .padding(.bottom, -20)
                    
                    Text("\((sellPrice).formatted())$")
                        .foregroundColor(.black)
                        .padding()
                    
                    Text("Your profit:")
                        .foregroundColor(.black)
                        .padding(.bottom, -20)
                    
                    Text("\(profitValue, specifier: "%.2f")$")
                        .foregroundColor(.black)
                        .padding()
                    
//                    Button("Dismiss") {
//                               focusedField = nil
//                    }
                }
                    
                
                
                Button(action: {
                    quantityOfToken = ""
                    boughtPrice = ""
                    iWantPercentage = ""
                }) {
                    Text("Clear")
                        .modifier(TitleClear())
                }  .padding(.top, 450.0)
                   .shadow(radius: 2)
                
                Text("Sell price included maker/taker fee 0.1%")
                    .foregroundColor(.black)
                    .padding(.top, 550.0)
                
            }
            .tabItem {
                Image(systemName: "dollarsign.circle")
                Text("Sell Price")
            } .tag(1)
            
            ZStack {
                
                LinearGradient(colors: [.yellow, .yellow], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    TextField("Enter sell value", text: $sellValue2)
                        .modifier(TextFieldClearButton(text: $sellValue2))
                        .modifier(Title())
                    
                    TextField("Enter bought value", text: $boughtValue2)
                        .modifier(TextFieldClearButton(text: $boughtValue2))
                        .modifier(Title())
                    
                    Text("Difference is:")
                        .foregroundColor(.black)
                        .padding(.bottom, -1)
                    
                    Text("\(percentageDifference, specifier: "%.2f")%")
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
                    
                    TextField("Enter price: first buy", text: $boughtPriceFirstBuy)
                        .modifier(TextFieldClearButton(text: $boughtPriceFirstBuy))
                        .modifier(Title())
                    
                    TextField("Enter amount of token: second buy", text: $quantityOfTokenSecondBuy)
                        .modifier(TextFieldClearButton(text: $quantityOfTokenSecondBuy))
                        .modifier(Title())
                    
                    TextField("Enter price: second buy", text: $boughtPriceSecondBuy)
                        .modifier(TextFieldClearButton(text: $boughtPriceSecondBuy))
                        .modifier(Title())
                    
                    Text("Your average price is:")
                        .foregroundColor(.black)
                        .padding(.bottom, -1)
                    
                    Text("\((averagePrice).formatted())$")
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
                    
                    Text("This is app for my crypto blog in telegram.")
                        .foregroundColor(.black)
                        .padding(.bottom, 1)
                    
                    Text("Link is on my bio: @spich3000")
                        .foregroundColor(.black)
                    
                }
                
            }
            
            .tabItem {
                Image(systemName: "info.circle")
                Text("About")
            } .tag(4)
            
        }
        
        .onAppear() {
            
            UITabBar.appearance().barTintColor = .gray
            
        }
        
        .accentColor(.black)
        
    }

}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


