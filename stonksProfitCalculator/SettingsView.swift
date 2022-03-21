//
//  SettingsView.swift
//  stonksProfitCalculator
//
//  Created by Nigel Gee on 20/03/2022.
//

import SwiftUI

struct SettingsView: View {
    @State private var showingAlert = false

    var BTCAdress: String = "1HuiBQEFGLCBgtKsfWjZG2as3NdkVKdeBA"
    
    var body: some View {
        ZStack {
            Color.yellow
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
                    .padding(30)

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
                })
                .frame(width: 120.0, height: 30.0)
                .background(.gray)
                .cornerRadius(10)
                .shadow(radius: 2)
                .padding(.bottom, 30)

                // Donate clipboard with alert
                Text("Feel free for donate (BTC):")
                    .foregroundColor(.black)
                    .padding(.bottom)

                Button {
                    UIPasteboard.general.string = BTCAdress
                    showingAlert = true
                } label: {
                    HStack {
                        Text(BTCAdress)
                        Image(systemName: "doc.on.clipboard")
                    }
                }
                .frame(width: 370.0, height: 40.0)
                .background(.gray)
                .cornerRadius(10)
                .shadow(radius: 2)
                .padding(.bottom, 30)
            }
            .alert(isPresented: $showingAlert) {
                Alert(
                    title: Text("Copied!"),
                    message: Text("Thank You!"),
                    dismissButton: .default(Text("Ok")))
            }
        }
    }


    let ru: Array = ["Цена продажи",
                     "Разница",
                     "Средняя цена",
                     "Настройки",
                     "Удалить",
                     "Готово",
                     "Введи количество монет",
                     "Введи стоимость",
                     "Введи желаемый профит %",
                     "Сумма покупки:",
                     "Поставь ордер по цене:",
                     "Профит составит:",
                     "Цена продажи учитывает комиссию 0,1%",
                     "Введи сумму продажи",
                     "Введи сумму покупки",
                     "Разница составляет:",
                     "Введи количество монет: покупка №1",
                     "Введи цену: покупка №1",
                     "Введи количество монет: покупка №2",
                     "Введи цену: покупка №2",
                     "Средняя цена:",
                     "Это приложение для моего крипто-канала в Telegram. Cледите за новостями!",
                     "Донаты приветствуются (ВТС):",
                     "Информация:",
                     "Адрес скопирован!",
                     "Спасибо, Товарищ!"
    ]

    let eng: Array = ["Sell Price",
                      "Difference",
                      "Average Price",
                      "Settings",
                      "Clear",
                      "Done",
                      "Enter quantity of token",
                      "Enter bought price",
                      "Enter profit you want to receive %",
                      "Your bought value:", "Set limit order at:",
                      "Your profit:",
                      "Sell price included maker/taker fee 0,1%",
                      "Enter sell value", "Enter bought value",
                      "Difference is:",
                      "Enter amount of token: first buy",
                      "Enter price: first buy",
                      "Enter amount of token: second buy",
                      "Enter price: second buy",
                      "Your average price is:",
                      "This is app for my crypto-blog in Telegram. Stay tuned for new features!",
                      "Feel free for donate (BTC):",
                      "About:",
                      "Copied!",
                      "Thank You!"
    ]
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
