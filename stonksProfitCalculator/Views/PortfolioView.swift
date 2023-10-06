//
//  PortfolioView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 18.08.2022.
//

import SwiftUI

struct PortfolioView: View {
    
    // MARK: PROPERTIES
    @EnvironmentObject private var viewModel: PortfolioViewModel
    @AppStorage("isDarkMode") private var isDarkMode = false
    @State private var showEditPortfolioView: Bool = false
    @State var selectedCoin: CoinModel? = nil
    
    // MARK: BODY
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            background
            VStack(spacing: 5) {
                totalBalance
                columnTitles
                title
                portfolioCoinsList
                Spacer()
            }
            buttonsSection
        }
        .onAppear {
            viewModel.coinDataService.getCoins()
        }
        .sheet(isPresented: $showEditPortfolioView) {
            EditPortfolioView(select: $selectedCoin)
                .environmentObject(viewModel)
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    private var totalBalance: some View {
        VStack(alignment: .center) {
            HStack(spacing: 4) {
                Text("Total bought value:")
                Text("\(viewModel.portfolioValue.asCurrencyWith2DecimalsPortfolio())$")
                Text((viewModel.portfolioGain >= 0 ? "+" : "") +  "\(viewModel.portfolioGain.asCurrencyWith2DecimalsPortfolio())$")
                    .foregroundColor(viewModel.portfolioGain >= 0 ? .green : .red)
            }
        }
        .font(.caption)
    }
    
    private var buttonsSection: some View {
        HStack(spacing: 20) {
            reloadDataButton
            editPortfolioButton
        }
        .padding(20)
    }
}

//MARK: PREVIEW
struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
            .environmentObject(dev.portfolioViewModel)
    }
}

//MARK: VIEW COMPONENTS
extension PortfolioView {

    private var columnTitles: some View {
        HStack {
            // MARK: COIN RANK
            HStack(spacing: 4.0) {
                Text("Coin")
                Image(systemName: "chevron.down")
                    .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1 : 0)
                    .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            }
            Spacer()
            // MARK: BOUGHT VALUE
            HStack(spacing: 4.0) {
                HStack {
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .boughtValue || viewModel.sortOption == .boughtValueReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .boughtValue ? 0 : 180))
                    Text("Bought value")
                }
            }
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .boughtValue ? .boughtValueReversed : .boughtValue
                }
            }
            // MARK: CURRENT VALUE
            HStack(spacing: 4) {
                HStack {
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                    Text("Current value")
                }
            }
            .frame(width: UIScreen.main.bounds.width / 3.5, alignment:  .trailing)
            .onTapGesture {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                }
            }
        }
        .font(.caption)
        .padding(.horizontal)
    }
    
    // MARK: EDIT PORTFOLIO
    private var editPortfolioButton: some View {
        HStack {
            Button {
                withAnimation(.spring()) {
                    showEditPortfolioView.toggle()
                    selectedCoin = nil
                }
            } label: {
                Image(systemName: "plus")
            }
            .buttonStyle(SimpleButtonStyle(isCircle: true))
        }
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin)
                // Some kind of paddings to each row in list
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .listRowBackground(Color.clear)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showEditPortfolioView.toggle()
                            selectedCoin = coin
                        }
                    }
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var title: some View {
        ZStack(alignment: .top) {
            if viewModel.portfolioCoins.isEmpty && viewModel.searchText.isEmpty {
                Text("There are no coins in your portfolio. Press **\"+\"** button to add your coins!")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(60)
            }
        }
    }
    
    // MARK: RELOAD DATA BUTTON
    private var reloadDataButton: some View {
        Button {
            withAnimation(.linear(duration: 2)) {
                viewModel.reloadData()
            }
        } label: {
            Image(systemName: "repeat")
                .foregroundColor(.primary)
                .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0), anchor: .center)
        }
        .buttonStyle(SimpleButtonStyle(isCircle: true))
    }
}
