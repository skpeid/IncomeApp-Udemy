//
//  TransactionView.swift
//  IncomeApp
//
//  Created by Kuanysh Auyelgazy on 18.08.2025.
//

import SwiftUI

struct TransactionView: View {
    let transaction: Transaction
    
    var body: some View {
        HStack {
            Image(systemName: transaction.type == .income ? "arrow.up" : "arrow.down")
                .foregroundStyle(transaction.type == .income ? .green : .red)
                .font(.system(size: 16, weight: .bold))
                .padding(.trailing)
            HStack() {
                VStack(alignment: .leading) {
                    Text(transaction.title)
                        .font(.system(size: 18, weight: .bold))
                        .padding(.vertical, 4)
                    Text("\(transaction.date, style: .date)")
                        .font(.system(size: 16, weight: .light))
                }
                Spacer()
                Text("\(transaction.amount) KZT")
                    .font(.system(size: 16, weight: .semibold))
                    .foregroundStyle(transaction.type == .income ? .green : .red)
            }
        }
    }
}

#Preview {
    TransactionView(transaction: Transaction(title: "Salary", amount: 999999, type: .income, date: Date()))
}
