//
// ContentView.swift
// WeSplit
//
// Created by Richard Rich on 2/1/2024.
//
import SwiftUI
struct ContentView: View {
@State private var checkAmount = 0.0
@State private var numberOfPeople = "2"
@State private var tipPercentage = 20
@FocusState private var amountIsFocused: Bool
let tipPercentages = [10, 15, 20, 25, 0]
var totalPerPerson: Double {
let peopleCount = Double(numberOfPeople) ?? 0
let tipSelection = Double(tipPercentage)
let tipValue = checkAmount / 100 * tipSelection
let grandTotal = checkAmount + tipValue
let amountPerPerson = grandTotal / (peopleCount > 0 ? peopleCount : 1)
return amountPerPerson
}
var checkGrandTotal: Double {
let tipSelection = Double(tipPercentage)
let tipValue = checkAmount / 100 * tipSelection
let grandCheckTotal = checkAmount + tipValue
return grandCheckTotal
}
var body: some View {
NavigationView {
Form {
Section(header: Text("Enter check details")) {
TextField("Amount", value: $checkAmount, format: .currency(code: Locale.current.currency?.identifier ??
"USD"))
.keyboardType(.decimalPad)
.focused($amountIsFocused)
TextField("Number of people", text: $numberOfPeople)
.keyboardType(.numberPad)
}
Section(header: Text("How much do you want to tip?")) {
Picker("Tip percentage", selection: $tipPercentage) {
ForEach(tipPercentages, id: \.self) {
Text("\($0)%")
}
}.
pickerStyle(.segmented)
}
Section(header: Text("Amount per person")) {
Text("$\(totalPerPerson, specifier: "%.2f")")
}
Section(header: Text("Total Check Amount")) {
Text("$\(checkGrandTotal, specifier: "%.2f")")
}
}.
navigationTitle("WeSplit")
.toolbar {
ToolbarItem(placement: .keyboard) {
Button("Done") {
amountIsFocused = false
}
}
}
}
}
}
struct ContentView_Previews: PreviewProvider {
static var previews: some View {
ContentView()
}
}

