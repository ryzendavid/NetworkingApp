//
//  TipCalculatorView.swift
//  NetworkingApp
//
//  Created by David Adekunle on 03/03/2025.
//

import SwiftUI

struct TipCalculatorView: View {
    
    @State private var enteredAmount: String = ""
    @State private var tipAmount: Double = 0
    @State private var totalAmount: Double = 0
    @State private var tipSlider: Double = 15
    var body: some View {
        VStack {
            VStack {
                Text("Enter Bill Amount")
                    .foregroundStyle(.secondary)
                
                TextField("0.00", text: $enteredAmount)
                    .font(.largeTitle)
                    .keyboardType(.decimalPad)
                    .multilineTextAlignment(.center)
            }
            
            Text("Tip: \(tipSlider, specifier: "%.0f")%")
            
            Slider(value: $tipSlider, in: 0...100, step: 1)
                .onChange(of: tipSlider){
                    guard let amount = Double(enteredAmount) else{
                        print("Invalid Entry")
                        return
                    }
                    
                    guard let tip = calculateTip(of: amount, with: tipSlider)else {
                        print("Amount cannot be negative")
                        return
                    }
                    
                    tipAmount = tip
                    totalAmount = amount + tip
                }
                
            VStack(spacing: 20){
                
                Text(tipAmount, format: .currency(code: "GBP"))
                    .font(.largeTitle.bold())
                
                Text(totalAmount, format: .currency(code: "GBP"))
                    .font(.largeTitle.bold())
                
                Text("Total")
                    .foregroundStyle(.secondary)
                    .font(.caption)
            }
            
        }
        .padding(.horizontal)
        
        
    }
    func calculateTip(of enteredAmount: Double, with tip: Double) -> Double? {
        guard enteredAmount >= 0 && tip >= 0 else{
            return nil
        }
        let tipPercentage = tip/100
        return enteredAmount * tipPercentage
    }
    
}

#Preview {
    TipCalculatorView()
}


