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
    
    // MARK: BODY
    var body: some View {
        ZStack {
            background
                .sheet(isPresented: $showEditPortfolioView) {
                    EditPortfolioView()
                        .environmentObject(viewModel)
                }
            VStack {
                HStack {
                    reloadDataButton
                    Spacer()
                    editPortfolioButton
                }
                columnTitles
                title
                portfolioCoinsList
                columnTotal
                Spacer()
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
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
    private var background: some View {
        LinearGradient(
            gradient: Gradient(colors: [Color("backgroundWhite"), Color("backgroundGray")]),
            startPoint: UnitPoint(x: 0.2, y: 0.2),
            endPoint: .bottomTrailing)
        .ignoresSafeArea()
    }
    
    private var columnTitles: some View {
        HStack {
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
    
    private var editPortfolioButton: some View {
        HStack {
            Button {
                withAnimation(.spring()) {
                    showEditPortfolioView.toggle()
                }
            } label: {
                HStack {
                    Image(systemName: "square.and.pencil")
                    Text("Edit portfolio")
                }
            }
            .buttonStyle(SimpleButtonStyle())
        }
        .padding()
    }
    
    private var portfolioCoinsList: some View {
        List {
            ForEach(viewModel.portfolioCoins) { coin in
                CoinRowView(coin: coin)
                // Some kind of paddings to each row in list
                    .listRowInsets(.init(top: 10, leading: 0, bottom: 10, trailing: 10))
                    .listRowBackground(Color.clear)
            }
        }
        .listStyle(PlainListStyle())
    }
    
    private var title: some View {
        ZStack(alignment: .top) {
            if viewModel.portfolioCoins.isEmpty && viewModel.searchText.isEmpty {
                Text("There are no coins in your portfolio. Press **\"Edit portfolio\"** button to add your coins!")
                    .multilineTextAlignment(.center)
                    .foregroundColor(.secondary)
                    .padding(60)
            }
        }
    }
    
    private var reloadDataButton: some View {
        Button {
            withAnimation(.linear(duration: 2)) {
                viewModel.reloadData()
            }
        } label: {
            Image(systemName: "goforward")
                .foregroundColor(.primary)
                .rotationEffect(Angle(degrees: viewModel.isLoading ? 360 : 0), anchor: .center)
        }
        .buttonStyle(SimpleButtonStyle())
        .padding()
    }
    
    private var columnTotal: some View {
        VStack(alignment: .center) {
            HStack(spacing: 4) {
                Text("Total bought value:")
                Text("\(viewModel.portfolioValue.asCurrencyWith2DecimalsPortfolio())$")
            }
            HStack(spacing: 4) {
                Text("Total current value:")
                Text("\(viewModel.currentPortfolioValue.asCurrencyWith2DecimalsPortfolio())$")
                Text("\(viewModel.portfolioGain.asCurrencyWith2DecimalsPortfolio())$")
                                .foregroundColor(viewModel.portfolioGain >= 0 ? .green : .red)
            }
        }
        .font(.caption)
        .padding()
    }
    
}
