//
//  PortfolioView.swift
//  stonksProfitCalculator
//
//  Created by Дмитрий Спичаков on 18.08.2022.
//

import SwiftUI

struct PortfolioView: View {
    
    @EnvironmentObject private var viewModel: PortfolioViewModel
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    @State var selectedCoin: CoinModel? = nil
    
    @State private var showEditPortfolioView: Bool = false
    @State private var showSettingsView: Bool = false
    @State private var showSellPriceView: Bool = false
    @State private var showDifferenceView: Bool = false

    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            background
            VStack(spacing: 10) {
                totalBalance
                columnTitles
                title
                portfolioCoinsList
                Spacer()
            }
            .ignoresSafeArea(edges: [.bottom])
            buttonsSection
        }
        .onAppear {
            viewModel.coinDataService.getCoins()
        }
        .sheet(isPresented: $showEditPortfolioView) {
            EditPortfolioView(select: $selectedCoin)
                .environmentObject(viewModel)
        }
        .sheet(isPresented: $showSettingsView) {
            SettingsView()
        }
        .sheet(isPresented: $showSellPriceView) {
            SellPriceView()
        }
        .sheet(isPresented: $showDifferenceView) {
            DifferenceView()
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
    
    private var totalBalance: some View {
        HStack(spacing: 4) {
            Text("Total bought value:")
            Text("\(viewModel.portfolioValue.asCurrencyWith2DecimalsPortfolio())$")
            Text((viewModel.portfolioGain >= 0 ? "+" : "") +  "\(viewModel.portfolioGain.asCurrencyWith2DecimalsPortfolio())$")
                .foregroundColor(viewModel.portfolioGain >= 0 ? .green : .red)
        }
        .minimumScaleFactor(0.5)
    }
    
    private var buttonsSection: some View {
        HStack {
            CircleButton(icon: .settings) {
                showSettingsView.toggle()
            }
            Spacer()
            CircleButton(icon: .sellPrice) {
                showSellPriceView.toggle()
            }
            Spacer()
            CircleButton(icon: .difference) {
                showDifferenceView.toggle()
            }
            Spacer()
            CircleButton(icon: .reload) {
                viewModel.reloadData()
            }
            Spacer()
            CircleButton(icon: .edit) {
                showEditPortfolioView.toggle()
                selectedCoin = nil
            }
        }
        .padding(.horizontal, 40)
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
            Button {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .rank ? .rankReversed : .rank
                }
            } label: {
                HStack(spacing: 4.0) {
                    Text("Coin")
                    Image(systemName: "chevron.down")
                        .opacity((viewModel.sortOption == .rank || viewModel.sortOption == .rankReversed) ? 1 : 0)
                        .rotationEffect(Angle(degrees: viewModel.sortOption == .rank ? 0 : 180))
                }
            }
            
            Spacer()
            // MARK: BOUGHT VALUE
            Button {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .boughtValue ? .boughtValueReversed : .boughtValue
                }
            } label: {
                HStack(spacing: 4.0) {
                    HStack {
                        Image(systemName: "chevron.down")
                            .opacity((viewModel.sortOption == .boughtValue || viewModel.sortOption == .boughtValueReversed) ? 1 : 0)
                            .rotationEffect(Angle(degrees: viewModel.sortOption == .boughtValue ? 0 : 180))
                        Text("Bought value")
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
            }
            
            // MARK: CURRENT VALUE
            Button {
                withAnimation(.default) {
                    viewModel.sortOption = viewModel.sortOption == .holdings ? .holdingsReversed : .holdings
                }
            } label: {
                HStack(spacing: 4) {
                    HStack {
                        Image(systemName: "chevron.down")
                            .opacity((viewModel.sortOption == .holdings || viewModel.sortOption == .holdingsReversed) ? 1 : 0)
                            .rotationEffect(Angle(degrees: viewModel.sortOption == .holdings ? 0 : 180))
                        Text("Current value")
                            .lineLimit(1)
                            .minimumScaleFactor(0.5)
                    }
                }
            }
        }
        .font(.caption)
        .padding(.horizontal)
        .buttonStyle(SimpleButtonStyle())
    }
    
    private var portfolioCoinsList: some View {
        ScrollView(showsIndicators: false) {
            VStack {
                ForEach(viewModel.portfolioCoins) { coin in
                    CoinRowView(coin: coin) {
                        withAnimation(.spring()) {
                            showEditPortfolioView.toggle()
                            selectedCoin = coin
                        }
                    }
                    .padding(.horizontal, 8)
                }
            }
            .padding(.top, 10)
            
            Color.clear
                .frame(height: 70)
        }
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
}
