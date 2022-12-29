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
    @State var isAddBuyShown = false
    @State private var newQuantityText: String = ""
    @State private var newBoughtPriceString: String = ""
    
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
                        addBuyButton
                        if isAddBuyShown && !boughtPriceString.isEmpty {
                            portfolioInputSectionNewBuy
                        }
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
    
    // MARK: BACKGROUND
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
    
    // MARK: ADD BUY BUTTON
    private var addBuyButton: some View {
        HStack {
            Spacer()
            Button(action: {
                if !quantityText.isEmpty && !boughtPriceString.isEmpty {
                    isAddBuyShown.toggle()
                }
            }) {
                HStack {
                    Image(systemName: "plus")
                    Text("Add buy")
                }
            }
            .buttonStyle(SimpleButtonStyle())
            Spacer()
        }
    }
    
    // MARK: COINS LIST
    private var coinLogoList: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            LazyHStack(spacing: 10) {
                ForEach(viewModel.searchText.isEmpty ? viewModel.portfolioCoins : viewModel.allCoins) { coin in
                    CoinLogoView(coin: coin)
                        .frame(width: 75, height: 75)
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
    
    // MARK: UPDATE COIN FUNC
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
    
    // MARK: INPUT SECTION
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
    
    // MARK: SECOND BUY INPUT SECTION
    private var portfolioInputSectionNewBuy: some View {
        VStack(spacing: 20) {
            Divider()
            HStack {
                Text("New amount holding:")
                Spacer()
                TextField("Enter quantity of token", text: $newQuantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("New bought price:")
                Spacer()
                TextField("Enter bought price", text: $newBoughtPriceString)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
        }
        .padding()
        .font(.headline)
    }
    
    // MARK: SAVE BUTTON
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
    
    // MARK: DELETE BUTTON
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
    
    // MARK: SAVE BUTTON FUNCTION
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
    
    // MARK: REMOVE SELECT
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
    
    // MARK: UPPER BUTTONS SECTION
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
