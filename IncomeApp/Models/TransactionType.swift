//
//  TransactionType.swift
//  IncomeApp
//
//  Created by Kuanysh Auyelgazy on 18.08.2025.
//

import Foundation

enum TransactionType: String, CaseIterable, Identifiable {
    case income
    case expense
    
    var id: Self { self }
    
    var title: String {
        switch self {
        case .income:
            return "Income"
        case .expense:
            return "Expense"
        }
    }
}
