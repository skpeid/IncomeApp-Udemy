//
//  Transaction.swift
//  IncomeApp
//
//  Created by Kuanysh Auyelgazy on 18.08.2025.
//

import Foundation

struct Transaction: Identifiable, Hashable {
    let id = UUID()
    let title: String
    let amount: Int
    let type: TransactionType
    let date: Date
}
