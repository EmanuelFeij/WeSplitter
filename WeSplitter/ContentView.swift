//
//  ContentView.swift
//  WeSplitter
//
//  Created by Emanuel Feijó on 15/06/2023.
//

import SwiftUI


struct ContentView: View {
    @State private var checkAmount = 0.0
    @State private var numOfPeople = 2
    @State private var tipPercentage = 20
    
    @FocusState private var amountIsFocused: Bool
    
    let tipsPercentages : [Int] = [0, 10, 15,20, 25]
    
    var totalPerson : Double {
        let peopleCount = Double(numOfPeople + 2)
        let tipPercentage = Double(tipPercentage)
        
        let tipValue = checkAmount * (tipPercentage / 100)
        let allTotal = checkAmount + tipValue
        
        return allTotal / peopleCount
    }
    
    var body: some View {
        NavigationStack{
                Form {
                    Section{
                        TextField("Amount",value: $checkAmount,
                            format: .currency(code: Locale.current.currency?.identifier ?? "USD")
                        )
                        .keyboardType(.decimalPad)
                        .focused($amountIsFocused)
                        
                        Picker("Number of People", selection: $numOfPeople) {
                            ForEach(2..<100){
                                Text("\($0) People")
                            }
                        }
                    }
                    Section () {
                        Picker("Tip Percentage", selection: $tipPercentage){
                            ForEach(tipsPercentages, id: \.self){
                                Text("\($0)%")
                            }
                        }.pickerStyle(.segmented)
                    } header: {
                        Text("How much do you want to leave ?")
                    }
                    
                    Section {
                        Text(totalPerson, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                    }
                }
            .navigationTitle("WeSplit")
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Spacer()
                    Button("Done") {
                        amountIsFocused.toggle()
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
