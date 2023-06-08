//
//  ContentView.swift
//  WeSplit
//
//  Created by Eastwood on 23.05.2023.
//

import SwiftUI

struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var people = 2
    @State private var tipPercent = 20


    @FocusState private var amountIsFocused: Bool

    let tipPercentages = [10, 15, 20, 25, 0]

    var totalAmount: Double {
        let tipValue = checkAmount / 100 * Double(tipPercent)
        let totalAmount = checkAmount + tipValue

        return totalAmount
    }

    var totalPerPerson: Double {
        let peopleCount = Double(people + 2)
        let tipSelection = Double(tipPercent)
        let tipValue = checkAmount / 100 * tipSelection
        let grandTotal = checkAmount + tipValue
        let amountPerPerson = grandTotal / peopleCount

        return amountPerPerson
    }

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Amount", value: $checkAmount, format: dollarFormat)
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                    Picker("Number of people", selection: $people) {
                        ForEach(2..<100) {
                            Text("\($0) people")
                        }
                    }
                }

                Section {
                    Picker("Tip percentage", selection: $tipPercent) {
                        ForEach(0..<100) {
                            Text($0, format: .percent)
                        }
                    }
                    .pickerStyle(.navigationLink)
                } header: {
                    Text("How much tip do you want to leave?")
                }

                Section {
                    Text(totalAmount, format: dollarFormat)
                } header: {
                    Text("Total amount")
                        .foregroundColor(tipPercent == 0 ? .red : .black)
                }

                Section {
                    Text(totalPerPerson, format: dollarFormat)
                } header: {
                    Text("Amount per person")
                }
            }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()

                    Button("Done") {
                        amountIsFocused = false
                    }
                }
            }
        }
    }
}

var dollarFormat: FloatingPointFormatStyle<Double>.Currency {
    return FloatingPointFormatStyle<Double>.Currency(code: Locale.current.currencyCode ?? "USD")
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
