//
//  EditPortfolioView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 19.08.2022.
//

import SwiftUI

struct EditPortfolioView: View {
    
    // MARK: PPROPERTIES
    @Environment(\.dismiss) var dismiss
    @EnvironmentObject private var viewModel: PortfolioViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false

    @State private var selectedCoin: CoinModel? = nil
    @State private var quantityText: String = ""
    @State private var boughtPriceString: String = ""
    
    // MARK: BODY
    var body: some View {
        ZStack {
            background
            ScrollView {
                VStack(alignment: .leading) {
                    buttonsBar
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    if selectedCoin != nil {
                        portfolioInputSection
                    }
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onChange(of: viewModel.searchText) { newValue in
            if newValue == "" {
                removeSelectedCoin()
            }
        }
    }
}

// MARK: PREVIEW
struct EditPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditPortfolioView()
            .environmentObject(dev.portfolioViewModel)
    }
}

// MARK: VIEW COMPONENTS
extension EditPortfolioView {
    
    private var background: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("backgroundWhite"), Color("backgroundGray")]),
            startPoint: UnitPoint(x: 0.2, y: 0.2),
            endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
    
    private var dismissButton: some View {
        Button(action: {
            viewModel.searchText = ""
            dismiss()
        }, label: {
            HStack {
                Image(systemName: "chevron.left")
                Text("Back")
                    .lineLimit(1)
            }
        })
    }
    
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.searchText.isEmpty ? viewModel.portfolioCoins : viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75, height: 100)
                        .padding(4)
                        .onTapGesture {
                            withAnimation(.easeIn) {
                                updateSelectedCoin(coin: coin)
                            }
                        }
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedCoin?.id == coin.id ? Color.green : Color.clear, lineWidth: 1))
                }
            }
            .padding()
        }
    }
    
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = viewModel.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings,
           let boughtPrice = portfolioCoin.boughtPrice {
            quantityText = "\(amount)"
            boughtPriceString = "\(boughtPrice)"
        } else {
            quantityText = ""
            boughtPriceString = ""
        }
    }
    
    private var portfolioInputSection: some View {
        VStack(spacing: 20) {
            Divider()
            HStack {
                Text("Amount holding:")
                Spacer()
                TextField("Enter quantity of token", text: $quantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Bought price:")
                Spacer()
                TextField("Enter bought price", text: $boughtPriceString)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
        }
        .padding()
        .font(.headline)
    }
    
    private var saveButton: some View {
            Button {
                savedButtonPressed()
            } label: {
                Text("Save")
                    .lineLimit(1)
            }
            .opacity((selectedCoin != nil ? 1.0 : 0.3))
            .disabled((selectedCoin != nil ? false : true))
    }
    
    private var deleteButton: some View {
            Button {
                quantityText = "0"
                savedButtonPressed()
            } label: {
                Text("Delete")
                    .lineLimit(1)
            }
            .opacity((selectedCoin != nil ? 1.0 : 0.3))
            .disabled((selectedCoin != nil ? false : true))
    }
    
    private func savedButtonPressed() {
        guard
            let coin = selectedCoin,
            let amount = Double(convert(text: quantityText)),
            let boughtPrice = Double(convert(text: boughtPriceString))
        else { return }
        // save to portfolio
        viewModel.updatePortfolio(coin: coin, amount: amount, boughtPrice: boughtPrice)
        withAnimation(.easeIn) {
            removeSelectedCoin()
        }
        // hide keyboard
        UIApplication.shared.endEditing()
    }
    
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
    
    private var buttonsBar: some View {
        HStack {
            dismissButton
            Spacer()
            deleteButton
            Spacer()
            saveButton
        }
        .buttonStyle(SimpleButtonStyle())
        .padding(.horizontal, 20)
        .padding(.vertical)
    }
    
}
