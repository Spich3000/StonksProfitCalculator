//
//  EditPortfolioView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 19.08.2022.
//

import SwiftUI

struct EditPortfolioView: View {
    
    @Environment(\.dismiss) var dismiss
    
    @EnvironmentObject private var viewModel: PortfolioViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State private var selectedCoin: CoinModel? = nil
    
    @State private var quantityText: String = ""
    @State private var boughtPriceString: String = ""
    @State var isAddBuyShown = false
    @State private var newQuantityText: String = ""
    @State private var newBoughtPriceString: String = ""
    
    @State private var showDeleteConfirmation: Bool = false
    
    @Binding var select: CoinModel?
    
    var body: some View {
        ZStack {
            background
            ScrollView {
                VStack(alignment: .leading) {
                    buttonsBar
                    SearchBarView(searchText: $viewModel.searchText)
                    coinLogoList
                    inputSection
                }
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
        .onChange(of: viewModel.searchText) { newValue in
            if newValue == "" {
                removeSelectedCoin()
            }
        }
        .onAppear {
            if let select = select {
                updateSelectedCoin(coin: select)
            }
        }
        .onTapGesture {
                UIApplication.shared.endEditing()
        }
    }
    
    @ViewBuilder
    private var inputSection: some View {
        if selectedCoin != nil {
            portfolioInputSection
            addBuyButton
            if isAddBuyShown && !boughtPriceString.isEmpty {
                portfolioInputSectionNewBuy
            }
        }
    }
    
    private var coinLogoList: some View {
          ScrollView(.horizontal, showsIndicators: false) {
              ScrollViewReader { scrollView in
                  LazyHStack(spacing: 0) {
                      ForEach(viewModel.searchText.isEmpty ? viewModel.portfolioCoins : viewModel.allCoins) { coin in
                          CoinLogoView(coin: coin)
                              .id(coin.id)
                              .frame(width: 75, height: 75)
                              .onTapGesture {
                                  withAnimation(.easeIn) {
                                      updateSelectedCoin(coin: coin)
                                  }
                              }
                              .background(
                                  RoundedRectangle(cornerRadius: 10)
                                      .stroke(
                                        selectedCoin?.id == coin.id ? Color.green : Color.clear,
                                        lineWidth: 1)
                              )
                      }
                  }
                  .padding()
                  .onAppear {
                      // Scroll to the selected coin when it changes
                      if let selectedCoin = selectedCoin {
                          scrollView.scrollTo(selectedCoin.id, anchor: .center)
                      }
                  }
              }
          }
      }
    
    private var deleteButton: some View {
        Button {
            showDeleteConfirmation.toggle()
        } label: {
            Text("Delete")
                .lineLimit(1)
        }
        .opacity((selectedCoin != nil ? 1.0 : 0.3))
        .disabled((selectedCoin != nil ? false : true))
        .confirmationDialog("Confirm Deletion", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                quantityText = "0"
                savedButtonPressed()
                selectedCoin = nil
                dismiss()
            }
        }
    }
    
    private var buttonsBar: some View {
        HStack {
            backButton
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

// MARK: VIEW COMPONENTS
extension EditPortfolioView {
    
    private var backButton: some View {
        Button(action: {
            viewModel.searchText = ""
            selectedCoin = nil
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
    
    // MARK: UPDATE COIN FUNC
    private func updateSelectedCoin(coin: CoinModel) {
        selectedCoin = coin
        if let portfolioCoin = viewModel.portfolioCoins.first(where: { $0.id == coin.id }),
           let amount = portfolioCoin.currentHoldings,
           let boughtPrice = portfolioCoin.boughtPrice?.asCurrencyWith2or7Decimals() {
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
                Text("Second amount:")
                Spacer()
                TextField("Enter quantity of token", text: $newQuantityText)
                    .multilineTextAlignment(.trailing)
                    .keyboardType(.decimalPad)
            }
            Divider()
            HStack {
                Text("Second bought price:")
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
            selectedCoin = nil
            dismiss()
        } label: {
            Text("Save")
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
        else {
            return
        }
        
        if !newQuantityText.isEmpty && !newBoughtPriceString.isEmpty {
            // Calculation for input "Amount of tokens"
            var totalQuantity: Double {
                (Double(convert(text: quantityText)) ?? Double()) + (Double(convert(text: newQuantityText)) ?? Double())
            }
            
            let value1 = (Double(convert(text: quantityText)) ?? 0) * (Double(convert(text: boughtPriceString)) ?? Double())
            let value2 = (Double(convert(text: newQuantityText)) ?? 0) * (Double(convert(text: newBoughtPriceString)) ?? Double())
            let totalValue = value1 + value2
            
            let averagePriceOfTokens = totalValue / totalQuantity

            // save to portfolio
            viewModel.updatePortfolio(coin: coin, amount: totalQuantity, boughtPrice: averagePriceOfTokens)
            withAnimation(.easeIn) {
                removeSelectedCoin()
                newQuantityText = ""
                newBoughtPriceString = ""
            }
            
        } else {
            // save to portfolio
            viewModel.updatePortfolio(coin: coin, amount: amount, boughtPrice: boughtPrice)
            withAnimation(.easeIn) {
                removeSelectedCoin()
            }
        }
        
        // hide keyboard
        UIApplication.shared.endEditing()
    }
    
    // MARK: REMOVE SELECT
    private func removeSelectedCoin() {
        selectedCoin = nil
        viewModel.searchText = ""
    }
}

struct EditPortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        EditPortfolioView(select: .constant(nil))
            .environmentObject(dev.portfolioViewModel)
    }
}
