//
//  ContentView.swift
//  Wesplit
//
//  Created by Liping Mechling on 20/12/2020.
//

import SwiftUI

// Using @State and $ sign for two-way binding
struct ContentView: View {
    @State private var totalAmount = ""
    @State private var totalPerson = 2
    @State private var tipPercentage = 2
    let tipPercentages = [10, 15, 20, 25, 0]
    
    // a computed property:
    var totalAmountByPerson: Double {
        // totalPerson counts from 0 in the array from 0 to 99
        let personCount = Double(totalPerson + 2) //this is to match the 4 in the 2 ..< 100
        let tipSelected = Double(tipPercentages[tipPercentage])
        let totalToPay = Double(totalAmount) ?? 0
        
        let tipValue = totalToPay * (tipSelected / 100)
        let grandTotal = totalToPay + tipValue
        
        let totalAmountByPerson = grandTotal / personCount
        
        return totalAmountByPerson
    }
    
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Enter the amout:", text: $totalAmount)
                        .keyboardType(.decimalPad)
                    Picker("Number of people:", selection: $totalPerson) {
                        ForEach(2 ..< 100) {
                            Text("\($0) people")
                            //here shows 4 people because totalPerson = 2, and it's the [2] in the array(2 ..< 100)
                        }
                    }
                }
                Section(header: Text("How much tips do you leave?")) {
                    Picker("Tip percentage:", selection: $tipPercentage) {
                        ForEach(0 ..< tipPercentages.count) {
                            Text("\(self.tipPercentages[$0])%")
                            //Picker is a function, self means it's from the params
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }
                
                Section {
                    Text("$\(totalAmountByPerson, specifier: "%.2f")")
                }
            }.navigationBarTitle("WeSplit")
        }
 
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
