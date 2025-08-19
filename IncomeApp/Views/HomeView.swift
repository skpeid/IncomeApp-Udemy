//
//  ContentView.swift
//  IncomeApp
//
//  Created by Kuanysh Auyelgazy on 18.08.2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions = [
        Transaction(title: "Butterfly", amount: 1411089, type: .expense, date: Date()),
        Transaction(title: "Bayonet M9", amount: 845980, type: .expense, date: Date())
    ]
    
    @State private var editTransaction = false
    @State private var transactionToEdit: Transaction?
    
    fileprivate func FloatingButton() -> some View {
        VStack {
            Spacer()
            NavigationLink {
                AddTransactionView(transactions: $transactions)
            } label: {
                Text("+")
                    .font(.largeTitle)
                    .frame(width: 75, height: 75)
                    .foregroundStyle(.white)
                    .padding(.bottom, 7)
            }
            .background(.black)
            .clipShape(Circle())
        }
    }
    
    fileprivate func BalanceView() -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8)
                .fill(.balanceBackground)
            VStack(alignment: .leading) {
                HStack {
                    Text("BALANCE")
                        .foregroundStyle(.white)
                        .font(.caption)
                        .padding(.top)
                    Spacer()
                }
                Text("2 000 000 KZT")
                    .foregroundStyle(.white)
                    .font(.system(size: 42, weight: .light))
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Expenses")
                            .foregroundStyle(.white)
                        Text("999 999 KZT")
                            .foregroundStyle(.red)
                            .fontWeight(.semibold)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .foregroundStyle(.white)
                        Text("999 999 KZT")
                            .foregroundStyle(.green)
                            .fontWeight(.semibold)
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
        .shadow(radius: 10)
        .frame(height: 150)
        .padding()
    }
    var body: some View {
        NavigationStack {
            ZStack {
                VStack {
                    BalanceView()
                    List {
                        ForEach(transactions) { transaction in
                            Button {
                                editTransaction.toggle()
                            } label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            }

                        }
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingButton()
            }
            .navigationTitle("Home")
//            .navigationDestination(item: , destination: { transaction in
//                AddTransactionView(transactions: $transactions, transaction: transaction)
//            })
            .navigationDestination(isPresented: $editTransaction) {
                AddTransactionView(transactions: $transactions)
            }
        }
    }
}

#Preview {
    HomeView()
}
