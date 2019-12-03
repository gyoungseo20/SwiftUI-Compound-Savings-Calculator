//
//  ContentView.swift
//  SavingsCalc
//
//  Created by Conner Tate on 13/11/19.
//  Copyright © 2019 Conner Tate. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    //VARIABLES
    @State private var initialDeposit = ""
    @State private var monthlyAddition = ""
    @State private var apr = ""
    @State private var duration = 2
    
    let years = [1, 2, 3, 4, 5, 10, 15, 20, 30, 40, 50]
    
    var totalValue: Double {
        let initial = Double(initialDeposit) ?? 0
        let monthly = Double(monthlyAddition) ?? 0
        var aprValue = Double(apr) ?? 0
        aprValue += 1.0
        let time = years[duration]
        return Double(recursiveInterest(total: initial, years: time, monthly: monthly, apr: aprValue))
    }
    
    //GLOBAL FUNCTIONS
    func recursiveInterest(total: Double, years: Int, monthly: Double, apr: Double) -> Double {
        var newTotal = total
        let interest = monthly * 12
        newTotal += interest
        newTotal *= apr
        
        if (years == 1){
            return newTotal
        }else{
            return recursiveInterest(total: newTotal, years: years-1, monthly: monthly, apr: apr)
        }
    }
    
    //STYLING
    struct PrimaryLabel: ViewModifier {
        func body(content: Content) -> some View {
            content
                .foregroundColor(Color.green)
        }
    }

    //CONTENT BODY
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Initial Deposit")) {
                    TextField("Amount", text: $initialDeposit)
                    .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Monthly Addition")) {
                    TextField("Amount", text: $monthlyAddition)
                    .keyboardType(.decimalPad)
                }
                
                Section(header: Text("Annual Percentage Rate (in decimal)")) {
                    TextField("Amount", text: $apr)
                    .keyboardType(.decimalPad)
                }
                
                Section (header: Text("How many years?")) {
                    Picker("Duration", selection: $duration){
                        ForEach(0 ..< years.count) {
                            Text("\(self.years[$0])")
                        }
                    }.pickerStyle(SegmentedPickerStyle())
                }
                
                Section(header: Text("Total")) {
                    Text("$\(totalValue, specifier: "%.2f")")
                }
                
                }.navigationBarTitle("Savings Calculator").modifier(PrimaryLabel())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
