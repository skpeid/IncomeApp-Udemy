//
//  AddTransactionView.swift
//  IncomeApp
//
//  Created by Kuanysh Auyelgazy on 18.08.2025.
//

import SwiftUI

struct AddTransactionView: View {
    
    var transaction: Transaction?
    
    @State private var amount = 0
    @State private var title = ""
    @State private var selectedTransactionType: TransactionType = .expense
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showAlert = false
    
    @Binding var transactions: [Transaction]
    @Environment(\.dismiss) var dismiss
    
    var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        return formatter
    }
    
    var body: some View {
        VStack {
            TextField("0", value: $amount, formatter: numberFormatter)
                .font(.system(size: 60, weight: .thin))
                .multilineTextAlignment(.center)
                .keyboardType(.numberPad)
            Divider()
                .padding(.horizontal, 75)
            Picker("Choose Type", selection: $selectedTransactionType) {
                ForEach(TransactionType.allCases) { type in
                    Text(type.title)
                        .tag(type)
                }
            }
            TextField("Transaction Title", text: $title)
                .font(.system(size: 15))
                .textFieldStyle(.roundedBorder)
                .padding(.horizontal, 50)
            Button {
                guard title.count >= 2 else {
                    alertTitle = "Invalid Title"
                    alertMessage = "Title must be at least 2 characters long"
                    showAlert = true
                    return
                }
                let newTransaction = Transaction(title: title, amount: amount, type: selectedTransactionType, date: Date())
                transactions.append(newTransaction)
                dismiss()
                
            } label: {
                Text("Create")
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.white)
                    .frame(maxWidth: .infinity)
                    .frame(height: 40)
                    .background(Color.balanceBackground)
                    .clipShape(RoundedRectangle(cornerRadius: 6))
            }
            .padding(.top)
            .padding(.horizontal, 50)
        }
        .onAppear(perform: {
            if let transaction = transaction {
                title = transaction.title
                amount = transaction.amount
                selectedTransactionType = transaction.type
            }
        })
        .alert(alertTitle, isPresented: $showAlert) {
            Button {
                
            } label: {
                Text("OK")
            }

        } message: {
            Text(alertMessage)
        }

    }
}

#Preview {
    AddTransactionView(transactions: .constant([]))
}
