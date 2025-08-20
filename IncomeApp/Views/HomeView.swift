//
//  ContentView.swift
//  IncomeApp
//
//  Created by Kuanysh Auyelgazy on 18.08.2025.
//

import SwiftUI

struct HomeView: View {
    
    @State private var transactions = [
        Transaction(title: "Lunch", amount: 2500, type: .expense, date: Date()),
        Transaction(title: "Salary", amount: 320000, type: .income, date: Date()),
        Transaction(title: "Internet", amount: 16900, type: .expense, date: Date())
    ]
    
    @State private var showAddTransactionView = false
    @State private var transactionToEdit: Transaction?
    
    private var expenses: String {
        let totalExpenses = transactions.filter({ $0.type == .expense }).reduce(0) { $0 + $1.amount }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: totalExpenses as NSNumber) ?? "0 KZT"
    }
    
    private var income: String {
        let totalIncome = transactions.filter( { $0.type == .income }).reduce(0) { $0 + $1.amount }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: totalIncome as NSNumber) ?? "0 KZT"
    }
    
    private var balance: String {
        var totalBalance = 0
        for transaction in transactions {
            if transaction.type == .income {
                totalBalance += transaction.amount
            } else {
                totalBalance -= transaction.amount
            }
        }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: totalBalance as NSNumber) ?? "0 KZT"
    }
    
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
                Text(balance + " KZT")
                    .foregroundStyle(.white)
                    .font(.system(size: 42, weight: .light))
                HStack(spacing: 20) {
                    VStack(alignment: .leading) {
                        Text("Expenses")
                            .foregroundStyle(.white)
                        Text(expenses + " KZT")
                            .foregroundStyle(.red)
                            .fontWeight(.semibold)
                    }
                    VStack(alignment: .leading) {
                        Text("Income")
                            .foregroundStyle(.white)
                        Text(income + " KZT")
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
                                transactionToEdit = transaction
                            } label: {
                                TransactionView(transaction: transaction)
                                    .foregroundStyle(.black)
                            }
                        }
                        .onDelete(perform: delete)
                    }
                    .scrollContentBackground(.hidden)
                }
                FloatingButton()
            }
            .navigationTitle("Home")
            .navigationDestination(item: $transactionToEdit, destination: { transaction in
                AddTransactionView(transaction: transaction, transactions: $transactions)
            })
            .navigationDestination(isPresented: $showAddTransactionView) {
                AddTransactionView(transactions: $transactions)
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        transactions.remove(atOffsets: offsets)
    }
}

#Preview {
    HomeView()
}
