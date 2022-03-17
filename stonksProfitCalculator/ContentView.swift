//
//  ContentView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 02.03.2022.

import SwiftUI

struct ContentView: View {
    
    @State private var selectedView = 1
    
    @FocusState private var focus: Bool
    
    //    var adress: String = "12314ffsd"
    
    // Replace "," with "." function
    
    func convert(text: String) -> String {
        
        let conversion = Double(text.replacingOccurrences(of: ",", with: ".")) ?? 0
        
        return String(conversion)
        
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
        
        let percentageDifference = ((Double(convert(text: sellValue2)) ?? 0) - (Double(convert(text: boughtValue2)) ?? 0)) / (Double(convert(text: boughtValue2)) ?? 0) * 100
        
        return percentageDifference
        
    }
    
    // Tab#3 calculation
    
    var averagePrice: Double {
        
        let totalQuantity: Double = (Double(convert(text: quantityOfTokenFirstBuy)) ?? 0) + (Double(convert(text: quantityOfTokenSecondBuy)) ?? 0)
        
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
    
    // Localization
    
    @State private var putin = false
    
    let ru: Array = ["Цена продажи", "Разница", "Средняя цена", "Настройки", "Очистить", "Готово", "Введи количество монет", "Введи стоимость", "Введи желаемый профит %", "Сумма покупки:", "Поставь ордер по цене:", "Профит составит:", "Цена продажи учитывает комиссию 0,1%", "Введи суммму продажи", "Введи сумму покупки", "Разница составляет:", "Введи количество монет 1ой покупки", "Введи цену 1ой покупки", "Введи количество монет 2ой покупки", "Введи цену 2ой покупки", "Средняя цена:", "Это приложение для моего крипто канала в telegram. Ссылка в описании: @spich3000" ]
    
    let eng: Array = ["Sell Price", "Difference", "Average Price", "Settings", "Clear", "Done", "Enter quantity of token", "Enter bought price", "Enter wanted profit", "Your bought value:", "Set limit order at:", "Your profit:", "Sell price included maker/taker fee 0,1%", "Enter sell value", "Enter bought value", "Difference is:", "Enter amount of token: first buy", "Enter price: first buy", "Enter amount of token: second buy", "Enter price: second buy", "Your average is:", "This is app for my crypto blog in telegram. Link is on my bio: @spich3000"]
    
    func localization(index: Int) -> String {
        switch putin {
        case true: return ru[index]
        default: return eng[index]
        }
    }
    
    var body: some View {
        
        TabView(selection: $selectedView) {
            
            ZStack {
                
                LinearGradient(colors: [.yellow, .yellow], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    TextField(localization(index: 6), text: $quantityOfToken)
                        .modifier(TextFieldClearButton(text: $quantityOfToken))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField(localization(index: 7), text: $boughtPrice)
                        .modifier(TextFieldClearButton(text: $boughtPrice))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField(localization(index: 8), text: $iWantPercentage)
                        .modifier(TextFieldClearButton(text: $iWantPercentage))
                        .modifier(Title())
                        .focused($focus)
                    
                    Text(localization(index: 9))
                        .foregroundColor(.black)
                        .padding(.bottom, -20)
                    
                    Text("\(boughtValue, specifier: "%.2f")$")
                        .foregroundColor(.black)
                        .padding()
                    
                    Text(localization(index: 10))
                        .foregroundColor(.black)
                        .padding(.bottom, -20)
                    
                    Text("\((sellPrice).formatted())$")
                        .foregroundColor(.black)
                        .padding()
                    
                    Text(localization(index: 11))
                        .foregroundColor(.black)
                        .padding(.bottom, -20)
                    
                    Text("\(profitValue, specifier: "%.2f")$")
                        .foregroundColor(.black)
                        .padding()
                    
                }
                
                Button(action: {
                    quantityOfToken = ""
                    boughtPrice = ""
                    iWantPercentage = ""
                }) {
                    Text(localization(index: 4))
                        .modifier(TitleClear())
                }  .padding(.top, 500.0)
                    .shadow(radius: 2)
                
                Text(localization(index: 12))
                    .foregroundColor(.black)
                    .padding(.top, 600.0)
                
            }
            .tabItem {
                Image(systemName: "dollarsign.circle")
                Text(localization(index: 0))
            } .tag(1)
            
            ZStack {
                
                LinearGradient(colors: [.yellow, .yellow], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    TextField(localization(index: 13), text: $sellValue2)
                        .modifier(TextFieldClearButton(text: $sellValue2))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField(localization(index: 14), text: $boughtValue2)
                        .modifier(TextFieldClearButton(text: $boughtValue2))
                        .modifier(Title())
                        .focused($focus)
                    
                    Text(localization(index: 15))
                        .foregroundColor(.black)
                        .padding(.bottom, -1)
                    
                    Text("\(percentageDifference, specifier: "%.2f")%")
                        .foregroundColor(.black)
                    
                }
                
                Button(action: {
                    sellValue2 = ""
                    boughtValue2 = ""
                }) {
                    Text(localization(index: 4))
                        .modifier(TitleClear())
                } .padding(.top, 500)
                    .shadow(radius: 2)
                
            }
            
            .tabItem {
                Image(systemName: "align.vertical.bottom")
                Text(localization(index: 1))
            } .tag(2)
            
            ZStack {
                
                LinearGradient(colors: [.yellow, .yellow], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    TextField(localization(index: 16), text: $quantityOfTokenFirstBuy)
                        .modifier(TextFieldClearButton(text: $quantityOfTokenFirstBuy))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField(localization(index: 17), text: $boughtPriceFirstBuy)
                        .modifier(TextFieldClearButton(text: $boughtPriceFirstBuy))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField(localization(index: 18), text: $quantityOfTokenSecondBuy)
                        .modifier(TextFieldClearButton(text: $quantityOfTokenSecondBuy))
                        .modifier(Title())
                        .focused($focus)
                    
                    TextField(localization(index: 19), text: $boughtPriceSecondBuy)
                        .modifier(TextFieldClearButton(text: $boughtPriceSecondBuy))
                        .modifier(Title())
                        .focused($focus)
                    
                    Text(localization(index: 20))
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
                    Text(localization(index: 4))
                        .modifier(TitleClear())
                } .padding(.top, 500)
                    .shadow(radius: 2)
                
            }
            
            .tabItem {
                Image(systemName: "chart.xyaxis.line")
                Text(localization(index: 2))
            } .tag(3)
            
            ZStack {
                
                LinearGradient(colors: [.yellow, .yellow], startPoint: .top, endPoint: .bottom)
                    .ignoresSafeArea()
                
                VStack {
                    
                    Toggle(isOn: $putin) {
                        Text("Putin mode")
                            .foregroundColor(.black)
                    } .padding()
                    
                    Text(localization(index: 21))
                        .lineSpacing(10)
                        .foregroundColor(.black)
                        .frame(width: 350, height: 200, alignment: .center)
                        .multilineTextAlignment(.center)
                    
                    //                    Text(adress)
                    //                        .contextMenu {
                    //                            Button(action: {
                    //                                UIPasteboard.general.string = adress
                    //                            }) {
                    //                                Text("Copy to clipboard")
                    //                                Image(systemName: "doc.on.doc")
                    //                            }
                    //                        }
                }
                
            }
            .tabItem {
                Image(systemName: "gear")
                Text(localization(index: 3))
            } .tag(4)
            
        }
        
        .onAppear() {
            
            UITabBar.appearance().barTintColor = .gray
            
        } .toolbar {
            ToolbarItemGroup(placement: .keyboard) {
                Button(localization(index: 5)) {
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


