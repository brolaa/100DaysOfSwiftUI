//
//  ContentView.swift
//  iExpense
//
//  Created by Bartosz Rola on 15/02/2023.
//

import SwiftUI

struct ContentView: View {
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false
    
    var currencyFormatter: FloatingPointFormatStyle<Double>.Currency {
        let currencyCode = Locale.current.currency?.identifier ?? "USD"
        
        return FloatingPointFormatStyle<Double>.Currency(code: currencyCode)
    }
    
    let types = ["Personal", "Business"]
    
    var body: some View {
        NavigationView {
            List {
                ForEach(types, id: \.self) { type in
                    Section(type) {
                        ForEach(expenses.getExpensesForType(type)) { item in
                            HStack {
                                VStack(alignment: .leading) {
                                    Text(item.name)
                                        .font(.headline)
                                    Text(item.type)
                                }
                                
                                Spacer()
                                
                                Text(item.amount, format: currencyFormatter)
                            }
                            .listRowBackground(expenseColor(amount: item.amount))
                            .accessibilityElement()
                            .accessibilityLabel("\(item.name), \(item.amount, format: currencyFormatter)")
                            .accessibilityHint(item.type)
                        }
                        .onDelete{ indexSet in expenses.removeExpense(offsets: indexSet, type: type)}
                    }
                }
            }
            .navigationTitle("iExpense")
            .toolbar {
                Button {
                    showingAddExpense = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: expenses, currencyFormatter: currencyFormatter)
            }
        }
    }
    
    func removeItems(at offsets: IndexSet) {
        print(offsets)
        //expenses.items.remove(atOffsets: offsets)
    }
    
    func expenseColor(amount: Double) -> Color {
        if amount < 10 {
            return Color.green
        } else if amount < 100 {
            return Color.yellow
        } else {
            return Color.orange
        }
    }
    
    func typeExpenses(type: String) -> [ExpenseItem] {
        expenses.items.filter {
            $0.type == type
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

/*
 List {
     ForEach(expenses.items) { item in
         HStack {
             VStack(alignment: .leading) {
                 Text(item.name)
                     .font(.headline)
                 Text(item.type)
             }
             
             Spacer()
             
             Text(item.amount, format: currencyFormatter)
         }
         .listRowBackground(expenseColor(amount: item.amount))
     }
     .onDelete(perform: removeItems)
 */
